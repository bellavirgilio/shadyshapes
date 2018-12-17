import canoninput as ci
import processshadow as ps
import os
import sys

# This calls the takeTenImgs function from canoninput and also calls
# the make_sprite_sheet function from processshadow
def createSprite(input_dir):
    input_color = input_dir.lower();
    if input_color == "red":
        color = [0, 33, 166]
    elif input_color == "green":
        color = [0, 153, 0]
    elif input_color == "blue":
        color = [225, 0, 0]
    elif input_color == "yellow":
        color = [7, 231, 255]
    else:
        color = [0, 0, 0]
        print("ERROR: No block color specified.")
        
    takeSevenImgs(input_color)
    output_dir = input_color + "_output"
    ps.make_sprite_sheet(input_color, output_dir, color) 

# This uses the function in canoninput called func_TakeCanonPicture
# and takes ten frames to create the sprite
# It puts everything in the specified directory.
def takeSevenImgs(input_dir):
    if not os.path.exists(input_dir):
        os.makedirs(input_dir)
    print(os.getcwd())
    i = 0
    while i < 3:
        filename = input_dir + "/" + str(i) + ".png"
        ci.func_TakeCanonPicture(filename)
        i += 1

def main():
    # output_dir = r"C:\Users\Parul Koul\Desktop\cs320\shady_shapes_tui\shadyshapes\record\data\camera-input\hallway3_output"
    print("Reached main of createSprite.")
    if len(sys.argv) < 2:
        print("No input folder specified in command line args.")
    else:
        createSprite(sys.argv[1])


if __name__ == '__main__':
    main()
