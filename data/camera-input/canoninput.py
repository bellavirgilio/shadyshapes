import sys
import os
import subprocess
import datetime

#rawimagename = "C:\Users\Parul Koul\Desktop\cs320\shady_shapes_tui\camera-input\test.png"
rawimagename = "test.png"

def func_TakeCanonPicture(input_filename):
    camera_command = 'C:\Program Files (x86)\digiCamControl\CameraControlCmd.exe'
    camera_command_details = '/filename ./' + input_filename + ' /capture /iso 500 /shutter 1/30 /aperture 1.8'
    print('camera details = ',camera_command_details)
    full_command=camera_command + ' ' + camera_command_details
    p = subprocess.Popen(full_command, stdout=subprocess.PIPE, universal_newlines=True, shell=False)
    (output, err) = p.communicate()  

    #This makes the wait possible
    p_status = p.wait(1)
    # print(p.stdout.readline())

    #This will give you the output of the command being executed
    print('Command output: ' + str(output))
    print('Command err: ' + str(err))

    print('done')
    if(len(sys.argv) < 2):
        input_filename = 'test.jpg'
    else:   
        # sys.argv[0] is the program name, sys.argv[1] is the first file, etc.
        # need to shift this over
        files = sys.argv[1:len(sys.argv)]
        # Read the image
        input_filename = files[0]
        if(os.path.isfile(input_filename) is True):
            print("File exists...not overwriting.")
            sys.exit()

    # Store date/time for file uniqueness
    current_dt=datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    print("Current date time = " + current_dt)
    input_filename=current_dt + '_' + input_filename

    print('Name of raw image will be: ', input_filename)

# take picture
#func_TakeCanonPicture(rawimagename)
