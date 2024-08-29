#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <SoftwareSerial.h>

const char* ssid = "SSID";             // Replace with your Wi-Fi SSID
const char* password = "Password";  // Replace with your Wi-Fi password

ESP8266WebServer server(80);

#define rxPin 5
#define txPin 4

unsigned int lastDistance = 0;

SoftwareSerial jsnSerial(rxPin, txPin);

void setup() {
  jsnSerial.begin(9600);
  Serial.begin(9600);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  // Define REST API endpoint
  server.on("/distance", HTTP_GET, handleDistanceRequest);

  // Serve the index page
  server.on("/", HTTP_GET, handleRoot);

  // Handle 404 errors
  server.onNotFound(handleNotFound);

  // Start the server
  server.begin();
  Serial.println("HTTP server started");
}

void handleDistanceRequest() {
  if (lastDistance > 0) {
    server.send(200, "application/json", "{\"distance\": " + String(lastDistance) + "}");
  } else {
    server.send(500, "application/json", "{\"error\": \"Failed to read distance\"}");
  }
}

void handleRoot() {
  String html = "<html><body><h1>Distance Sensor</h1>";
  html += "<p>Last Distance: " + String(lastDistance) + " mm</p>";
  html += "<p><a href=\"/distance\">REST API</a></p>";
  html += "</body></html>";
  server.send(200, "text/html", html);
}

void handleNotFound() {
  String message = "404 Not Found\n\n";
  message += "The requested URL was not found on this server.";
  server.send(404, "text/plain", message);
}

void loop() {
  server.handleClient();  // Handle incoming client requests
  if (jsnSerial.available()) {
    getDistance();
  }
}

void getDistance() {
  unsigned int distance;
  byte startByte, h_data, l_data, sum = 0;
  byte buf[3];

  startByte = (byte)jsnSerial.read();
  if (startByte == 255) {
    jsnSerial.readBytes(buf, 3);
    h_data = buf[0];
    l_data = buf[1];
    sum = buf[2];
    distance = (h_data << 8) + l_data;
    if (((h_data + l_data)) != sum) {
      Serial.println("Invalid result");
    } else {
      Serial.print("Distance [mm]: ");
      Serial.println(distance);
      lastDistance = distance;
    }
  } else {
    return;
  }
  delay(100);
}
