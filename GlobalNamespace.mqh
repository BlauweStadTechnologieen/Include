#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <CompanyData.mqh>

enum ENUM_SENDDIAG{

   Send_Diag_Data                      =  1, // Yes
   Do_Not_Send_Diag_Data               =  2  // No
   

};

enum SEND_TRANSACTION_EMAILS{ 

   Send_Transaction_Messages          =  1, // Yes
   Do_Not_Send_Transaction_Messages   =  2  // No

};

enum PLOT_LINES{

   Yes                                 = 1, // On
   No                                  = 2  // Off

};

enum ENUM_ENTITY{
   
   Blue_City_Capital 	               = 1, // Blue City Capital
   United_Amerigo 	                  = 2, // United Amerigo
   Personal_Account                    = 3  // Personal account
   
};

enum DEBUG_MODE{

   DebugOn                             = 1, // On
   DebugOff                            = 2  // Off

};

enum PREVIOUS_PRICES{
  
   On                                  = 1, // On
   Off                                 = 2  // Off
   
  };

enum NO_TRADE{
  
   NoTemporarySuspension             = 1, // No Temporary Suspension
   TemporarySuspension               = 2  // Temporarily Suspended
   
};

enum NO_TRADE_REASON{
  
   InterestRateDecisionDay          = 1, // Interst rate decision day
   PeriodOfSignificantVolatility    = 2, // Period of significant volatility
   NationalHoliday                  = 3, // Holiday season
   NoSuspension                     = 4, // No suspension
   IrraticPriceAction               = 5, // Irratic price behaviour
   UnfavourablePriceConditions      = 6  // Unfavourable conditions 
   
};

enum MAX_SPREAD{

   MaxSpread5                          =  5,    //5  
   MaxSpread10                         =  10,   //10
   MaxSpread15                         =  15,   //15
   MaxSpread20                         =  20,   //20
   MaxSpread25                         =  25,   //25
   MaxSpread30                         =  30,   //30
   MaxSpread35                         =  35,   //35
   MaxSpread40                         =  40    //40

};

enum MinRSQ{

   RSQ10                               =  10,   //10
   RSQ20                               =  20,   //20        
   RSQ30                               =  30,   //30
   RSQ40                               =  40,   //40
   RSQ50                               =  50    //50

};

enum MaxRSQ{

   RSQ60                               =  60,   //60
   RSQ70                               =  70,   //70
   RSQ80                               =  80,   //80
   RSQ90                               =  90,   //90
   RSQ100                              =  100   //100

};

enum MinStandardDeviation{
   
   SD50                                =  50,   //50
   SD100                               =  100,  //100
   SD200                               =  200,  //200
   SD300                               =  300   //300

};

enum MaxStandardDeviation{
   
   SD400                               =  400,  //400
   SD500                               =  500,  //500
   SD600                               =  600,  //600
   SD700                               =  700,  //700
   SD800                               =  800,  //800
   SD900                               =  900,  //900
   SD1000                              =  1000  //1000

};

enum MaxRewardFactor{

   RewardFactor2  =  2, //1:2
   RewardFactor3  =  3, //1:3
   RewardFactor4  =  4, //1:4
   RewardFactor5  =  5, //1:5
   RewardFactor6  =  6, //1:6
   RewardFactor7  =  7, //1:7
   RewardFactor8  =  8, //1:8
   RewardFactor9  =  9, //1:9
   RewardFactor10 =  10 //1:10

};

enum MaxPipRisk{
   
   MaxPIPRisk100  = 100, //100
   MaxPIPRisk200  = 200, //200
   MaxPIPRisk300  = 300, //300
   MaxPIPRisk400  = 400, //400
   MaxPIPRisk500  = 500  //500
   
};

enum MinimumHammerBody{

   MinimumBody10 =  10, //10
   MinimumBody20 =  20, //20
   MinimumBody30 =  30, //30
   MinimumBody40 =  40, //40
   MinimumBody50 =  50  //50


};

enum SufficientVolatilityBodyLength{

