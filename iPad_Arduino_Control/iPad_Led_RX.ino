int LEDPin = 11;         //  El pin donde esta conectado el LED
int LED = 0;             //  El valor del brillo del led de 0 - 255
int message = 1;         //  Aqui se almacenara el valor del serial
int messageold=0;        //  Para evitar que se repita la misma accion

void setup(){

Serial.begin(9600);      // Iniciamos comunicacion serial a 9600 senales por segundo

}

void loop(){

if(Serial.available() > 0){    // Revisamos si existe algun dato en la comunicacion serial

  message = Serial.read();
if (message != messageold){        //  Verificamos que no sea igual para no repetir la accion
       if (message == '1'){        //  Si tenemos un 1
         LED = 255;                //  Enviamos 255 (on) al led
         Serial.write("LedON");    //  Escribimos que el led esta encendido
       }
       if (message == '0'){        //  Si tenemos un 0
         LED = 0;                  //  Enviamos 0 (off) al led
         Serial.write("LedOFF");   //  Escribimos que el led esta apagado
       }
       messageold=message;         //  Guardamos el estado en el que se encuentra
   }

}
analogWrite(LEDPin, LED);  //  Escribimos el valor guardado en LED 0-255 al pin donde esta conectado el LED
}
