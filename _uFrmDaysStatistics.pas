unit uFrmDaysStatistics;

interface

uses
  Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , System.Generics.Collections
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , VCLTee.TeEngine
  , VCLTee.TeeProcs
  , VCLTee.Chart
  , Vcl.ExtCtrls
  , cxPC
  , Xml.xmldom
  , Xml.XMLIntf
  , Xml.adomxmldom
  , Xml.XMLDoc
  , cxClasses
  , sScrollBox
  , Vcl.StdCtrls
  , sLabel
  , VCLTee.Series
  , sPanel
  , performance
  , uAppGlobal

;

type

  TIdDValue = class
    id : Integer;
    Value : Double;
  public
    constructor Create(_id : Integer; _value : Double);
  end;

  TIdSValue = class
    id : Integer;
    Value : String;
  public
    constructor Create(_id : Integer; _value : String);
  end;

  TRatesAndAvails = class
    roomType : String;
    totalRooms : Integer;
    totalOccupied : Integer;
    totalAvailable : Integer;
    rate : Double;

    constructor Create(_roomType : String;
                       _totalRooms,
                       _totalOccupied,
                       _totalAvailable : Integer;
                       _rate : Double);
  end;

  TIdChannelValues = class
    id : Integer;
    name : String;
    adr : Double;
    guests : Integer;
    maxRate : Double;
    minRate : Double;
    occ : Double;
    revPar : Double;
    revenue : Double;
    rooms : Integer;
    sold : Integer;
    color : Integer;
    arrivals : Integer;
    departures : Integer;
    checkedIn : Integer;
    occupied : Integer;
    departed : Integer;
    noShow : Integer;
    totalDiscounts : Double;

    RatesAndAvailabilities : TList<TRatesAndAvails>;
  public
    constructor Create(_id : Integer;
              _name : String;
              _color : Integer;
              _adr : Double;
              _guests : Integer;
              _maxRate : Double;
              _minRate : Double;
              _occ : Double;
              _revPar : Double;
              _revenue : Double;
              _rooms : Integer;
              _sold : Integer;
              _arrivals : Integer;
              _departures : Integer;

              _checkedIn : Integer;
              _occupied : Integer;
              _departed : Integer;
              _noShow : Integer;

              _totalDiscounts : Double);
  end;


  TfrmDaysStatistics = class(TForm)
    sPanel1: TsPanel;
    XMLDocument1: TXMLDocument;
    sPanel8: TsPanel;
    sPanel9: TsPanel;
    sPanel5: TsPanel;
    RevenueChart: TChart;
    Series1: TPieSeries;
    sPanel3: TsPanel;
    sLabel2: TsLabel;
    txtTotalRevenue: TsLabel;
    txtCurrency: TsLabel;
    RoomsChart: TChart;
    PieSeries1: TPieSeries;
    sPanel6: TsPanel;
    sPanel7: TsPanel;
    sLabel1: TsLabel;
    txtSoldRooms: TsLabel;
    txtCheckedIn: TsLabel;
    txtCheckedOut: TsLabel;
    sLabel3: TsLabel;
    sLabel5: TsLabel;
    Shape2: TShape;
    sLabel7: TsLabel;
    sLabel9: TsLabel;
    sLabel11: TsLabel;
    txtNoShow: TsLabel;
    txtCheckouts: TsLabel;
    txtCheckins: TsLabel;
    Shape3: TShape;
    sLabel13: TsLabel;
    sLabel16: TsLabel;
    sLabel17: TsLabel;
    txtADR: TsLabel;
    txtOCC: TsLabel;
    txtRevPAR: TsLabel;
    sLabel24: TsLabel;
    sPanel10: TsPanel;
    sbRates: TsScrollBox;
    txtRoomType: TsLabel;
    txtPrice: TsLabel;
    txtTotal: TsLabel;
    txtOccupied: TsLabel;
    txtAvailable: TsLabel;
    sPanel2: TsPanel;
    sLabel19: TsLabel;
    sLabel20: TsLabel;
    sLabel21: TsLabel;
    sLabel23: TsLabel;
    sLabel22: TsLabel;
    Shape1: TShape;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    channels : TDictionary<integer, TIdChannelValues>;
    FViewDate : TDateTime;
    FBeingViewed: Boolean;
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getChannels(performance: IXMLPerformanceType);
    function getTotalRevenue(performance: IXMLPerformanceType): Double;
    function getUrl: String;
    procedure PlaceRateAvailLabel(line, index: Integer; labelValue: String);
    procedure ProcessHttpResult(result: String);
    procedure RemoveTodaysRates;
    procedure SetViewDate(const Value: TDateTime);
    procedure ShowRevenueGraph;
    procedure showTodaysRates(channel: TIdChannelValues);
    procedure txtHeaderDblClick(Sender: TObject);
    procedure PerformRequest;
  public
    { Public declarations }
    procedure GetDaysNumbers(var OCC, ADR, REVPAR: Double; var RoomsSold: Integer);
    property BeingViewed : Boolean read FBeingViewed write FBeingViewed;
    property ViewDate : TDateTime read FViewDate write SetViewDate;
  end;

