#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <GlobalNamespace.mqh>
#include <PricingStats.mqh>

string DisplayFormat(double Attribute){

   string Value;
   
   
   if (Attribute <= 9){
   
      Value = "00" + DoubleToString(Attribute,0);
   
   
   }
   
   else if (Attribute <= 99){
   
      Value = "0" + DoubleToString(Attribute,0);
   
   }
   
   else {
   
      Value = DoubleToString(Attribute,0);
   
   }

   return Value;

}

double ValuePerTick(){

  double ChartDigits = MarketInfo(CurrentChartSymbol,MODE_DIGITS);
  double ValuePerTick;
   
  if (ChartDigits == 3){
  
     ValuePerTick = MarketInfo(CurrentChartSymbol, MODE_TICKVALUE) / 100;
  
  } else {
  
     ValuePerTick = MarketInfo(CurrentChartSymbol, MODE_TICKVALUE);
  
  } 

  return ValuePerTick;

}

string ExchangeRateFormat(){
   
   return DoubleToString(NormalizeDouble(1/ValuePerTick(),Digits),Digits);

}

string EstimatedProfitCalculation(double PipValue, double Rate){
   
   if(Rate == 0){
   
      PrintDebugMessage("Rate is zero");
      return "Error: Division by zero";
   
   }
   
   double ProfitInCounterCurrency   =  (StopLoss * RewardFactor) * PipValue;
   double ProfitinAccountCurrency   =  ProfitInCounterCurrency / Rate;    
      
   return DoubleToString(NormalizeDouble(ProfitinAccountCurrency,2),2);

}

string StatisticalData  =  "StatData";
string SoftwareVersion  =  "SoftwareVersion";
string VariantData      =  "VariantData";

bool ChartData(){

   //---
   //Software Version Display
   ObjectCreate(0,SoftwareVersion,OBJ_LABEL,0,0,0 );
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_YDISTANCE, VerticalDistance);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_COLOR,clrWhite);
   
   ObjectSetInteger(0,SoftwareVersion, OBJPROP_FONTSIZE,ChartObjectFontSize);
   //---
   
   //---
   //Pricing Statistical Data Display                     
   ObjectCreate(0,StatisticalData,OBJ_LABEL,0,0,0 );
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_YDISTANCE, VerticalDistance + 30);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_COLOR,clrWhite);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_FONTSIZE,ChartObjectFontSize);
   //---
   
   //---
   //Variants
   ObjectCreate(0,VariantData,OBJ_LABEL,0,0,0 );
   
   ObjectSetInteger(0,VariantData, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,VariantData, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,VariantData, OBJPROP_YDISTANCE, VerticalDistance + 60);
   
   ObjectSetInteger(0,VariantData, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,VariantData, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,VariantData, OBJPROP_COLOR,clrWhite);
   
   ObjectSetInteger(0,VariantData, OBJPROP_FONTSIZE,ChartObjectFontSize);
   
   string S             = DisplayFormat(PricingStats(1));
   string R2            = DisplayFormat(PricingStats(2));
   string ACBL          = DisplayFormat(PricingStats(3));
   string MS            = DisplayFormat(PricingStats(4));
   string LER           = ExchangeRateFormat();
   string EP            = EstimatedProfitCalculation(LotSize,LocalExchangeRate);
   string MCBL          = DisplayFormat(VolatilityCandleBodyLength);
   
   if(!ObjectSetString(0,StatisticalData, OBJPROP_TEXT,MS+" ("+string(MaximumSpread)+") / "+S+" ("+string(MinimumStandardDeviation)+" / "+string(MaximumStandardDeviation)+") / "+R2+"% ("+string(minRSquared)+"% / "+string(maxRSquared)+"%)")){
     
      DiagnosticMessaging("Object Draw Error","Unfortunately there was an error in drawing the object "+StatisticalData);
      
      return false;   
      
   }
   
   if(!ObjectSetString(0,SoftwareVersion, OBJPROP_TEXT,(EAName))){
   
      DiagnosticMessaging("Object Draw Error","Unfortunately there was an error in drawing the object "+SoftwareVersion);
      
      return false;
   
   }
   
   if(!ObjectSetString(0,VariantData, OBJPROP_TEXT,LER+" / "+_AccountCurrency+EP+" / "+ACBL+" / "+MCBL)){
   
      DiagnosticMessaging("Object Draw Error: "+VariantData,"Unfortunately, there was an error in drawing the object "+VariantData);
   
      return false;
   
   }
   
  return true; 

}


bool SuspendedChartObject(string ObjectTextDisplay){

   ObjectCreate(0,ChartID_Suspension,OBJ_LABEL,0,0,0 );
                
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_YDISTANCE, 90);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_COLOR,clrRed);
   
   ObjectSetInteger(0,ChartID_Suspension, OBJPROP_FONTSIZE,ChartObjectFontSize);

   if(!ObjectSetString(0,ChartID_Suspension, OBJPROP_TEXT,ObjectTextDisplay)){
   
      DiagnosticMessaging("Chart Object Not Found","There has been an error in finding the relevant chart object");
      
            return false; 
   
   }
      
   return true;
   
} 