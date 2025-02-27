#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <GlobalNamespace.mqh>
#include <MessagesModule.mqh>
#include <CompanyData.mqh>
#include <ConditionData.mqh>

double AverageCandleBodyLength(){

   double PriceOpen[];
   double PriceClose[];
   double CandleBodyLen[];
   double TotalCandleBodyLens = 0;

   ArrayResize(PriceOpen, ChartDataPeriods);
   ArrayResize(PriceClose, ChartDataPeriods);
   ArrayResize(CandleBodyLen, ChartDataPeriods);

   for (int i = 0; i < ChartDataPeriods ; i++){
    
      PriceClose[i]        =  iClose(Symbol(), 0, i) / Point;
      PriceOpen[i]         =  iOpen(Symbol(), 0, i) / Point;
      CandleBodyLen[i]     =  NormalizeDouble(MathAbs(PriceClose[i] - PriceOpen[i]), Digits);
      TotalCandleBodyLens +=  CandleBodyLen[i]; 
      
      //Print(__FUNCTION__" CandleBodyLen[i] #"+string(i)+" "+string(CandleBodyLen[i]));
      //Print(__FUNCTION__" TotalCandleBodyLen "+string(TotalCandleBodyLens));
      //Print(__FUNCTION__" ChartDataPeriods "+string(ChartDataPeriods));
      
   }
    
   //Print(__FUNCTION__" Candle Body Len "+string(CandleBodyLen[2]));
        
   double AverageBody = NormalizeDouble(TotalCandleBodyLens / ChartDataPeriods,0);
            
   return AverageBody;

}

