// Hier worden alle nodige libraries toegevoegd.
#include <ESP8266WiFi.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SPI.h>
#include <Wire.h>
#include <Fonts/FreeSans9pt7b.h>
#include <Fonts/FreeSans18pt7b.h>
#include <Fonts/FreeSans12pt7b.h>


/////LOCAL ACCESS POINT INSTELLINGEN/////
// De ESP8266 zal een WiFi netwerk / hotspot aanmaken waar andere apparaten mee kunnen verbinden. De variabele AP_NameChar is de naam van het netwerk / hotspot en WiFiPassword is het wachtwoord van het netwerk.
const char AP_NameChar[] = "StarTracker" ;
const char WiFiPassword[] = "StarTracker";
WiFiServer server(80);
/////LOCAL ACCESS POINT INSTELLINGEN/////


/////ARROW BITMAP/////
// Deze bitmap is een afbeelding die de Arduino kan lezen en omzetten in een foto op een LCD / OLED scherm. De eerste bitmap is de afbeelding van een pijl naar boven en de tweede een pijl naar beneden.
const unsigned char PROGMEM ArrowUp [] = {0x00, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x07, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x0F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x3F, 0xFC, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xFE, 0x00, 0x00, 0x00, 0x00, 0xFB, 0xDF, 0x00, 0x00, 0x00, 0x01, 0xF3, 0xCF, 0x80, 0x00, 0x00, 0x03, 0xE3, 0xC7, 0xC0, 0x00, 0x00, 0x03, 0xC3, 0xC3, 0xC0, 0x00, 0x00, 0x01, 0x83, 0xC1, 0x80, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x01, 0x80, 0x00, 0x00};
const unsigned char PROGMEM ArrowDown [] = {0x00, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x01, 0x83, 0xC1, 0x80, 0x00, 0x00, 0x03, 0xC3, 0xC3, 0xC0, 0x00, 0x00, 0x03, 0xE3, 0xC7, 0xC0, 0x00, 0x00, 0x01, 0xF3, 0xCF, 0x80, 0x00, 0x00, 0x00, 0xFB, 0xDF, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x3F, 0xFC, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x0F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x07, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x03, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x01, 0x80, 0x00, 0x00};
/////ARROW BITMAP/////


/////OLED INSTELLINGEN/////
// Hier wordt er in variabelen aangegeven wat de eigenschappen zijn van het OLED scherm: de breedte en hoogte (in pixels).
#define SCREEN_WIDTH 128 //breedte OLED scherm (in pixels)
#define SCREEN_HEIGHT 64 //hoogte OLED scherm (in pixels)
#define OLED_RESET LED_BUILTIN
// Dit commando configureert dan het display aan de hand van de vorige variabelen.
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
/////OLED INSTELLINGEN/////


/////HTML STRINGS/////
// Dit is wat HTML code die nodig is om de app te doen werken. De string "header" is het begin van HTML code waar er tekst in gestoken kan worden maar in mijn geval is deze leeg. De header wordt gebruikt om een antwoord naar de app te sturen. Als de app een request aanvraagt zal de string header teruggestuurd worden naar de app waardoor de app weet dat het request succesvol ontvangen is. De string "request" is momenteel leeg maar hier wordt er later nog data in gestoken.
String header = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
String request = "";
/////HTML STRINGS/////


/////BUILTINLED AANSLUITINGEN + VARIABELEN/////
// De eerste variabele geeft aan op welke poort de ingebouwde LED is aangesloten. De twee andere variabelen zijn onnodig maar maakten het programmeren wat gemakkelijker. Normaal gaat een LED aan als de poort waarop hij aangesloten is op HIGH staan maar bij de ESP8266 werkt dit omgekeerd, als hij op HIGH staat is de LED uit en op LOW staan hij aan. Daarom zijn variabelen gemaakt die "omgekeerd" werken, als ik de led aan wil zetten gebruik ik de variabele BuiltinLedHIGH die al waarde 0 (LOW) heeft waardoor de led dan aan gaat.
static const uint8_t LED = 16;
int BuiltinLedHIGH = 0;
int BuiltinLedLOW = 1;
/////BUILTINLED AANSLUITINGEN + VARIABELEN/////


/////VARIABELEN/////
// Dit zijn weer wat variabelen die de huidige status (snelheid en status) van de motor bevatten. Dit wordt dan op het OLED scherm weergegeven.
String MotorSnelheid = "traag";
String MotorStatus = "uit";
int Arrow = 0;
/////VARIABELEN/////


/////MOTOR AANSLUITINGEN/////
// Hier wordt aangegeven op welke poorten wat is aangesloten. Bv: de MotorDir (motor direction) van de EasyDriver is aangesloten op poort 14 van de ESP8266.
int MotorStep = 12;
int MotorDir = 14;
int MotorEnablePin = 0;
int MotorMS1 = 9;
int MotorMS2 = 10;
/////MOTOR AANSLUITINGEN/////


