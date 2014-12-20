import oscP5.*;              //Libreria OSC P5
import netP5.*;              //Libreria net P5                                      
import processing.serial.*;  //Libreria del Serial
Serial ArduinoPort;          //Asignar la variable como serial
OscP5 oscP5;                 //Asignar oscP5 como conexion de OSC
NetAddress iPad;
  
int value1 = 0;                
NetAddress myRemoteLocation;

void setup(){

size(300,100);  
noStroke(); 
frameRate(30);  
frame.setTitle("Jo Automation © 2014 Ivan Martinez"); 
println(Serial.list());  
ArduinoPort = new Serial(this, Serial.list()[0],9600);
oscP5 = new OscP5(this, 8000); 
iPad = new NetAddress("192.168.43.46",9000);

}

void oscEvent(OscMessage theOscMessage){ 

String addr = theOscMessage.addrPattern();

if(addr.indexOf("/1/toggle") != -1){
  
 value1 = int(theOscMessage.get(0).floatValue());
 
  if(value1 == 0){        //  If led button 1 if off do....
    ArduinoPort.write("0");    // Sends the character “r” to Arduino 
    OscMessage myMessage = new OscMessage("/1/led1"); 
    myMessage.add(0);
    oscP5.send(myMessage,iPad);
     println("iPad" + myMessage);
  }
  
 if(value1 == 1){        // If led button 1 is ON do...
  ArduinoPort.write("1");    // Send the character “R” to Arduino
  OscMessage myMessage = new OscMessage("/1/led1"); 
    myMessage.add(1);
    oscP5.send(myMessage,iPad);
     println("iPad" + myMessage);
  }
 
 println("Led: " + value1);

 }



}

void draw(){ // No need

background(random(255), random(255), random(255));

}