string DisplayFormat(double Attribute){

   string Value;
   
   if (Attribute < 10) {
    
      Value = "00" + DoubleToString(Attribute,0);
        
    } else if (Attribute < 100) {
    
      Value = "0" + DoubleToString(Attribute,0);
        
    } else {
    
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

string PriceInformation =  "PriceData";
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
   //Pricing Data Display
   ObjectCreate(0,PriceInformation,OBJ_LABEL,0,0,0 );
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_YDISTANCE, VerticalDistance + 30);
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,PriceInformation, OBJPROP_COLOR,clrWhite);

   ObjectSetInteger(0,PriceInformation, OBJPROP_FONTSIZE,15);
   //---
   
   //---
   //Pricing Statistical Data Display                     
   ObjectCreate(0,StatisticalData,OBJ_LABEL,0,0,0 );
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_XDISTANCE, 20);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_XSIZE, 400);
   
   ObjectSetInteger(0,StatisticalData, OBJPROP_YDISTANCE, VerticalDistance + 60);
   
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
   
   ObjectSetInteger(0,VariantData, OBJPROP_YDISTANCE, VerticalDistance + 90);
   
   ObjectSetInteger(0,VariantData, OBJPROP_YSIZE, 100);
   
   ObjectSetInteger(0,VariantData, OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetInteger(0,VariantData, OBJPROP_COLOR,clrWhite);
   
   ObjectSetInteger(0,VariantData, OBJPROP_FONTSIZE,ChartObjectFontSize);
   
   //---
   
   //---
   //// Declare dynamic arrays.
   double time[];
   double price[];
   double time_pow[];
   double PriceOpen[];
   double PriceClose[];
   double PriceHigh[];
   double PriceLow[];
   //---
   
   //---
   //// Resize arrays to the specified number of period.
   ArrayResize(time, ChartDataPeriods+1);
   ArrayResize(price, ChartDataPeriods+1);
   ArrayResize(time_pow, ChartDataPeriods+1);
   ArrayResize(PriceOpen, ChartDataPeriods+1);
   ArrayResize(PriceClose, ChartDataPeriods+1);
   ArrayResize(PriceHigh, ChartDataPeriods+1);
   ArrayResize(PriceLow, ChartDataPeriods+1);
   
   //---
   int CandleAssessmentCommencement = 0;
   //---
   //Array to store values.
   for (int i = CandleAssessmentCommencement; i < ChartDataPeriods; i++) {
   
      time[i]        =  double(ulong(Time[i]));
      price[i]       =  Open[i];
      time_pow[i]    =  MathPow(time[i], 2);
   
   }
   //---
   
   //---
   //Calculate Sums & Averages
   double   SumOfPeriods  = 0;
   
   for (int i = CandleAssessmentCommencement; i < ChartDataPeriods; i++){
   
      SumOfPeriods   += time[i];
   
   }
   
   double RollingAveragePrice    = iMA(NULL, 0, ChartDataPeriods, 0, ENUM_MA_METHOD(ChartDataMAMethod), PRICE_OPEN, 0);
   double AverageTime            = SumOfPeriods / ChartDataPeriods;
   //---
   
   double ExMinusAverage      = 0;
   double EyMinusAverage      = 0;
   double ExyAverage          = 0;
   double Ex2                 = 0;
   double Exy                 = 0;
   double EyMinusAveragePow2  = 0;
   
   for (int i = CandleAssessmentCommencement; i < ChartDataPeriods; i++) {
      
      ExMinusAverage     += (time[i] - AverageTime);
      EyMinusAverage     += (price[i] - RollingAveragePrice);
      ExyAverage         += (time[i] - AverageTime) * (price[i] - RollingAveragePrice);
      Ex2                += time_pow[i];
      Exy                += time[i] * price[i];
      EyMinusAveragePow2 += MathPow(price[i] - RollingAveragePrice, 2);
   
   }
   
   double ExMinusAveragePow2 = 0;
   
   for (int i = CandleAssessmentCommencement; i < ChartDataPeriods; i++){
   
      ExMinusAveragePow2 += MathPow(time[i] - AverageTime,2);
   
   }
   
   double sqrtExMinusAveragePow2    =  sqrt(ExMinusAveragePow2 / (ChartDataPeriods - 1));
   double sqrtEyMinusAveragePow2    =  sqrt(EyMinusAveragePow2 / (ChartDataPeriods - 1));
   double CoVariance                =  ExyAverage / (ChartDataPeriods - 1);
   double Variance                  =  (sqrtExMinusAveragePow2 * sqrtEyMinusAveragePow2);
   double CorrelationCoefficient    =  NormalizeDouble((CoVariance / Variance),2);
          StandardDeviation         =  NormalizeDouble(sqrtEyMinusAveragePow2  / Point,0);
          RSq                       =  NormalizeDouble(MathPow(CorrelationCoefficient,2)*100,0);
   string TrendStatus;
   double Price;
   
   string R2   = DisplayFormat(RSq);
   string S    = DisplayFormat(StandardDeviation);
   string MS   = DisplayFormat(MarketSpread);
   string ACBL = DisplayFormat(AverageCandleBodyLength());
   string ACRL = DisplayFormat(AverageCandleRangeLen);
   string RLR  = DisplayFormat(RangeLenRatio);
   string LER  = ExchangeRateFormat();
   string EP   = EstimatedProfitCalculation(LotSize,LocalExchangeRate);
   string MCBL = DisplayFormat(VolatilityCandleBodyLength);
   
   if(CheckMovingAverage(8,13,21,55,0)){
   
      TrendStatus          = "Bullish";
      Price                = iHigh(CurrentChartSymbol,0,0);
   
   } else if(CheckMovingAverage(8,13,21,55,1)){
   
      TrendStatus          =  "Bearish";
      Price                =  iLow(CurrentChartSymbol,0,0);
   
   
   } else {
   
      TrendStatus          =  "NULL";
      Price                =  NULL;
   
   }
   
   if(!ObjectSetString(0,PriceInformation, OBJPROP_TEXT,TrendStatus+" / "+DoubleToString(CurrentBarOpenPrice,Digits)+" / "+DoubleToString(Price,Digits)+" / "+DoubleToString(SpotBid,Digits))){
         
      DiagnosticMessaging("Object Draw Error","Unfortunately there was an error in drawing the object "+PriceInformation);
      
      return false;
   
   }
   
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

double CalculateStandardDeviation(int Mode){

   double time[];
   double price[];
   double time_pow[];
   double PriceOpen[];
   double PriceClose[];
   double PriceHigh[];
   double PriceLow[];

   ArrayResize(time, ChartDataPeriods+1);
   ArrayResize(price, ChartDataPeriods+1);
   ArrayResize(time_pow, ChartDataPeriods+1);
   ArrayResize(PriceOpen, ChartDataPeriods+1);
   ArrayResize(PriceClose, ChartDataPeriods+1);
   ArrayResize(PriceHigh, ChartDataPeriods+1);
   ArrayResize(PriceLow, ChartDataPeriods+1);

   double   SumOfPeriods                  = 0;
   double   RollingAveragePrice           = iMA(NULL, 0, ChartDataPeriods, 0, ENUM_MA_METHOD(ChartDataMAMethod), PRICE_OPEN, 0);
   double   ExMinusAverage                = 0;
   double   EyMinusAverage                = 0;
   double   ExyAverage                    = 0;
   double   Ex2                           = 0;
   double   Exy                           = 0;
   double   EyMinusAveragePow2            = 0;
   double   ExMinusAveragePow2            = 0;
   
   for (int i = 0; i < ChartDataPeriods; i++) {
   
      time[i]        =  double(ulong(Time[i]));
      price[i]       =  Open[i];
      time_pow[i]    =  MathPow(time[i], 2);
      SumOfPeriods   += time[i];
   
   }
   
   double AverageTime = SumOfPeriods / ChartDataPeriods;

   for (int i = 0; i < ChartDataPeriods; i++) {
      
      ExMinusAverage     += (time[i] - AverageTime);
      EyMinusAverage     += (price[i] - RollingAveragePrice);
      ExyAverage         += (time[i] - AverageTime) * (price[i] - RollingAveragePrice);
      Ex2                += time_pow[i];
      Exy                += time[i] * price[i];
      EyMinusAveragePow2 += MathPow(price[i] - RollingAveragePrice, 2);
      ExMinusAveragePow2 += MathPow(time[i] - AverageTime,2);
   
   }
   
   double sqrtExMinusAveragePow2    =  sqrt(ExMinusAveragePow2 / (ChartDataPeriods - 1));
   double sqrtEyMinusAveragePow2    =  sqrt(EyMinusAveragePow2 / (ChartDataPeriods - 1));
   double CoVariance                =  ExyAverage / (ChartDataPeriods - 1);
   double Variance                  =  (sqrtExMinusAveragePow2 * sqrtEyMinusAveragePow2);
   double CorrelationCoefficient    =  NormalizeDouble((CoVariance / Variance),2);
          StandardDeviation         =  NormalizeDouble(sqrtEyMinusAveragePow2  / Point,0);
          RSq                       =  NormalizeDouble(MathPow(CorrelationCoefficient,2)*100,0);

   if(Mode == 1){
   
      PrintDebugMessage(__FUNCTION__" StandardDeviation "+string(StandardDeviation));
      
      return StandardDeviation;
   
   } else if (Mode == 2){
   
     PrintDebugMessage(__FUNCTION__" RSquared "+string(RSq));
     
     return RSq;
   
   } else {
   
      DiagnosticMessaging("Price Data Calculation Error","We have been unable to determine which mode you have required to calculate price data.");
      
      return 0;
   
   }
   
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