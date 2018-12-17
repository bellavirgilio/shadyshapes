import cv2;
import os;
import numpy as np;


def make_sprite_sheet(input_folder, output_folder, color):
    i = 0
    if not os.path.exists(input_folder):
        print("Error: Input folder does not exist.")
    elif not os.path.exists(output_folder):
        os.makedirs(output_folder)
    num_images = len([name for name in os.listdir(input_folder) if os.path.isfile(input_folder + "/" + name)])
    while (i < num_images):
        input_name = input_folder + "/" + str(i) + ".png"
##        print("input path:" + input_name)
        output_name = output_folder + "/" + str(i) + ".png"
        process_individual_shadow(input_name, output_name, color)
        i += 1
 
    
# The following code reads in a shadow image, converts it into a binary
# image and floodfills it based on a specified color.
# input_path: where the input image is stored
# output_path: where the output image is stored

def process_individual_shadow(input_path, output_path, color):
    
    # Read image
    im_in = cv2.imread(input_path, cv2.IMREAD_GRAYSCALE);
    small = cv2.resize(im_in, (0,0), fx=0.5, fy=0.5) 

    # Remove mesh effect if any.
    #blur = cv2.bilateralFilter(im_in,9,75,75)
    #cv2.imshow("Test on blur", blur)
     
    # Threshold.
    # Set values equal to or above 220 to 0.
    # Set values below 220 to 255.
     
    th, im_th = cv2.threshold(small, 40, 255, cv2.THRESH_BINARY_INV);
     
    # Copy the thresholded image.
    im_floodfill = im_th.copy()
     
    # Mask used to flood filling.
    # Notice the size needs to be 2 pixels than the image.
    h, w = im_th.shape[:2]
    mask = np.zeros((h+2, w+2), np.uint8)
     
    # Floodfill from point (0, 0)
    cv2.floodFill(im_floodfill, mask, (0,0), 255);
     
    # Invert floodfilled image
    im_floodfill_inv = cv2.bitwise_not(im_floodfill)
     
    # Combine the two images to get the foreground.
    im_foreground = im_th | im_floodfill_inv

    # Invert foreground to get colored sprite and white background
    im_foreground_inv = cv2.bitwise_not(im_foreground)

    # Convert from black on white to specific color
    im_floodfill_inv_color_mod = im_floodfill_inv.copy()
         
    # Display images.
    cv2.imshow("Thresholded Image", im_th)
    #cv2.imshow("Foreground", im_foreground)
    #cv2.imshow("Inverted Foreground", im_foreground_inv)
    cv2.imwrite("final_shadow.png", im_foreground_inv)
    im = cv2.imread('final_shadow.png')
    #im = cv2.cvtColor(im, cv2.COLOR_BGR2RGBA)
    #print("im.shape: ", im.shape)
    im[np.where((im == [0,0,0]).all(axis = 2))] = color
    
    #bg_color = im[0][0]
    #im[np.all(im == bg_color, axis=2)] = [0, 0, 0]
    #print("bg_color: ", bg_color)
    #cv2.imshow("Transparency", im)
    cv2.imwrite(output_path, im)
##    cv2.waitKey(0)
    cv2.imshow("Colored sprite", im)
##    cv2.waitKey(0)

def main():
    input_dir =  r"sprite1"
    output_dir = r"sprite1_output"
    make_sprite_sheet(input_dir, output_dir, [0, 33, 166])
    #print("call the function make_sprite_sheet like this: make_sprite_sheet(input_folder, output_folder, color, num_input_images)")


if __name__ == '__main__':
    main()