var
  frmDaysStatistics: TfrmDaysStatistics;

implementation

{$R *.dfm}

uses uD,
     uDateUtils,
     uUtils,
     uMain,
     uRoomerLanguage
     ;

procedure TfrmDaysStatistics.PerformRequest;
begin
  ProcessHttpResult(d.roomerMainDataSet.downloadRoomerUrlAsString(getUrl));
end;

function TfrmDaysStatistics.getUrl : String;
begin
  result := format('statistics/performance1?startdate=%s&enddate=%s', [uDateUtils.dateToSqlString(viewDate), uDateUtils.dateToSqlString(viewDate)]);
end;


procedure TfrmDaysStatistics.btnBackClick(Sender: TObject);
begin
  viewDate := viewDate - 1 - (6 * ABS(ORD(IsControlKeyPressed)));
end;

procedure TfrmDaysStatistics.btnForwardClick(Sender: TObject);
begin
  viewDate := viewDate + 1 + (6 * ABS(ORD(IsControlKeyPressed)));
end;

procedure TfrmDaysStatistics.FormCreate(Sender: TObject);
begin
  channels := TDictionary<integer, TIdChannelValues>.Create;
  FBeingViewed := False;
end;

procedure TfrmDaysStatistics.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  frmMain.FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmDaysStatistics.FormKeyPress(Sender: TObject; var Key: Char);
begin
  frmMain.FormKeyPress(Sender, Key);
end;

procedure TfrmDaysStatistics.showTodaysRates(channel : TIdChannelValues);
var
  i, iLine: Integer;
  RatesAndAvails : TRatesAndAvails;
  ARatesText : String;

  LastRoomType : String;
  LastRateValue : String;
begin
  RemoveTodaysRates;
  LastRoomType := '';
  LastRateValue := '';
  iLine := 0;
  for i := 0 to channel.RatesAndAvailabilities.Count - 1 do
  begin
    RatesAndAvails := channel.RatesAndAvailabilities[i];
    ARatesText := formatFloat('#,##0.00', RatesAndAvails.rate);
    if ARatesText = CorrectDecimalSeparator('0.00') then
       ARatesText := 'N/A';
    if (LastRoomType <> RatesAndAvails.roomType) AND
       (LastRateValue <> ARatesText) then
    begin
      LastRoomType := RatesAndAvails.roomType;
      LastRateValue := ARatesText;
      inc(iLine);
      PlaceRateAvailLabel(iLine, 1, RatesAndAvails.roomType);
      PlaceRateAvailLabel(iLine, 2, ARatesText);
      PlaceRateAvailLabel(iLine, 3, inttostr(RatesAndAvails.totalRooms));
      PlaceRateAvailLabel(iLine, 4, inttostr(RatesAndAvails.totalOccupied));
      PlaceRateAvailLabel(iLine, 5, inttostr(RatesAndAvails.totalAvailable));
    end;
  end;
end;

procedure TfrmDaysStatistics.PlaceRateAvailLabel(line, index : Integer; labelValue : String);
var ALabel, likeLabel : TsLabel;
    AName : String;
begin
  AName := format('TR_%d_', [line]);
  ALabel := TsLabel.Create(frmDaysStatistics);
  case index of
    1 : likeLabel := txtRoomType;
    2 : likeLabel := txtPrice;
    3 : likeLabel := txtTotal;
    4 : likeLabel := txtOccupied;
    5 : likeLabel := txtAvailable;
  end;

  likeLabel.Visible := False;
  ALabel.Font.Size := likeLabel.Font.Size;
  ALabel.Font.Color := likeLabel.Font.Color;
  ALabel.Font.Style := likeLabel.Font.Style;
  ALabel.UseSkinColor := likeLabel.UseSkinColor;

  ALabel.Color := likeLabel.Color;
  ALabel.Width := likeLabel.Width;
  ALabel.Left := likeLabel.Left;
  ALabel.Top := 5 + line * txtRoomType.Height; //likeLabel.Position.Y + (line * txtRoomType.Height);
  if index = 1 then
    ALabel.Alignment := taCenter
  else
    ALabel.Alignment := likeLabel.Alignment;

  ALabel.Name :=  AName + inttostr(index);
  ALabel.Parent := sbRates;
  ALabel.Caption := labelValue;
end;


procedure TfrmDaysStatistics.RemoveTodaysRates;
var
  i, l: Integer;
  ALabel : TsLAbel;
  AName : String;
