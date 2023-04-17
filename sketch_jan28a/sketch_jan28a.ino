#include <FastLED.h>
#include <ESP8266WiFi.h>
#include <EEPROM.h>
#include <WiFiUdp.h>
#include <ESP8266WebServer.h>
// #define FASTLED_ESP8266_D1_PIN_ORDER


// void setup() {
//   WiFi.mode(WIFI_STA);
//   WiFi.begin(ssid, pass);

//   while (WiFi.status() != WL_CONNECTED) {
//     delay(500);
//   }
//   Serial.println(WiFi.localIP());

//   wifiServer.begin();
// }

// void loop() {
//   client = wifiServer.available();
//   String command = "";
//   if (client) {
//     while (client.connected()) {
//       while (client.available() > 0) {
//         char c = client.read();  /// Read from client
//         if (c == '\n') {
//           break;
//         }

//         command += c;
//       }

//       if (command == "Hello") {
//         client.write("And you");
//       }
//       command = "";
//       delay(10);
//     }
//     client.stop();
//   }
// }

// void writeAuthData(String name, String pass) {
//   int nameLen = name.length();
//   EEPROM.write(0, nameLen);
//   for (int i = 0; i < nameLen; i++) {
//     EEPROM.write(1 + i, name[i]);
//   }

//   int passLen = pass.length();
//   EEPROM.write(nameLen + 2, passLen);
//   for (int i = 0; i < passLen; i++) {
//     EEPROM.write(nameLen + 3 + i, pass[i]);
//   }
// }

// String* readAuthData() {

//   String name;
//   int nameLen = EEPROM.read(0);

//   if(nameLen == 255){
//     String array[1] = {""};
//     return array;
//   }

//   name.reserve(nameLen);

//   for (int i = 0; i < nameLen; i++) {
//     name += (char)EEPROM.read(1 + i);
//   }

//   String pass;
//   int passLen = EEPROM.read(nameLen + 2);
//   name.reserve(passLen);

//   for (int i = 0; i < passLen; i++) {
//     pass += (char)EEPROM.read(nameLen + 3 + i);
//   }
//   String array[2] = {name, pass};
//   return array;
// }

// bool checkAuthData(){
//   int nameLen = EEPROM.read(0);

//   if(nameLen == 255){
//     return false;
//   }

//   return true;
//}

ESP8266WebServer server(80);
#define NUM_LEDS 16
#define PIN D1
CRGB leds[NUM_LEDS];
WiFiServer wifiServer(80);
WiFiClient client;
void handle404();
bool on = true;
bool connect = false;
byte bright = 25;
byte brightness = 50;
int color = 255;
int saturation = 0;
byte mode = 1;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
  FastLED.addLeds<WS2812, PIN, GRB>(leds, NUM_LEDS)
  //.setCorrection( TypicalSMD5050 );
  .setCorrection(TypicalPixelString);

  for (int j = 25; j <= brightness; j += 250 / 10) {
    for (int i = 15; i >= 0; i--) {
      leds[i] = CHSV(color, 255, 0);
      FastLED.show();
    }
  }
  Serial.begin(115200);

  WiFi.disconnect(true);
  delay(200);  // remove wifi details stored already
  WiFi.mode(WIFI_STA);

  WiFi.beginSmartConfig();
  while (WiFi.status() != WL_CONNECTED) {
    connect = false;
    Serial.println(".");
    digitalWrite(LED_BUILTIN, LOW);
    delay(250);

    digitalWrite(LED_BUILTIN, HIGH);
    delay(250);
    while (!connect) {
      digitalWrite(LED_BUILTIN, LOW);
      delay(500);

      digitalWrite(LED_BUILTIN, HIGH);
      delay(500);

      if (WiFi.smartConfigDone()) {
        Serial.println("SmartConfig Success");
        connect = true;
      }
    }
  }

  //Server-Setup
  server.on("/turn", HTTP_POST, handleTurnControl);
  server.on("/intensity", HTTP_POST, handleIntensityControl);
  server.on("/color", HTTP_POST, handleColorControl);
  server.on("/mode", HTTP_POST, handleModeControl);

  server.begin();

  WiFi.printDiag(Serial);
  Serial.println(WiFi.localIP());
  Serial.println(WiFi.broadcastIP());

  on = true;
  digitalWrite(LED_BUILTIN, LOW);
  for (int j = 25; j <= brightness; j += 255 / 10) {
    for (int i = 15; i >= 0; i--) {
      leds[i] = CHSV(color, 0, j);
      FastLED.show();
    }
  }
}


