#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <WebSocketsServer.h>


WebSocketsServer webSocket = WebSocketsServer(81);  //websocket init with port 81

bool on = true;
bool connect = false;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);

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

  webSocket.begin();
  webSocket.onEvent(webSocketEvent);


  WiFi.printDiag(Serial);
  Serial.println(WiFi.localIP());

  on = true;
  digitalWrite(LED_BUILTIN, LOW);
}


void loop() {
  webSocket.loop();
}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t* payload, size_t length) {
  //webscket event method
  String cmd = "";
  switch (type) {
    case WStype_DISCONNECTED:
      Serial.println("Websocket is disconnected");
      //case when Websocket is disconnected
      break;
    case WStype_CONNECTED:
      {
        //wcase when websocket is connected
        Serial.println("Websocket is connected");
        Serial.println(webSocket.remoteIP(num).toString());
        webSocket.sendTXT(num, "connected");
      }
      break;
    case WStype_TEXT:
      cmd = "";
      for (int i = 0; i < length; i++) {
        cmd = cmd + (char)payload[i];
      }  //merging payload to single string
      Serial.println(cmd);

      if (cmd == "poweron") {        //when command from app is "poweron"
        digitalWrite(LED_BUILTIN, LOW);  //make ledpin output to HIGH
      } else if (cmd == "poweroff") {
        digitalWrite(LED_BUILTIN, HIGH);  //make ledpin output to LOW on 'pweroff' command.
      }

      webSocket.sendTXT(num, "success");
      //send response to mobile, if command is "poweron" then response will be "poweron:success"
      //this response can be used to track down the success of command in mobile app.
      break;
    case WStype_FRAGMENT_TEXT_START:
      break;
    case WStype_FRAGMENT_BIN_START:
      break;
    case WStype_BIN:
      hexdump(payload, length);
      break;
    default:
      break;
  }
}