begin
  for i := 0 to 25 do
  begin
    for l := 1 to 5 do
    begin
      AName := format('TR_%d_%d', [i,l]);
      ALabel := TsLabel(frmDaysStatistics.FindComponent(AName));
      if Assigned(ALabel) then
        ALabel.Free;
    end;
  end;
end;


procedure TfrmDaysStatistics.GetDaysNumbers(var OCC, ADR, REVPAR : Double; var RoomsSold : Integer);
var performance : IXMLPerformanceType;
    channel : TIdChannelValues;
begin
  XMLDocument1.LoadFromXML(d.roomerMainDataSet.downloadRoomerUrlAsString(getUrl));

  performance := Getperformance(XMLDocument1); // 'C:\Temp\performance1.xml');

  getChannels(performance);
  channels.TryGetValue(0, channel);

  RoomsSold := channel.sold;

  REVPAR := channel.revPar;
  OCC := channel.occ;
  ADR := channel.adr;

end;

procedure TfrmDaysStatistics.ProcessHttpResult(result : String);
var performance : IXMLPerformanceType;
    channel : TIdChannelValues;
begin
  XMLDocument1.LoadFromXML(result);

  performance := Getperformance(XMLDocument1); // 'C:\Temp\performance1.xml');

  getChannels(performance);
  channels.TryGetValue(0, channel);

  ShowRevenueGraph;
  try showTodaysRates(channel); Except end;

  txtCheckins.Caption := inttostr(channel.arrivals);
  txtCheckouts.Caption := inttostr(channel.departures);
  txtSoldRooms.Caption := inttostr(channel.sold);
  txtCheckedIn.Caption := inttostr(channel.checkedIn);
  txtCheckedOut.Caption := inttostr(channel.departed);
  txtNoShow.Caption := inttostr(channel.noShow);

  txtRevPAR.Caption := formatFloat('#,##0.00', channel.revPar);
  txtOCC.Caption := formatFloat('#,##0.00', channel.occ);
  txtADR.Caption := formatFloat('#,##0.00', channel.adr);

  txtTotalRevenue.Caption := formatFloat('#,##0.00', channel.revenue);
  txtCurrency.Caption := performance.Currency;
end;

//procedure ColorToRGB(const Color: Integer; out R, G, B: Byte);
//begin
//  R := Color and $FF;
//  G := (Color shr 8) and $FF;
//  B := (Color shr 16) and $FF;
//end;
//
//function GetAlphaColor(color : integer) : TAlphaColor;
//var R,G,B : Byte;
//    ColorStr : String;
//begin
//  if color <> 0 then
//     ColorToRGB(color, R, G, B)
//  else
//  begin
//    R := 255; G := R; B := R;
//  end;
//  ColorStr := '$' + IntToHex(R,2)+IntToHex(G,2)+IntToHex(B,2);
//  result := TAlphaColorRec(ColorStr).Color;
//  TAlphaColorRec(result).R := R;
//  TAlphaColorRec(result).G := G;
//  TAlphaColorRec(result).B := B;
//  TAlphaColorRec(result).A := 255;
//end;

procedure TfrmDaysStatistics.SetViewDate(const Value: TDateTime);
begin
  FViewDate := Value;
  try
    PerformRequest;
  except
  end;
end;

procedure TfrmDaysStatistics.ShowRevenueGraph;
var RevenueSeries,
    RevParSeries : TPieSeries;// ChartSeries;
  i: Integer;
  channel : TIdChannelValues;
  KeyName : Integer;
begin
  RevenueChart.Series[0].Clear;
  RoomsChart.Series[0].Clear;
  SetDefaultColorPalette;
  for KeyName in channels.Keys do
  begin
    channels.TryGetValue(KeyName, channel);
    if channel.id <> 0 then
    begin
      RevenueChart.Series[0].Add(channel.revenue, channel.name, channel.color);
      RoomsChart.Series[0].Add(channel.sold, channel.name, channel.color);
    end;
  end;

end;

procedure TfrmDaysStatistics.txtHeaderDblClick(Sender: TObject);
begin
  viewDate := Trunc(now);
end;

procedure TfrmDaysStatistics.getChannels(performance : IXMLPerformanceType);
var i, l : Integer;
    channel : TIdChannelValues;
    ch : IXMLChannelType;
    day : IXMLDayType;