// void loop() {
//   // Check if a client has connected
//   // Udp.parsePacket();
//   // while (Udp.available()) {
//   //   Serial.println(Udp.remoteIP());
//   //   Udp.flush();
//   //   delay(5);
//   // }

//   client = wifiServer.available();
//   String command = "";
//   if (client) {
//     while (client.connected()) {
//       while (client.available() > 0) {
//         char c = client.read();  /// Read from client
//         if (c == '\n') {
//           break;
//         }

//         command += c;
//       }

//       if (command == "Hello") {
//         if (on) {
//           digitalWrite(LED_BUILTIN, HIGH);
//           on = false;
//         } else {
//           digitalWrite(LED_BUILTIN, LOW);
//           on = true;
//         }

//         client.write("And you");
//       }
//       command = "";
//       delay(10);
//     }
//     client.stop();
//   }
// }

void loop() {
  server.handleClient();
}
void handleTurnControl() {
  if (!server.hasArg("data") || server.arg("data") == NULL) {
    server.send(400, "text/plain", "400: Invalid Request");
    return;
  }
  if (server.arg("data") == "1") {
    for (int j = 25; j <= brightness; j += 25) {
      for (int i = 15; i >= 0; i--) {
        leds[i] = CHSV(color, mode == 0 ? 255 : saturation, j);
        FastLED.show();
      }
    }
    on = true;
  } else {
    for (int j = brightness; j >= 0; j -= 25) {
      for (int i = 15; i >= 0; i--) {
        leds[i] = CHSV(color, mode == 0 ? 255 : saturation, j);
        FastLED.show();
      }
    }
    on = false;
  }
  server.send(200, "text/plain");
}

void handleModeControl() {
  if (!server.hasArg("data") || server.arg("data") == NULL) {
    server.send(400, "text/plain", "400: Invalid Request");
    return;
  }
  if (server.arg("data") == "1") {
    mode = 1;
  } else {
    mode = 0;
  }

  server.send(200, "text/plain");
}

void handleIntensityControl() {
  if (!server.hasArg("data") || server.arg("data") == NULL) {
    server.send(400, "text/plain", "400: Invalid Request");
    return;
  }
  if (server.arg("data") != "" && on) {
    int newBrightness = server.arg("data").toInt();
    if (newBrightness > brightness) {
      for (int j = brightness; j <= newBrightness; j += 25) {
        for (int i = 15; i >= 0; i--) {
          leds[i] = CHSV(color, mode == 0 ? 255 : saturation, j);
          FastLED.show();
        }
      }
    } else if (newBrightness < brightness) {
      for (int j = brightness; j >= newBrightness; j -= 25) {
        for (int i = 15; i >= 0; i--) {
          leds[i] = CHSV(color, mode == 0 ? 255 : saturation, j);
          FastLED.show();
        }
      }
    }
    brightness = server.arg("data").toInt();
    server.send(200, "text/plain");
  } else {
    handle404();
  }
}

void handleColorControl() {
  if ((!server.hasArg("hue") || server.arg("hue") == NULL) && (!server.hasArg("sat") || server.arg("sat") == NULL)) {
    server.send(400, "text/plain", "400: Invalid Request");
    Serial.println('colorError');
    return;
  }
  Serial.println(server.arg("hue"));
  Serial.println(server.arg("sat"));
  if (server.arg("hue") != "" && server.arg("sat") != "" && on) {
    int newColor = server.arg("hue").toInt();
    int newSaturation = server.arg("sat").toInt();
    for (int i = 15; i >= 0; i--) {
      leds[i] = CHSV(newColor, mode == 0 ? 255 : newSaturation, brightness);
      FastLED.show();
    }
    saturation = newSaturation;
    color = newColor;
    server.send(200, "text/plain");
  } else {
    handle404();
  }
}

void handle404() {
  server.send(404, "text/plain", "404: Not found");
}