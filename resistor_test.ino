const float R1 = 4700; // known resistor
const float Vin = 5; // input voltage on arduino board
const float TOLERANCE = 0.05; // tolerance value used in resistance calculations
const int CALIBRATION = 0; // calibrates the raw analog input to the proper resistance
const int pin = A1;

void setup() {
  Serial.begin(9600);
}

void loop(){
  calculateResistance(A0);
  calculateResistance(A1);
  calculateResistance(A2);
  calculateResistance(A3);
  calculateResistance(A4);
  delay(1000);
}

float calculateResistance(int pin){
    float rawValue = analogRead(pin);
    float Vout = (rawValue - CALIBRATION) / 1024 * Vin; // translating raw value into Vout (change of scale from 0-1024 to 0-5
    float R2 = (Vin / Vout - 1) * R1;
    Serial.println(R2);
    return R2;
    //Serial.println("resistance calculator working!");
}

float lowResistance(float ledResistor){
  return ledResistor - (ledResistor * TOLERANCE);
}

float highResistance(float ledResistor){
  return ledResistor + (ledResistor * TOLERANCE);
}