begin
  channels.Free;
  channels := TDictionary<integer, TIdChannelValues>.Create;
  if performance.Count = 0 then
  begin
    channel := TIdChannelValues.Create(0,
       'Total',
       clWhite,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0);
    channels.Add(0, channel);
  end;
  for i := 0 to performance.Count - 1 do
  begin
    day := performance.Day[i];
    if NOT channels.TryGetValue(0, channel) then
    begin
      channel := TIdChannelValues.Create(0,
         'Total',
         clWhite,
         day.adr,
         day.guests,
         day.maxRate,
         day.minRate,
         day.occ,
         day.revPar,
         day.revenue,
         day.rooms,
         day.sold,
         day.Arrivals,
         day.Departures,
         day.checkedIn,
         day.occupied,
         day.departed,
         day.noShow,
         day.totalDiscounts);
      for l := 0 to day.RoomsAndAvailabilities.Count - 1 do
          channel.RatesAndAvailabilities.add(TRatesAndAvails.Create(day.RoomsAndAvailabilities[l].RoomType,
                      day.RoomsAndAvailabilities[l].TotalRooms,
                      day.RoomsAndAvailabilities[l].TotalOccupied,
                      day.RoomsAndAvailabilities[l].Available,
                      day.RoomsAndAvailabilities[l].Rate));
      channels.Add(0, channel);
    end else
    begin
      channel.adr := channel.adr + day.adr;
      channel.guests := channel.guests + day.guests;
      channel.maxRate := channel.maxRate + day.maxRate;
      channel.minRate := channel.minRate + day.minRate;
      channel.occ := channel.occ + day.occ;
      channel.revPar := channel.revPar + day.revPar;
      channel.revenue := channel.revenue + day.revenue;
      channel.rooms := channel.rooms + day.rooms;
      channel.sold := channel.sold + day.sold;
      channel.totalDiscounts := channel.totalDiscounts + day.totalDiscounts;
    end;
    for l := 0 to day.Channel.Count - 1 do
    begin
       ch := day.Channel[l];
       if NOT channels.TryGetValue(ch.ChannelId, channel) then
       begin
          channel := TIdChannelValues.Create(ch.ChannelId,
            ch.ChannelName,
            ch.ChannelColor,
            ch.adr,
            ch.guests,
            ch.maxRate,
            ch.minRate,
            ch.occ,
            ch.revPar,
            ch.revenue,
            ch.rooms,
            ch.sold,
            0,
            0,
            0,
            0,
            0,
            0,
            ch.totalDiscounts);
          channels.Add(ch.ChannelId, channel);
       end else
       begin
         channel.adr := channel.adr + ch.adr;
         channel.guests := channel.guests + ch.guests;
         channel.maxRate := channel.maxRate + ch.maxRate;
         channel.minRate := channel.minRate + ch.minRate;
         channel.occ := channel.occ + ch.occ;
         channel.revPar := channel.revPar + ch.revPar;
         channel.revenue := channel.revenue + ch.revenue;
         channel.rooms := channel.rooms + ch.rooms;
         channel.sold := channel.sold + ch.sold;
         channel.totalDiscounts := channel.totalDiscounts + ch.totalDiscounts;
       end;
    end;
  end;
end;

function TfrmDaysStatistics.getTotalRevenue(performance : IXMLPerformanceType) : Double;
var i : Integer;
begin
  result := 0.00;
  for i := 0 to performance.Count - 1 do
    result := result + performance.Day[i].Revenue;
end;


{ TIdDValue }

constructor TIdDValue.Create(_id: Integer; _value: Double);
begin
  id := _id;
  value := _value;
end;

{ TIdChannelValues }

constructor TIdChannelValues.Create(_id: Integer; _name : String; _color : Integer; _adr: Double;
  _guests: Integer; _maxRate, _minRate, _occ, _revPar, _revenue: Double; _rooms,
  _sold: Integer;
  _arrivals : Integer;
  _departures : Integer;
  _checkedIn : Integer;
  _occupied : Integer;
  _departed : Integer;
  _noShow : Integer;
  _totalDiscounts: Double);
begin
  RatesAndAvailabilities := TList<TRatesAndAvails>.Create;
  id := _id;
  name := _name;
  color := _color;
  adr := _adr;
  guests := _guests;
  maxRate := _maxRate;
  minRate := _minRate;
  occ := _occ;
  revPar := _revPar;
  revenue := _revenue;
  rooms := _rooms;
  sold := _sold;
  arrivals := _arrivals;
  departures := _departures;
  checkedIn := _checkedIn;
  occupied := _occupied;
  departed := _departed;
  noShow := _noShow;
  totalDiscounts := _totalDiscounts;
end;

{ TRatesAndAvails }

constructor TRatesAndAvails.Create(_roomType: String; _totalRooms,
  _totalOccupied, _totalAvailable: Integer; _rate: Double);
begin
  roomType := _roomType;
  totalRooms := _totalRooms;
  totalOccupied := _totalOccupied;
  totalAvailable := _totalAvailable;
  rate := _rate;
end;

{ TIdSValue }

constructor TIdSValue.Create(_id: Integer; _value: String);
begin
  id := _id;
  value := _value;
end;

end.
