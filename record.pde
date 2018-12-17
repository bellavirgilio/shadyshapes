/** 
 * Python Command (v1.0.1)
 * GoToLoop (2017/Jul/05)
 *
 * https://Forum.Processing.org/two/discussion/23324/
 * executing-python-3-code-from-within-processing/p1#Item_9
 *
 * https://GitHub.com/GoToLoop/command/blob/patch-1/src/
 * deadpixel/command/Command.java
 */
 
import deadpixel.command.Command;
Command cmd;
 
static final String APP  = "python ";
static final String FILE = "camera-input/createSprite.py";

//void setup() {
//  record("GREEN");
//}

//void draw() {
  
//}

// Pass the color of the block as an argument to the function
// Using clr instead of color because color is a keyword in Processing
void record(String clr) {
  
  // adds a space to the front to format the command line argument properly
  String clr_arg = " " + clr;
  final String path = '"' + dataPath(FILE) + '"';
  
  // the final command line argument that is executed
  println(APP + path);
  cmd = new Command(APP + path + clr_arg );
  println(cmd.command);
  cmd.run();
  println("Success:", cmd.success);
  printArray(cmd.getOutput());
  //exit();
}