   VolatilityBodyLength10  = 10, //10
   VolatilityBodyLength20  = 20, //20
   VolatilityBodyLength30  = 30, //30
   VolatilityBodyLength40  = 40, //40
   VolatilityBodyLength50  = 50, //50
   VolatilityBodyLength60  = 60, //60
   VolatilityBodyLength70  = 70, //70
   VolatilityBodyLength80  = 80, //80
   VolatilityBodyLength90  = 90, //90
   VolatilityBodyLength100 = 100,//100
   VolatilityBodyLength200 = 200, //200
   VolatilityBodyLength300 = 300, //300
   VolatilityBodyLength400 = 400, //400
   VolatilityBodyLength500 = 500, //500
   VolatilityBodyLength600 = 600, //600
   VolatilityBodyLength700 = 700, //700
   VolatilityBodyLength800 = 800 //800

};

enum ChartObjectFont{

   ChartObjectFontSize5 =  5, //5
   ChartObjectFontSize10 = 10,//10
   ChartObjectFontSize15 = 15,//15
   ChartObjectFontSize20 = 20,//20
   ChartObjectFontSize25 = 25 //25
   
};

enum ChartDataPeriod{

   ChartDataPeriod10    = 10, //10
   ChartDataPeriod20    = 20, //20
   ChartDataPeriod30    = 30, //30
   ChartDataPeriod40    = 40, //40
   ChartDataPeriod50    = 50, //50
   ChartDataPeriod60    = 60, //60
   ChartDataPeriod70    = 70, //70
   ChartDataPeriod80    = 80, //80
   ChartDataPeriod90    = 90, //90
   ChartDataPeriod100   = 100 //100

};

enum ChartDataAveragingMethod{

   SMA               =  MODE_SMA,  // Simple Moving Average, 
   EMA               =  MODE_EMA,  // Exponential Moving Average, 
   SMMA              =  MODE_SMMA, // Smoothed Moving Average, 
   LWMA              =  MODE_LWMA // Linear Weighted Moving Average.

};

enum Breakeven{

   Breakeven50 =  50,   //50
   Breakeven60 =  60,   //60
   Breakeven70 =  70,   //70
   Breakeven80 =  80,   //80
   Breakeven90 =  90,   //90
   Breakeven100 =  100,  //100
   Breakeven120 =  120,  //120
   Breakeven130 =  130,  //130
   Breakeven140 =  140,  //140
   Breakeven150 =  150,  //150
   Breakeven160 =  160,  //160
   Breakeven170 =  170,  //170
   Breakeven180 =  180,  //180
   Breakeven190 =  190,  //190
   Breakeven200 =  200,  //200
   Breakeven300 =  300,  //300
   Breakeven400 =  400,  //400
   Breakeven500 =  500,  //500

};

enum ContractLots{

  Lot1   = 1,  //100,000
  Lot2   = 2,  //200,000
  Lot3   = 3,  //300,000
  Lot4   = 4,  //400,000
  Lot5   = 5,  //500,000
  Lot6   = 6,  //600,000
  Lot7   = 7,  //700,000
  Lot8   = 8,  //800,000
  Lot9   = 9,  //900,000
  Lot10  = 10  //1,000,000

};

enum TakeProfitChange{

   TakeProfit100 = 100, //100 pips
   TakeProfit200 = 200, //200 pips
   TakeProfit300 = 300, //300 pips
   TakeProfit400 = 400, //400 pips
   TakeProfit500 = 500, //500 pips
   TakeProfit600 = 600, //600 pips

};

