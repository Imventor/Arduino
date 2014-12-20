import oscP5.*;              //Libreria OSC P5
import netP5.*;              //Libreria net P5                                      
import processing.serial.*;  //Libreria del Serial
Serial ArduinoPort;          //Asignar la variable como serial
OscP5 oscP5;                 //Asignar oscP5 como conexion de OSC
NetAddress iPad;
  
int value1 = 0;              // Valor inicial de la variable


void setup(){

size(300,100);  
noStroke(); 
frameRate(30);  
frame.setTitle("Jo Automation © 2014 Ivan Martinez");  // El titulo de la ventana multicolor
println(Serial.list());                                // Mostramos la lista de seriales disponibles
ArduinoPort = new Serial(this, Serial.list()[0],9600); // Ajustamos el puerto para el arduino en 9600 senales por segundo
oscP5 = new OscP5(this, 8000);                         // Iniciamos oscP5, Para escuchar en el puerto 8000 

}

void oscEvent(OscMessage theOscMessage){               // Ejecutar esta accion si existe un evento de TouchOSC

String addr = theOscMessage.addrPattern();             // Creamos una cadena de salida para el mensaje de OSC

if(addr.indexOf("/1/toggle") != -1){                   //  Si el valor de toggle en la pagina 1 cambia
  
 value1 = int(theOscMessage.get(0).floatValue());      // Guardamos el valor del boton en la variable
 
  if(value1 == 0){                                     //  Comparamos el resultado
    ArduinoPort.write("0");                            // Enviamos un 0 al arduino
  }
  
 if(value1 == 1){                                     // Comparamos el resultado
  ArduinoPort.write("1");                             // Enviamos un 1 al Arduino
  }
 
 println("Led: " + value1);                           // Escribimos el estado 

 }


}

void draw(){                                         // Solo una ventana multicolor

background(random(255), random(255), random(255));

}
