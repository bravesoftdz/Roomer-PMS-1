unit uRoomerDefinitions;

interface

const
  cHotelInvoice  = 0;
  cCreditInvoive = 1;
  cCashInvoice   = 2;

const
  qcCompany        = 'Roomer';
  qcApplication    = 'Roomer PMS';
  testCompanyID    = '00';
  testCompanyName  = 'Hotel Trial';
  testExpDate      = 30;
  testRoomCount    = 10;
  testMeetingsRoomCount = 0;
  testConnStr      = '';
  testConnStr2     = '';
  testDiskSerial   = 'HHHH-JJJJ';


const
  peExportNot     = 0;
  peExportFolder  = 1;
  peExportLogFile = 2;


	I_STATUS_NOT_ARRIVED : Integer = 0;
  I_STATUS_ARRIVED : Integer = 1;
  I_STATUS_CHECKED_OUT : Integer = 2;
  I_STATUS_CANCELLED : Integer = 3;
  I_STATUS_WAITING_LIST : Integer = 4;
  I_STATUS_NO_SHOW : Integer = 5;
  I_STATUS_ALLOTMENT : Integer = 6;
  I_STATUS_BLOCKED : Integer = 7;
  I_STATUS_CHANCELED : Integer = 8; //*HJ 140210
  I_STATUS_TMP1 : Integer = 9; //*HJ 140210
  I_STATUS_AWAITING_PAYMENT : Integer = 10; //*HJ 140210
  I_STATUS_DELETED : Integer = 11; //*HJ 140210


	STATUS_NOT_ARRIVED = 'P';
  STATUS_ARRIVED = 'G';
  STATUS_CHECKED_OUT = 'D';
  STATUS_CANCELLED = 'C';
  STATUS_WAITING_LIST = 'O';
  STATUS_NO_SHOW = 'N';
  STATUS_ALLOTMENT = 'A';
  STATUS_BLOCKED = 'B';
  STATUS_CANCELED = 'C';  //*HJ 140210
  STATUS_TMP1 = 'W';  //*HJ 140210
  STATUS_AWAITING_PAYMENT = 'Z';  //*BG 140304
  STATUS_DELETED = 'X';  //*BG 140304

  PAYMENT_GUARANTEE_TYPE : Array[0..2] of String = ('CREDIT_CARD','DOWN_PAYMENT','NONE');

const
  RESERVATION_STATUS_STRING = 'PGDCONABCWZX';


implementation

end.