void setup() {

  // De serial.begin geeft aan op welke baud de monitor moet starten. De seriele monitor was enkel nodig voor testen en heeft nu geen functie meer.
  Serial.begin(115200);

  /////BUILTINLED INSTELLINGEN/////
  // Hier wordt aangegeven dat de LED "poort" output moet zijn (stroom afgeven) en wordt de LED uit gezet.
  pinMode(LED, OUTPUT);
  digitalWrite(LED, BuiltinLedHIGH);
  /////BUILTINLED INSTELLINGEN/////


  /////MOTOR INSTELLINGEN/////
  // Hier wordt hetzelfde als hierboven gedaan (input/output en high/low) maar dan voor de aansluitingen van de EasyDriver
  pinMode(MotorDir, OUTPUT);  //MotorDir output
  digitalWrite(MotorDir, LOW);  //MotorDir LOW
  pinMode(MotorStep, OUTPUT);  //MotorStep output
  digitalWrite(MotorStep, LOW);  //MotorStep LOW

  pinMode(MotorEnablePin, OUTPUT);  //MotorEnablePin output
  digitalWrite(MotorEnablePin, HIGH);

  // Als de MotorMS1 en MS2 pin van de EasyDriver op HIGH staan zal microstappen ingeschakeld worden. Hierover wordt er meer uitleg gegeven worden in 2.3.4
  pinMode(MotorMS1, OUTPUT);  //MotorMS1 output
  digitalWrite(MotorMS1, HIGH);  //MotorMS1 LOW
  pinMode(MotorMS2, OUTPUT);  //MotorMS2 output
  digitalWrite(MotorMS2, HIGH);  //MotorMS2 LOW
  /////MOTOR INSTELLINGEN/////


  /////OLED INSTELLINGEN/////
  // Hier wordt het OLED scherm voor het eerst aan gezet en worden de standaard gegevens weergegeven.
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  // Eerste wordt het scherm leeg gemaakt.
  display.clearDisplay();
  display.display();
  // De tekstgrootte wordt op 2 gezet.
  display.setTextSize(2);
  // Het tekstkleur is wit
  display.setTextColor(WHITE);
  // De eerste bitmap wordt getekend (pijl naar boven)
  display.drawBitmap(92, 10, ArrowUp, 48, 47, 1);
  // De cursur wordt op de coördinaten 0,0 gezet wat de bovenhoek links is.
  display.setCursor(0, 0);
  // De tekst "Status: " wordt geprint op het scherm.
  display.println("Status: ");
  // Achter de tekst "Status: " wordt de waarde van de variabele MotorStatus geprint (wat ofwel aan of uit is).
  display.println(MotorStatus);
  // Hier wordt hetzelfde gedaan als status maar dan voor de snelheid van de motor.
  display.println("Snelheid: ");
  display.println(MotorSnelheid);
  // Als laatste wordt dit allemaal toegepast en geprint.
  display.display();
  /////OLED INSTELLINGEN/////


  /////START LOCAL ACCESS POINT + SERVER/////
  // De WiFi hotstpot wordt aangemaakt met naam AP_NameChar en wachtwoord WiFiPassword
  boolean conn = WiFi.softAP(AP_NameChar, WiFiPassword);
  server.begin();
  /////START LOCAL ACCESS POINT + SERVER/////
}