//Exern Variables//
input    MinRSQ                           minRSquared                      =     RSQ40;                                                        // Minimum R²(%)
input    MaxRSQ                           maxRSquared                      =     RSQ60;                                                        // Maximum R²(%)
input    MinStandardDeviation             MinimumStandardDeviation         =     SD100;                                                        // Minimum σ
input    MaxStandardDeviation             MaximumStandardDeviation         =     SD400;                                                        // Maximum σ 
input    MinimumHammerBody                minimumHammerBody                =     MinimumBody10;                                                // Minimum Candle Body Length  
input    SufficientVolatilityBodyLength   VolatilityCandleBodyLength       =     VolatilityBodyLength70;                                       // Minimum Volatility Body Length           
input    NO_TRADE                         TempSuspension                   =     NoTemporarySuspension;                                        // Temporarily Suspend Operations
input    NO_TRADE_REASON                  NoTradeReason                    =     NoSuspension;                                                 // Temporary Suspension Reason
input    MaxRewardFactor                  RewardFactor                     =     RewardFactor4;                                                // Risk:Reward Factor 
input    MaxPipRisk                       StopLoss                         =     MaxPIPRisk100;                                                // Maximum Pip Risk 
input    Breakeven                        breakeven                        =     Breakeven120;                                                 // Breakeven 
input    MAX_SPREAD                       MaximumSpread                    =     MaxSpread30;                                                  // Maximum Spread Allowed
extern   ContractLots                     LotSize                          =     Lot8;                                                         // Contract Lots   
extern   int                              VerticalDistance                 =     200;
extern   int                              PrimaryStar                      =     3;
extern   int                              PrimaryEnd                       =     4;
extern   int                              SecondaryStar                    =     4;
extern   int                              SecondaryEnd                     =     5;
extern   int                              MasterCandleCount                =     5;                                                            // Master Candle Count
extern   TakeProfitChange                 TPIncrement                      =     TakeProfit200;                                                // TakeProfit Increment
extern   string                           FreeTextComment                  =     "";                                                           // FreeTextComment (Optional)
extern   string                           ChartID_CloseButton              =     "Liquidate";                                                  // Close Button Chart Object
extern   string                           ChartID_Breakeven                =     "Breakeven";                                                  // Breakeven Chart Object
extern   string                           ChartID_ModifyTakeProfit         =     "ChangeTPPrice";                                              // Modify TakeProfit Chart Object
extern   string                           ChartID_PipDisplayFluid          =     "FluidPipDisplay";                                            // PipDisplayFluid Chart Object        
extern   string                           ChartID_PipDisplayStatic         =     "StaticPipDisplay";                                           // PipDisplayStatic Chart Object
extern   string                           ChartID_SpreadDisplay            =     "SpreadDisplay";                                              // Spread Display Chart Object
extern   string                           ChartID_Suspension               =     "SuspendedPair";
input    string                           ProductLicenceKey                =     "ALvFRpKQS1EgMUVnTVVWblRWVldibFJXVmxkaWJGSlhW";               // Product Licence Key
input    ENUM_ENTITY                      Group_Entity                     =     Blue_City_Capital;                                            // Entity
input    ENUM_SENDDIAG                    SendDiagnosticData               =     Send_Diag_Data;                                               // Send Diagnostics Messages
input    SEND_TRANSACTION_EMAILS          SendTransactionMessages          =     Send_Transaction_Messages;                                    // Send Transactional Messages
input    DEBUG_MODE                       DebugMode                        =     DebugOff;                                                     // Debug Mode
input    PREVIOUS_PRICES                  PlotPreviousPrices               =     Off;                                                          // Print Previous Prices
input    ChartObjectFont                  ChartObjectFontSize              =     ChartObjectFontSize15;                                        // Chart Object Font Size
input    ChartDataPeriod                  ChartDataPeriods                 =     ChartDataPeriod10;                                            // Chart Data Period
input    ChartDataAveragingMethod         ChartDataMAMethod                =     SMA;                                                          // Chart Data Method          
int      brokerMarginLevel                                                 =     150;                                                          // Broker-specified minimum required mrgin level
int      startingHour                                                      =     9;           /*GMT*/
int      endingHour                                                        =     16;          /*GMT*/
int      AM_TrendFast                                                      =     1;           /*MODE_EMA*/
int      Period_TrendFast                                                  =     21;          /*Trend*/
int      AM_TrendSlow                                                      =     1;           /*MODE_EMA*/
int      Period_TrendSlow                                                  =     55;          /*Trend*/
int      AM_MomentumSlow                                                   =     0;           /*MODE_SMA*/
int      Period_MomentumSlow                                               =     13;          /*Momentum*/
int      AM_MomentumFast                                                   =     1;           /*MODE_EMA*/
int      Period_MomentumFast                                               =     8;           /*Momentum*/
int      Applied_Price                                                     =     0;           /*Applied Price*/        
double   ComparisonPercentage                                              =     0.20;      
//+------------------------------------------------------------------+
//|double                                                            |
//+------------------------------------------------------------------+
double   CurrentBarOpenPrice;
double   RSq;
double   PipPerformance;
double   PositionNetProfit;
double   PositionGrossProfit;
double   MarketExitPrice;
double   ExecutionSpreadCharge;
double   RemainingMargin;
double   NewTP;
double   CurrentFreeMargin;
double   _AccountEquity;
double   SpotAsk;
double   SpotBid;
double   MarketSpread;
double   PositonTickValue;
double   LocalExchangeRate;
double   AverageCandleBodyLen;
double   CandleBodyLength;
double   RangeLenRatio;
double   VolatilityRatio;
double   StandardDeviation; 
double   CandleBody[];
double   CandleHigh;
double   CandleLow;
double   CandleOpen[];
double   CandleClose[];
double   TimeByPeriod[];
double   PriceByPeriod[];
double   TimeByPeriodPower[];
//+------------------------------------------------------------------+
//|bool                                                              |
//+------------------------------------------------------------------+
bool     IsCurrencyVolatile;
bool     BuyMod;
bool     SellMod;
bool     NewBar;
//+------------------------------------------------------------------+
//|int                                                               |
//+------------------------------------------------------------------+
int      MarginBuffer;
int      CaptureFileNameId; 
//+------------------------------------------------------------------+
//|string                                                            |
//+------------------------------------------------------------------+
string   ExecutionSymbol;
string   ConfimationEmailGreeting;
string   ConfimationEmailCostData;
string   CurrencyForAccount;
string   MemoText;
string   ChartCaptureImageURL;
string   ChartURL;
string   MessageSubject;
//+------------------------------------------------------------------+
//|datetime                                                           
//+------------------------------------------------------------------+
datetime Expires;
datetime PendingExpiration;
datetime CandleOpenTime;
datetime BarTime;
datetime _TimeCurrent;
//+------------------------------------------------------------------+
//|color                                                             |
//+------------------------------------------------------------------+
color    buycolor;
color    sellcolor;
color    WebColors;
//+------------------------------------------------------------------+
//|bool                                                          |
//+------------------------------------------------------------------+
bool MessageSent             = false;
//+------------------------------------------------------------------+
//|double                                                                 
//+------------------------------------------------------------------+
double   OrderMarginRequirement  =  MarketInfo(Symbol(),MODE_MARGINREQUIRED) * LotSize;
double   _OrderOpenPrice      = OrderOpenPrice();
double   _OrderStopLoss       = OrderStopLoss();
double   _OrderCommission     = OrderCommission();
double   _OrderTakeProfit     = OrderTakeProfit();
double   _OrderSwap           = OrderSwap();    
double   TickValue            = 0;
double   broker_ratio         = 0;        // Broker Ratio
double   broker_lot_min       = 0;        // Broker Minimum permitted amount of a lot.
double   broker_lot_max       = 0;        // Broker Maximum permitted amount of a lot.
double   broker_lot_step      = 0;        // Broker Step for changing lots.
double   broker_contract      = 0;        // Broker Lot size in the base currency.
double   broker_stop_level    = 0;        // Broker Stop level in points
double   broker_freeze_level  = 0;        // Order freeze level in points. If the execution price lies within the range defined by the freeze level, the order cannot be modified, cancelled or closed.
double   broker_point         = 0;        // Broker Point size in the quote currency.
//+------------------------------------------------------------------+
//|long                                                          |
//+------------------------------------------------------------------+
long     UniqueChartIdentifier   = ChartID();
//+------------------------------------------------------------------+
//|int                                                         |
//+------------------------------------------------------------------+
int      PositionsTotal          =  OrdersTotal();
int      GetCurrentErrorCode     =  GetLastError();
int      _OrderMagicNumber       =  OrderMagicNumber();
int      _OrderTicket            =  OrderTicket();
int      BrokerAccountNumber     =  AccountNumber();
int      ExecutionTimeframe      =  Period()/60;
int      PositionsHistoryTotal   =  0;
int      FileHandle              =  0;
//+------------------------------------------------------------------+
//|string
//+------------------------------------------------------------------+
string   EAName                  =  WindowExpertName();
string   _AccountCurrency        =  AccountCurrency();
string   CurrentChartSymbol      =  Symbol();
string   _OrderSymbol            =  OrderSymbol();

enum ENUM_FUNCTION_MODE { MODE_DEINIT = -1, MODE_INIT, MODE_WORK };
struct STRUCT_ORDER_INFO
  {
   int               ticket;
   int               magic;
   int               type;
   double            lot;
   double            open;
   double            close;
   double            sl;
   double            tp;
   double            profit;
   datetime          time;
  };

STRUCT_ORDER_INFO stcOrdOldArr[1], stcOrdNewArr[1];   //arrays containing order list with information
string sOrdOldArr[], sOrdNewArr[];






      