void loop() {


  /////START MOTOR VOID/////
  // Hier wordt de VoidMotor gestart die vanonder in het programma staat.
  Motor();
  /////START MOTOR VOID/////


  /////WIFI CLIENT/////
  // Hier wordt er gecontroleerd of er een gebruiker met de WiFi hotspot verbonden is. Als dit het geval is wordt het programma verder uitgevoerd. Zolang er geen gebruiker is zal het programma hier stoppen.
  WiFiClient client = server.available();
  if (!client)  {
    return;
  }
  /////WIFI CLIENT/////


  /////SERVER REQUESTS/////
  // Hier wordt de request van de app / gebruiker gelezen en opgeslagen. Als er in de app op een knop gedrukt wordt, wordt er in de achtergrond een webpagina geopend. De "link" van de webpagina is het IP adres van de ESP8266 met daarna het request. Deze link is bv. http://192.168.4.1/SpeedSnel. Het IP adres is 192.168.4.1 en het request is "SpeedSnel". De request "SpeedSnel" wordt dan opgeslagen in de string "request" (die hierboven nog leeg was).
  request = client.readStringUntil('\r');

  // Hier wordt gekeken wat de request is en wordt er dan een aantal commando's uitgevoerd voor het gevraagde request. In het eerste geval wordt er gekeken of de request gelijk is aan "StarTrackerMainAan" (de index hiervan zal dan groter zijn dan 0). Als dit het geval is wordt de MotorEnablePin op LOW gezet waardoor de EasyDriver geactiveerd wordt. Ook krijgt de string MotorStatus de waarde "aan" die dan later op het scherm geschreven wordt.
  if       ( request.indexOf("StarTrackerMainAan") > 0 )  {
    digitalWrite(MotorEnablePin, LOW);
    MotorStatus = "aan";
  }
  else if  ( request.indexOf("StarTrackerMainUit") > 0 ) {
    digitalWrite(MotorEnablePin, HIGH);
    MotorStatus = "uit";
  }
  // Hier is het principe hetzelfde maar worden de MotorMS1 en MS1 pin op LOW (eerste geval) of op HIGH (tweede geval) gezet. LOW betekend dat microstappen wordt uitgeschakeld en de motor dus op volledige stappen zal draaien. HIGH betekend dat de microstappen worden ingeschakeld en een volledige stap 1/8 wordt. De motor zal dan dus 8 keer trager draaien. Meer hierover in 2.3.4.
  else if  ( request.indexOf("SpeedSnel") > 0 ) {
    digitalWrite(MotorMS2, LOW);
    digitalWrite(MotorMS1, LOW);
    MotorSnelheid = "snel";
  }
  else if  ( request.indexOf("SpeedTraag") > 0 ) {
    digitalWrite(MotorMS2, HIGH);
    digitalWrite(MotorMS1, HIGH);
    MotorSnelheid = "traag";
  }
  // Ook hier is het principe hetzelfde maar wordt de richting van de motor aangepast. Als MotorDir LOW is zal deze in wijzerzin draaien. HIGH is tegenwijzerzin. De variabele Arrow wordt ook aangepast zodat de juiste pijl (die de richting aangeeft) op het scherm kan weergegeven worden.
  else if  ( request.indexOf("RichtingOmhoog") > 0 ) {
    digitalWrite(MotorDir, LOW);
    Arrow = 0;
  }
  else if  ( request.indexOf("RichtingOmlaag") > 0 ) {
    digitalWrite(MotorDir, HIGH);
    Arrow = 1;
  }
  else if  ( request.indexOf("LedAan") > 0 ) {
    digitalWrite(LED, BuiltinLedHIGH);
  }
  else if  ( request.indexOf("LedUit") > 0 ) {
    digitalWrite(LED, BuiltinLedLOW);
  }
  /////SERVER REQUESTS/////


  /////OLED SCREEN STATUS + MOTOR SNELHEID/////
  // Hier wordt de huidige status op het scherm gezet eenmaal er iets veranderd is (zoals status, snelheid of richting). Net zoals de eerste keer toen het scherm aangepast wordt, wordt deze eerst leeg gemaakt, de tekstgrootte op 2 gezet en de kleur op wit. Daarna wordt weer de huidige status, snelheid en pijl op het scherm weergegeven.
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(WHITE);
  display.setCursor(0, 0);
  display.println("Status: ");
  display.println(MotorStatus);
  display.println("Snelheid: ");
  display.println(MotorSnelheid);
  if (Arrow == 0) {
    display.drawBitmap(92, 10, ArrowUp, 48, 47, 1);
  }
  if (Arrow == 1) {
    display.drawBitmap(92, 10, ArrowDown, 48, 47, 1);
  }
  display.display();
  /////OLED SCREEN STATUS + MOTOR SNELHEID/////


  /////HTML RESPONSE/////
  // De verbinding met de client zal verbroken worden wanneer er een antwoord komt. Daarna wordt de header naar de gebruiker gestuurd zodat de app weet dat de ESP8266 de request ontvangen heeft en heeft uitgevoerd.
  client.flush();
  client.print( header );
  delay(5);
  /////HTML RESPONSE/////
}



/////MOTOR AANDRIJVING/////
void Motor()
// Dit is de void Motor. Deze aparte void is nodig zodat deze continu blijft herhalen. In de void hierboven wordt de herhaling van het programma gepauzeerd omdat er gewacht wordt op een commando van de app. Zolang er geen request van de app komt zal de loop hierboven op pauze staan. Zoals in 2.2.1 beschreven staat, moet een stappenmotor continu snel "aan en uit" gezet worden. Als deze herhaling van aan en uit onderbroken wordt, draait de motor niet meer. Daarom staat de motor aandrijving dus in een aparte loop / void.
{
  digitalWrite (12, HIGH);
  delayMicroseconds(4725); //1242 = 15tr/min
  digitalWrite (12, LOW);
  delayMicroseconds(4725);
}
/////MOTOR AANDRIJVING/////
