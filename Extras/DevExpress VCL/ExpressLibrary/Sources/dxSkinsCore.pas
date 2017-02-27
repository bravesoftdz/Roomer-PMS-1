
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2014 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxSkinsCore;

{$I cxVer.inc}
{$MINENUMSIZE 1} 

interface

uses
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  Types, Windows, SysUtils, Classes, Graphics, Math, cxGraphics, cxGeometry,
  cxClasses, cxLookAndFeels, dxGDIPlusApi, dxGDIPlusClasses, dxSkinsStrs, Forms,
  ActiveX, dxOffice11, dxCore, cxLookAndFeelPainters;

type
  TdxSkinVersion = Double;
  TdxSkinSignature = array[0..5] of AnsiChar;

  TdxSkinHeader = packed record
    Reserved: Integer;
    Signature: TdxSkinSignature;
    Version: TdxSkinVersion;
  end;

const
  dxSkinSignature: TdxSkinSignature = 'dxSkin';
  dxSkinStreamVersion: TdxSkinVersion = 1.10;
  dxSkinImageExt = '.png';

  GlyphNameSuffix = '_Glyph' + dxSkinImageExt;
  ImageNameSuffix = '_Image' + dxSkinImageExt;
  BitmapNameSuffixes: array[Boolean] of string = (GlyphNameSuffix, ImageNameSuffix);

type
  TdxSkin = class;
  TdxSkinBooleanProperty = class;
  TdxSkinCanvas = class;
  TdxSkinColor = class;
  TdxSkinControlGroup = class;
  TdxSkinControlGroupClass = class of TdxSkinControlGroup;
  TdxSkinCustomObject = class;
  TdxSkinCustomObjectClass = class of TdxSkinCustomObject;
  TdxSkinElement = class;
  TdxSkinElementCache = class;
  TdxSkinElementClass = class of TdxSkinElement;
  TdxSkinImage = class;
  TdxSkinIntegerProperty = class;
  TdxSkinPersistentClass = class of TdxSkinPersistent;
  TdxSkinProperty = class;
  TdxSkinPropertyClass = class of TdxSkinProperty;

  TdxSkinGradientMode = (gmHorizontal, gmVertical, gmForwardDiagonal, gmBackwardDiagonal);
  TdxSkinIconSize = (sis16, sis48);
  TdxSkinImageSet = (imsDefault, imsOriginal, imsAlternate);

  TdxSkinObjectState = (sosUnassigned, sosUnused);
  TdxSkinObjectStates = set of TdxSkinObjectState;

  TdxSkinChange = (scStruct, scContent, scDetails);
  TdxSkinChanges = set of TdxSkinChange;

  TdxSkinChangeNotify = procedure (Sender: TObject; AChanges: TdxSkinChanges) of object;

  EdxSkin = class(EdxException);

  { IdxSkinInfo }

  IdxSkinInfo = interface
  ['{97D85495-E631-413C-8DBC-BE7B784A9EA0}']
    function GetSkin: TdxSkin;
  end;

  { IdxSkinChangeListener }

  IdxSkinChangeListener = interface
  ['{28681774-0475-43AE-8704-1C904D294742}']
    procedure SkinChanged(Sender: TdxSkin);
  end;

  { IdxSkinChangeListener2 }

  IdxSkinChangeListener2 = interface
  ['{0D7C0942-D2C4-4579-AD03-A3CB5BBFC5AF}']
    procedure SkinChanged(ASkin: TdxSkin; AChanges: TdxSkinChanges);
  end;

  { TdxSkinCustomObject }

  TdxSkinCustomObject = class(TPersistent)
  private
    FName: string;
    FOwner: TPersistent;
    FState: TdxSkinObjectStates;
    FTag: Integer;
    FOnChange: TdxSkinChangeNotify;
    procedure SetName(const AValue: string);
  protected
    function GetOwner: TPersistent; override;
    procedure Changed(AChanges: TdxSkinChanges); virtual;
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); virtual;
    procedure DataWrite(Stream: TStream); virtual;
    procedure DoChanged(AChanges: TdxSkinChanges); virtual;
  public
    constructor Create(AOwner: TPersistent; const AName: string); virtual;

    property State: TdxSkinObjectStates read FState write FState;
    property Tag: Integer read FTag write FTag;
  published
    property Name: string read FName write SetName;
    property OnChange: TdxSkinChangeNotify read FOnChange write FOnChange;
  end;

  { TdxSkinCustomObjectList }

  TdxSkinCustomObjectList = class(TcxObjectList)
  private
    FChanges: TdxSkinChanges;
    FOwner: TPersistent;
    FSorted: Boolean;
    FUpdateCount: Integer;
    FOnChange: TdxSkinChangeNotify;
    procedure SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
  protected
    procedure Changed(AChanges: TdxSkinChanges); virtual;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); virtual; abstract;
    procedure DataWrite(AStream: TStream); virtual; abstract;
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    //
    property OnChange: TdxSkinChangeNotify read FOnChange write FOnChange;
  public
    constructor Create(AOwner: TPersistent); virtual;
    constructor CreateEx(AOwner: TPersistent; AChangeHandler: TdxSkinChangeNotify);
    function FindItemByName(const AName: string): TdxSkinCustomObject;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Exchange(Index1, Index2: Integer);
    procedure Sort;
  end;

  { TdxSkinProperties }

  TdxSkinProperties = class(TdxSkinCustomObjectList)
  private
    function GetItem(Index: Integer): TdxSkinProperty;
  protected
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    function Add(const AName: string; AClass: TdxSkinPropertyClass): TdxSkinProperty;
    procedure Assign(ASource: TdxSkinProperties);
    function Compare(AProperties: TdxSkinProperties): Boolean;
    function FindItemByName(const AName: string): TdxSkinProperty;
    //
    property Items[Index: Integer]: TdxSkinProperty read GetItem; default;
  end;

  { TdxSkinColors }

  TdxSkinColors = class(TdxSkinProperties)
  private
    function GetItem(Index: Integer): TdxSkinColor;
  public
    function Add(const AName: string; AValue: TColor): TdxSkinColor;
    function FindItemByName(const AName: string): TdxSkinColor;
    //
    property Items[Index: Integer]: TdxSkinColor read GetItem; default;
  end;

  { TdxSkinControlGroups }

  TdxSkinControlGroups = class(TdxSkinCustomObjectList)
  private
    function GetItem(Index: Integer): TdxSkinControlGroup;
  public
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    function Add(const AName: string): TdxSkinControlGroup;
    procedure Assign(ASource: TdxSkinControlGroups);
    function FindItemByName(const AName: string): TdxSkinControlGroup;
    //
    property Items[Index: Integer]: TdxSkinControlGroup read GetItem; default;
  end;

  { TdxSkinElements }

  TdxSkinElements = class(TdxSkinCustomObjectList)
  private
    function GetItem(Index: Integer): TdxSkinElement;
  protected
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    function Add(const AName: string; AClass: TdxSkinElementClass): TdxSkinElement;
    procedure Assign(ASource: TdxSkinElements);
    function FindItemByName(const AName: string): TdxSkinElement;
    //
    property Items[Index: Integer]: TdxSkinElement read GetItem; default;
  end;

  { TdxSkinPersistent }

  TdxSkinPersistent = class(TdxSkinCustomObject)
  private
    FChanges: TdxSkinChanges;
    FModified: Boolean;
    FUpdateCount: Integer;
    function GetProperty(Index: Integer): TdxSkinProperty;
    function GetPropertyCount: Integer;
  protected
    FProperties: TdxSkinProperties;
    procedure Changed(AChanges: TdxSkinChanges); override;
    procedure SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
    //
    property UpdateCount: Integer read FUpdateCount write FUpdateCount;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //
    function AddProperty(const AName: string; APropertyClass: TdxSkinPropertyClass): TdxSkinProperty;
    function AddPropertyBool(const AName: string; AValue: Boolean): TdxSkinBooleanProperty;
    function AddPropertyColor(const AName: string; AValue: TColor): TdxSkinColor;
    function AddPropertyInteger(const AName: string; AValue: Integer): TdxSkinIntegerProperty;
    //
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    //
    procedure Clear; virtual;
    procedure DeleteProperty(const AProperty: TdxSkinProperty); overload; virtual;
    procedure DeleteProperty(const APropertyName: string); overload;
    procedure ExchangeProperty(AIndex1, AIndex2: Integer);
    function GetPropertyByName(const AName: string): TdxSkinProperty; overload;
    function GetPropertyByName(const AName: string; out AProperty: TdxSkinProperty): Boolean; overload;
    procedure Sort; virtual;
    //
    property Modified: Boolean read FModified write FModified;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TdxSkinProperty read GetProperty;
  end;

  { TdxSkinDetails }

  TdxSkinDetails = class(TPersistent)
  private
    FDisplayName: string;
    FGroupName: string;
    FIcons: array [TdxSkinIconSize] of TdxPNGImage;
    FName: string;
    FNotes: WideString;
    FOnChange: TNotifyEvent;
    FUpdateCount: Integer;
    function GetIcon(ASize: TdxSkinIconSize): TdxPNGImage;
    procedure DoIconsChanged(Sender: TObject);
    procedure SetDisplayName(const AValue: string);
    procedure SetGroupName(const AValue: string);
    procedure SetName(const AValue: string);
    procedure SetNotes(const AValue: WideString);
  protected
    FDataOffset: Int64;
    procedure Changed; virtual;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); virtual;
    procedure DataWrite(AStream: TStream); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear; virtual;
    function LoadFromStream(AStream: TStream): Boolean;
    procedure ResetIcon(ASize: TdxSkinIconSize);
    //
    property DisplayName: string read FDisplayName write SetDisplayName;
    property GroupName: string read FGroupName write SetGroupName;
    property Icons[ASize: TdxSkinIconSize]: TdxPNGImage read GetIcon;
    property Name: string read FName write SetName;
    property Notes: WideString read FNotes write SetNotes;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TdxSkin }

  TdxSkinClass = class of TdxSkin;
  TdxSkin = class(TdxSkinPersistent)
  private
    FDestroying: Boolean;
    FDetails: TdxSkinDetails;
    FGroups: TdxSkinControlGroups;
    FListeners: TInterfaceList;
    FOnChange: TdxSkinChangeNotify;
    function GetColor(Index: Integer): TdxSkinColor;
    function GetColorCount: Integer;
    function GetDisplayName: string;
    function GetGroup(Index: Integer): TdxSkinControlGroup;
    function GetGroupCount: Integer;
    function GetHasMissingElements: Boolean;
    function GetName: string;
    procedure SetName(const Value: string);
    procedure DetailsChanged(Sender: TObject);
  protected
    FColors: TdxSkinColors;
    procedure DoChanged(AChanges: TdxSkinChanges); override;
    procedure LoadFromResource(hInst: THandle); virtual;
    procedure NotifyListener(AChanges: TdxSkinChanges; ACustomListener: IUnknown);
    procedure NotifyListeners(AChanges: TdxSkinChanges);
    procedure ReadDetailsFromOldSkinFormat;

    property Listeners: TInterfaceList read FListeners;
  public
    constructor Create(const AName: string; ALoadOnCreate: Boolean; hInst: THandle); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure Assign(Source: TPersistent); override;
    function AddColor(const AName: string; const AColor: TColor): TdxSkinColor;
    function AddGroup(const AName: string = ''): TdxSkinControlGroup;
    procedure Clear; override;
    procedure ClearModified;
    function Clone(const AName: string): TdxSkin; reintroduce; virtual;
    procedure DeleteGroup(const AGroup: TdxSkinControlGroup); virtual;
    procedure DeleteProperty(const AProperty: TdxSkinProperty); override;
    procedure ExchangeColors(AIndex1, AIndex2: Integer);
    procedure ExchangeGroups(AIndex1, AIndex2: Integer);
    function GetColorByName(const AName: string): TdxSkinColor;
    function GetGroupByName(const AName: string): TdxSkinControlGroup; overload;
    function GetGroupByName(const AName: string; out AGroup: TdxSkinControlGroup): Boolean; overload;
    procedure LoadFromBinaryFile(const AFileName: string);
    procedure LoadFromBinaryStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream); virtual;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream); virtual;
    procedure SaveToBinaryFile(const AFileName: string);
    procedure SaveToBinaryStream(AStream: TStream);
    procedure Sort; override;
    //
    procedure AddListener(AListener: IUnknown);
    procedure RemoveListener(AListener: IUnknown);
    //
    property ColorCount: Integer read GetColorCount;
    property Colors[Index: Integer]: TdxSkinColor read GetColor;
    property Details: TdxSkinDetails read FDetails;
    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TdxSkinControlGroup read GetGroup;
    property HasMissingElements: Boolean read GetHasMissingElements;
  published
    property DisplayName: string read GetDisplayName;
    property Name: string read GetName write SetName;
    property OnChange: TdxSkinChangeNotify read FOnChange write FOnChange;
  end;

  { TdxSkinProperty }

  TdxSkinProperty = class(TdxSkinCustomObject)
  public
    class procedure Register;
    class procedure Unregister;
    class function Description: string; virtual;
    function Compare(AProperty: TdxSkinProperty): Boolean; virtual;
  end;

  { TdxSkinIntegerProperty }

  TdxSkinIntegerProperty = class(TdxSkinProperty)
  private
    FValue: Integer;
    procedure SetValue(AValue: Integer);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: Integer read FValue write SetValue default 0;
  end;

  { TdxSkinBooleanProperty }

  TdxSkinBooleanProperty = class(TdxSkinProperty)
  private
    FValue: Boolean;
    procedure SetValue(AValue: Boolean);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: Boolean read FValue write SetValue default False;
  end;

  { TdxSkinColor }

  TdxSkinColor = class(TdxSkinProperty)
  private
    FValue: TColor;
    procedure SetValue(AValue: TColor);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: TColor read FValue write SetValue default clDefault;
  end;

  { TdxSkinRectProperty }

  TdxSkinRectProperty = class(TdxSkinProperty)
  private
    FValue: TcxRect;
    function GetValueByIndex(Index: Integer): Integer;
    procedure SetValue(Value: TcxRect);
    procedure SetValueByIndex(Index, Value: Integer);
    procedure InternalHandler(Sender: TObject);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;

    property Value: TcxRect read FValue write SetValue;
  published
    property Left: Integer index 0 read GetValueByIndex write SetValueByIndex default 0;
    property Top: Integer index 1 read GetValueByIndex write SetValueByIndex default 0;
    property Right: Integer index 2 read GetValueByIndex write SetValueByIndex default 0;
    property Bottom: Integer index 3 read GetValueByIndex write SetValueByIndex default 0;
  end;

  { TdxSkinSizeProperty }

  TdxSkinSizeProperty = class(TdxSkinProperty)
  private
    FValue: TSize;
    procedure SetValue(const AValue: TSize);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    function GetValueByIndex(Index: Integer): Integer;
    procedure SetValueByIndex(Index, Value: Integer);

    property Value: TSize read FValue write SetValue;
  published
    property cx: Integer index 0 read GetValueByIndex write SetValueByIndex default 0;
    property cy: Integer index 1 read GetValueByIndex write SetValueByIndex default 0;
  end;

  { TdxSkinBorder }

  TdxSkinBorder = class(TdxSkinProperty)
  private
    FColor: TColor;
    FKind: TcxBorder;
    FThin: Integer;
    function GetContentMargin: Integer;
    procedure SetColor(AValue: TColor);
    procedure SetThin(AValue: Integer);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    procedure Draw(DC: HDC; const ABounds: TRect); virtual;
    procedure DrawEx(ACanvas: TdxSkinCanvas; const ABounds: TRect); virtual;
    procedure ResetToDefaults; virtual;

    property ContentMargin: Integer read GetContentMargin;
    property Kind: TcxBorder read FKind;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property Thin: Integer read FThin write SetThin default 1;
  end;

  { TdxSkinBorders }

  TdxSkinBorders = class(TdxSkinProperty)
  private
    FBorders: array[TcxBorder] of TdxSkinBorder;
    function GetBorder(ABorder: TcxBorder): TdxSkinBorder;
    function GetBorderByIndex(Index: Integer): TdxSkinBorder;
    function GetContentMargins: TRect;
    procedure SetBorderByIndex(Index: Integer; AValue: TdxSkinBorder);
    procedure SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
  protected
    procedure CreateBorders;
    procedure DeleteBorders;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    procedure Draw(ACanvas: TdxSkinCanvas; const ABounds: TRect); virtual;
    procedure ResetToDefaults; virtual;
    //
    property ContentMargins: TRect read GetContentMargins;
    property Items[AKind: TcxBorder]: TdxSkinBorder read GetBorder; default;
  published
    property Left: TdxSkinBorder index 0 read GetBorderByIndex write SetBorderByIndex;
    property Top: TdxSkinBorder index 1 read GetBorderByIndex write SetBorderByIndex;
    property Right: TdxSkinBorder index 2 read GetBorderByIndex write SetBorderByIndex;
    property Bottom: TdxSkinBorder index 3 read GetBorderByIndex write SetBorderByIndex;
  end;

  { TdxSkinStringProperty }

  TdxSkinStringProperty = class(TdxSkinProperty)
  private
    FValue: string;
    procedure SetValue(const AValue: string);
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
  published
    property Value: string read FValue write SetValue;
  end;

  { TdxSkinWideStringProperty }

  TdxSkinWideStringProperty = class(TdxSkinStringProperty)
  protected
    procedure DataRead(Stream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(Stream: TStream); override;
  public
    procedure Assign(Source: TPersistent); override;
  end;

  { TdxSkinAlternateImageAttributes }

  TdxSkinAlternateImageAttributes = class(TdxSkinProperty)
  private
    FAlpha: Byte;
    FBorders: TdxSkinBorders;
    FBordersInner: TdxSkinBorders;
    FContentOffsets: TcxRect;
    FGradient: TdxSkinGradientMode;
    FGradientBeginColor: TColor;
    FGradientEndColor: TColor;
    function GetIsAlphaUsed: Boolean;
    procedure BordersChanged(ASender: TObject; AChanges: TdxSkinChanges);
    procedure ContentOffsetsChanged(ASender: TObject);
    procedure SetAlpha(AValue: Byte);
    procedure SetBorders(AValue: TdxSkinBorders);
    procedure SetBordersInner(AValue: TdxSkinBorders);
    procedure SetContentOffsets(AValue: TcxRect);
    procedure SetGradientBeginColor(AValue: TColor);
    procedure SetGradientEndColor(AValue: TColor);
    procedure SetGradientMode(AValue: TdxSkinGradientMode);
  protected
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TdxSkinCanvas; const R: TRect); virtual;
    function Compare(AProperty: TdxSkinProperty): Boolean; override;
    //
    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
  published
    property Alpha: Byte read FAlpha write SetAlpha default 255;
    property Borders: TdxSkinBorders read FBorders write SetBorders;
    property BordersInner: TdxSkinBorders read FBordersInner write SetBordersInner;
    property ContentOffsets: TcxRect read FContentOffsets write SetContentOffsets;
    property Gradient: TdxSkinGradientMode read FGradient write SetGradientMode default gmHorizontal;
    property GradientBeginColor: TColor read FGradientBeginColor write SetGradientBeginColor default clNone;
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor default clNone;
  end;

  { TdxSkinControlGroup }

  TdxSkinControlGroup = class(TdxSkinPersistent)
  private
    function GetCount: Integer;
    function GetElement(AIndex: Integer): TdxSkinElement;
    function GetHasMissingElements: Boolean;
    function GetSkin: TdxSkin;
    procedure SetElement(AIndex: Integer; AElement: TdxSkinElement);
  protected
    FElements: TdxSkinElements;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    function AddElement(const AName: string): TdxSkinElement;
    function AddElementEx(const AName: string; AElementClass: TdxSkinElementClass): TdxSkinElement;
    function GetElementByName(const AName: string): TdxSkinElement; overload;
    function GetElementByName(const AName: string; out AElement: TdxSkinElement): Boolean; overload;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure ClearModified;
    procedure Delete(AIndex: Integer);
    procedure ExchangeElements(AIndex1, AIndex2: Integer);
    procedure RemoveElement(AElement: TdxSkinElement);
    procedure RemoveElementByName(const AElementName: string);
    procedure Sort; override;
    //
    property Count: Integer read GetCount;
    property Elements[Index: Integer]: TdxSkinElement read GetElement write SetElement;
    property HasMissingElements: Boolean read GetHasMissingElements;
    property Skin: TdxSkin read GetSkin;
  end;

  { TdxSkinImage }

  TdxSkinElementState = (esNormal, esHot, esPressed, esDisabled, esActive,
    esFocused, esDroppedDown, esChecked, esHotCheck, esActiveDisabled, esCheckPressed);
  TdxSkinElementStates = set of TdxSkinElementState;

  TdxSkinImagePart = (
    sipTopLeft,    sipTop,    sipTopRight,
    sipLeft,       sipCenter, sipRight,
    sipBottomLeft, sipBottom, sipBottomRight
  );

  TdxSkinElementPartBounds = array[TdxSkinImagePart] of TRect;
  TdxSkinElementPartVisibility = array[TdxSkinImagePart] of Boolean;

  TdxSkinImageLayout = (ilHorizontal, ilVertical);
  TdxSkinStretchMode = (smStretch, smTile, smNoResize);

  TdxSkinImage = class(TPersistent)
  private
    FGradient: TdxSkinGradientMode;
    FGradientBeginColor: TColor;
    FGradientEndColor: TColor;
    FImageCount: Integer;
    FImageLayout: TdxSkinImageLayout;
    FIsDirty: Boolean;
    FMargins: TcxMargin;
    FOwner: TdxSkinElement;
    FPartsBounds: TdxSkinElementPartBounds;
    FPartsVisibility: TdxSkinElementPartVisibility;
    FSize: TSize;
    FSourceName: string;
    FStateBounds: array[TdxSkinElementState] of TRect;
    FStateCount: Integer;
    FStates: TdxSkinElementStates;
    FStretch: TdxSkinStretchMode;
    FTexture: TdxPNGImage;
    FTransparentColor: TColor;
    FOnChange: TNotifyEvent;
    function GetEmpty: Boolean;
    function GetIsGradientParamsAssigned: Boolean;
    function GetName: string;
    function GetPartBounds(APart: TdxSkinImagePart): TRect;
    function GetPartVisible(APart: TdxSkinImagePart): Boolean;
    function GetSize: TSize;
    function GetSourceName: string;
    function GetStateBounds(AImageIndex: Integer; AState: TdxSkinElementState): TRect;
    function GetStateCount: Integer;
    procedure SetGradientBeginColor(AValue: TColor);
    procedure SetGradientEndColor(AValue: TColor);
    procedure SetGradientMode(AValue: TdxSkinGradientMode);
    procedure SetImageCount(AValue: Integer);
    procedure SetImageLayout(AValue: TdxSkinImageLayout);
    procedure SetMargins(AValue: TcxMargin);
    procedure SetName(const AValue: string);
    procedure SetStates(AValue: TdxSkinElementStates);
    procedure SetStretch(AValue: TdxSkinStretchMode);
    procedure SetTransparentColor(AValue: TColor);
    procedure SubItemChanged(ASender: TObject);
  protected
    function GetOwner: TPersistent; override;
    procedure Changed; virtual;
    procedure CheckInfo;
    procedure CheckState(var AState: TdxSkinElementState; var AImageIndex: Integer);
    procedure InitializeInfo; virtual;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
    procedure DataWrite(AStream: TStream);

    property IsDirty: Boolean read FIsDirty write FIsDirty;
    property IsGradientParamsAssigned: Boolean read GetIsGradientParamsAssigned;
    property PartBounds[APart: TdxSkinImagePart]: TRect read GetPartBounds;
    property PartVisible[APart: TdxSkinImagePart]: Boolean read GetPartVisible;
    property TransparentColor: TColor read FTransparentColor write SetTransparentColor;
  public
    constructor Create(AOwner: TdxSkinElement); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function Compare(AImage: TdxSkinImage): Boolean; virtual; 
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); virtual;
    procedure DrawEx(ACanvas: TdxSkinCanvas; const ARect: TRect;
      AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal); virtual;
    procedure GetBitmap(AImageIndex: Integer; AState: TdxSkinElementState;
      ABitmap: TBitmap; ABackgroundColor: TColor = clNone);
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromResource(AInstance: THandle; const AName: string; AType: PChar);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream);
    procedure SetStateMapping(AStateOrder: array of TdxSkinElementState);

    property Empty: Boolean read GetEmpty;
    property Name: string read GetName write SetName;
    property Owner: TdxSkinElement read FOwner;
    property Size: TSize read GetSize;
    property SourceName: string read GetSourceName;
    property StateBounds[ImageIndex: Integer; State: TdxSkinElementState]: TRect read GetStateBounds;
    property StateCount: Integer read GetStateCount;
    property Texture: TdxPNGImage read FTexture;
  published
    property Gradient: TdxSkinGradientMode read FGradient write SetGradientMode default gmHorizontal;
    property GradientBeginColor: TColor read FGradientBeginColor write SetGradientBeginColor default clNone;
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor default clNone;
    property ImageCount: Integer read FImageCount write SetImageCount default 1;
    property ImageLayout: TdxSkinImageLayout read FImageLayout write SetImageLayout default ilHorizontal;
    property Margins: TcxMargin read FMargins write SetMargins;
    property States: TdxSkinElementStates read FStates write SetStates default [esNormal];
    property Stretch: TdxSkinStretchMode read FStretch write SetStretch default smStretch;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TdxSkinCanvas }

  TdxSkinCanvas = class(TObject)
  private
    FGraphics: TdxGPGraphics;
    FLowColorsMode: Boolean;
  public
    procedure BeginPaint(AGraphics: GpGraphics); overload;
    procedure BeginPaint(DC: HDC; const R: TRect); overload;
    procedure EndPaint; overload;
    //
    procedure DrawFrame(const R: TRect; AColor: TColor; ALineWidth: Integer = 1;
      ABorders: TcxBorders = cxBordersAll; AAlpha: Byte = 255);
    procedure DrawImage(AImage: TdxSkinImage; const ADestRect, ASourceRect: TRect);
    procedure DrawTexture(ATexture: TdxGPImage; const R: TRect; AStretchMode: TdxSkinStretchMode);
    procedure FillRectByColor(const R: TRect; AColor: TColor; AAlpha: Byte = 255);
    procedure FillRectByGradient(const R: TRect; AColor1: TColor;
      AColor2: TColor; AMode: TdxSkinGradientMode; AAlpha: Byte = 255);
    function IsRectVisible(DC: HDC; const R: TRect): Boolean;
    //
    property Graphics: TdxGPGraphics read FGraphics;
    property LowColorsMode: Boolean read FLowColorsMode;
  end;

  { TdxSkinElement }

  TdxSkinAlternateImageSet = array[TdxSkinElementState] of TdxSkinAlternateImageAttributes;

  TdxSkinElement = class(TdxSkinPersistent)
  private
    FAlpha: Byte;
    FAlternateImageSetDirty: Boolean;
    FAlternateImageSetIndex: Integer;
    FBorders: TdxSkinBorders;
    FCache: TdxSkinElementCache;
    FColor: TColor;
    FContentOffset: TcxRect;
    FGlyph: TdxSkinImage;
    FImage: TdxSkinImage;
    FMinSize: TcxSize;
    FTextColor: TColor;
    function GetGroup: TdxSkinControlGroup;
    function GetImageCount: Integer;
    function GetIsAlphaUsed: Boolean;
    function GetPath: string;
    function GetSize: TSize;
    function GetStates: TdxSkinElementStates;
    function GetUseCache: Boolean;
    procedure SetAlpha(AValue: Byte);
    procedure SetBorders(AValue: TdxSkinBorders);
    procedure SetColor(AValue: TColor);
    procedure SetContentOffset(AValue: TcxRect);
    procedure SetGlyph(AValue: TdxSkinImage);
    procedure SetImage(AValue: TdxSkinImage);
    procedure SetMinSize(AValue: TcxSize);
    procedure SetTextColor(AValue: TColor);
    procedure SetUseCache(AValue: Boolean);
    procedure BordersChanged(ASender: TObject; AChanges: TdxSkinChanges);
    procedure SubItemChanged(ASender: TObject);
  protected
    FAlternateImageSet: TdxSkinAlternateImageSet;
    FReadedImageCount: Integer;
    function ExpandName(ABitmap: TdxSkinImage): string; virtual;
    function CanUseAlternateImageSet(AImageIndex: Integer; AState: TdxSkinElementState;
      ALowColorsMode: Boolean; out AStateAttributes: TdxSkinAlternateImageAttributes): Boolean;
    procedure CheckAlternateImageSet(AIndex: Integer);
    procedure Changed(AChanges: TdxSkinChanges); override;
    procedure DataRead(AStream: TStream; const AVersion: TdxSkinVersion); override;
    procedure DataWrite(AStream: TStream); override;
    //
    property AlternateImageSetDirty: Boolean read FAlternateImageSetDirty write FAlternateImageSetDirty;
    property AlternateImageSetIndex: Integer read FAlternateImageSetIndex;
  public
    constructor Create(AOwner: TPersistent; const AName: string); override;
    destructor Destroy; override;
    function AddAlternateImageAttributes(AState: TdxSkinElementState;
      AImageIndex: Integer = 0): TdxSkinAlternateImageAttributes;
    procedure Assign(Source: TPersistent); override;
    function Compare(AElement: TdxSkinElement): Boolean; virtual;
    function GetTextColor(AState: TcxButtonState; const APropertyPrefix: string = ''): TColor; virtual;
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); virtual;
    procedure DrawEx(ACanvas: TdxSkinCanvas; const ARect: TRect;
      AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
    procedure SetStateMapping(AStateOrder: array of TdxSkinElementState);
    //
    property Group: TdxSkinControlGroup read GetGroup;
    property ImageCount: Integer read GetImageCount;
    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
    property Path: string read GetPath;
    property Size: TSize read GetSize;
    property States: TdxSkinElementStates read GetStates;
    property UseCache: Boolean read GetUseCache write SetUseCache;
  published
    property Alpha: Byte read FAlpha write SetAlpha default 255;
    property Borders: TdxSkinBorders read FBorders write SetBorders;
    property Color: TColor read FColor write SetColor default clDefault;
    property ContentOffset: TcxRect read FContentOffset write SetContentOffset;
    property Glyph: TdxSkinImage read FGlyph write SetGlyph;
    property Image: TdxSkinImage read FImage write SetImage;
    property MinSize: TcxSize read FMinSize write SetMinSize;
    property TextColor: TColor read FTextColor write SetTextColor default clDefault;
  end;

  { TdxSkinEmptyElement }

  TdxSkinEmptyElement = class(TdxSkinElement)
  public
    procedure Draw(DC: HDC; const ARect: TRect; AImageIndex: Integer = 0;
      AState: TdxSkinElementState = esNormal); override;
  end;

  { TdxSkinElementCache }

  TdxSkinElementCache = class(TObject)
  private
    FCache: GpBitmap;
    FCacheOpaque: TcxBitmap;
    FElement: TdxSkinElement;
    FImageIndex: Integer;
    FImageSet: TdxSkinImageSet;
    FRect: TRect;
    FState: TdxSkinElementState;
    procedure FreeCache;
    procedure InitCache(R: TRect);
    procedure InitOpaqueCache(R: TRect);
  protected
    property Element: TdxSkinElement read FElement;
    property ImageIndex: Integer read FImageIndex;
    property State: TdxSkinElementState read FState;
  public
    destructor Destroy; override;
    procedure CheckCacheState(AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Draw(DC: HDC; const R: TRect);
    procedure DrawEx(DC: HDC; AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Flush;
  end;

  { TdxSkinElementCacheList }

  TdxSkinElementCacheList = class(TcxObjectList)
  private
    FCacheListLimit: Integer;
    procedure CheckListLimits;
    function FindElementCache(AElement: TdxSkinElement; const R: TRect; out AElementCache: TdxSkinElementCache): Boolean;
    function GetElementCache(AIndex: Integer): TdxSkinElementCache;
  public
    constructor Create;
    procedure DrawElement(DC: HDC; AElement: TdxSkinElement; const R: TRect;
      AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
    procedure Flush;
    //
    property CacheListLimit: Integer read FCacheListLimit write FCacheListLimit;
    property ElementCache[Index: Integer]: TdxSkinElementCache read GetElementCache;
  end;

  { TdxSkinBinaryWriter }

  TdxSkinBinaryWriter = class(TObject)
  private
    FCount: Integer;
    FHeaderOffset: Int64;
    FStream: TStream;
    procedure WriteHeader;
  protected
    property Stream: TStream read FStream;
  public
    constructor Create(AStream: TStream); virtual;
    destructor Destroy; override;
    procedure AddSkin(ASkin: TdxSkin);
  end;

  { TdxSkinBinaryReader }

  TdxSkinBinaryReader = class(TObject)
  private
    FSkins: TcxObjectList;
    FStream: TStream;
    function GetCount: Integer;
    function GetSkinDetails(Index: Integer): TdxSkinDetails;
    function GetSkinDisplayName(Index: Integer): string;
    function GetSkinName(Index: Integer): string;
    function GetSkinOffset(Index: Integer): Integer;
  protected
    function IndexOf(const ASkinName: string): Integer;
    function ReadBinaryProject(AStream: TStream): Boolean;
    function ReadBinarySkin(AStream: TStream): Boolean;
    procedure ReadSkinsInfo;
    //
    property Stream: TStream read FStream;
  public
    constructor Create(AStream: TStream); virtual;
    destructor Destroy; override;
    function LoadSkin(ASkin: TdxSkin; ASkinIndex: Integer): Boolean; overload;
    function LoadSkin(ASkin: TdxSkin; const ASkinName: string): Boolean; overload;
    //
    property Count: Integer read GetCount;
    property SkinDetails[Index: Integer]: TdxSkinDetails read GetSkinDetails;
    property SkinDisplayName[Index: Integer]: string read GetSkinDisplayName;
    property SkinName[Index: Integer]: string read GetSkinName;
    property SkinOffset[Index: Integer]: Integer read GetSkinOffset;
  end;

const
  dxSkinElementTextColorPropertyNames: array[TcxButtonState] of string = (
    '', sdxTextColorNormal, sdxTextColorHot, sdxTextColorPressed, sdxTextColorDisabled
  );

  dxSkinElementStateNames: array[TdxSkinElementState] of string = (
    'Normal', 'Hot', 'Pressed', 'Disabled',  'Active', 'Focused',
    'DroppedDown', 'Checked', 'HotCheck', 'ActiveDisabled', 'CheckPressed'
  );

var
  dxSkinsUseImageSet: TdxSkinImageSet = imsDefault;

function dxSkinRegisteredPropertyTypes: TList;

procedure dxSkinInvalidOperation(const AMessage: string);
procedure dxSkinCheck(ACondition: Boolean; const AMessage: string);
function dxSkinCheckSignature(AStream: TStream; out AVersion: TdxSkinVersion): Boolean;
function dxSkinCheckSkinElement(AElement: TdxSkinElement): TdxSkinElement;
procedure dxSkinCheckVersion(const AVersion: TdxSkinVersion);
procedure dxSkinWriteSignature(AStream: TStream);

procedure dxSkinsCalculatePartsBounds(const R, AMargins: TRect; var AParts);
procedure dxSkinsCheckMargins(var AMargins: TRect; const R: TRect);

function dxSkinGetAlternateImageAttrsPropertyName(
  AState: TdxSkinElementState; AImageIndex: Integer = 0): string;

function dxSkinReadStringFromStream(AStream: TStream): string;
function dxSkinReadWideStringFromStream(AStream: TStream): WideString;
procedure dxSkinWriteStringToStream(AStream: TStream; const AValue: string);
procedure dxSkinWriteWideStringToStream(AStream: TStream; const AValue: WideString);

function dxSkinElementCheckState(AElement: TdxSkinElement; AState: TdxSkinElementState): TdxSkinElementState;

implementation

{$R dxSkinInfo.res}

const
  dxSkinElementCacheListLimit = 8;
  
type
  { TdxSkinPartStream }

  TdxSkinPartStream = class(TStream)
  private
    FPosEnd: Longint;
    FPosStart: Longint;
    FSource: TStream;
  protected
    function GetSize: Int64; override;
  public
    constructor Create(ASource: TStream; const APosStart, ASize: LongInt); virtual;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;

    property PosEnd: Longint read FPosEnd;
    property PosStart: Longint read FPosStart;
    property Source: TStream read FSource;
  end;

var
  dxSkinEmptyElement: TdxSkinElement;
  RegisteredPropertyTypes: TList;

function dxSkinGetAlternateImageAttrsPropertyName(
  AState: TdxSkinElementState; AImageIndex: Integer = 0): string;
begin
  Result := sdxAlternateImage + IntToStr(AImageIndex + 1) + dxSkinElementStateNames[AState]
end;

function dxSkinReadStringFromStream(AStream: TStream): string;
var
  ALen: Integer;
  AStr: AnsiString;
begin
  AStream.ReadBuffer(ALen, SizeOf(ALen));
  SetLength(AStr, ALen);
  if ALen > 0 then
    AStream.ReadBuffer(AStr[1], ALen);
  Result := dxAnsiStringToString(AStr);
end;

function dxSkinReadWideStringFromStream(AStream: TStream): WideString;
var
  ALen: Integer;
begin
  AStream.ReadBuffer(ALen, SizeOf(ALen));
  SetLength(Result, ALen);
  if ALen > 0 then
    AStream.ReadBuffer(Result[1], ALen * SizeOf(WideChar))
  else
    Result := '';
end;

function ReadInteger(AStream: TStream): Integer;
begin
  AStream.ReadBuffer(Result, SizeOf(Result));
end;

procedure ReadPngImage(AStream: TStream; AImage: TdxPNGImage);
var
  APartStream: TdxSkinPartStream;
  ASavedPosition: Int64;
  ASize: Integer;
begin
  AStream.ReadBuffer(ASize, SizeOf(Integer));
  if ASize > 0 then
  begin
    ASavedPosition := AStream.Position;
    try
      APartStream := TdxSkinPartStream.Create(AStream, AStream.Position, ASize);
      try
        AImage.LoadFromStream(APartStream);
      finally
        APartStream.Free;
      end;
    finally
      AStream.Position := ASavedPosition + ASize;
    end;
  end;
end;

procedure WritePngImage(AStream: TStream; AImage: TdxPNGImage);
var
  APNGStream: TMemoryStream;
  ASize: Integer;
begin
  APNGStream := TMemoryStream.Create;
  try
    if not AImage.Empty then
      AImage.SaveToStream(APNGStream);
    ASize := APNGStream.Size;
    AStream.WriteBuffer(ASize, SizeOf(Integer));
    if ASize > 0 then
    begin
      APNGStream.Position := 0;
      AStream.WriteBuffer(APNGStream.Memory^, APNGStream.Size);
    end;
  finally
    APNGStream.Free;
  end;
end;

procedure dxSkinWriteStringToStream(AStream: TStream; const AValue: string);
var
  AStr: AnsiString;
  L: Integer;
begin
  AStr := dxStringToAnsiString(AValue);
  L := Length(AStr);
  AStream.WriteBuffer(L, SizeOf(L));
  if L > 0 then
    AStream.WriteBuffer(AStr[1], L);
end;

procedure dxSkinWriteWideStringToStream(AStream: TStream; const AValue: WideString);
var
  ALen: Integer;
begin
  ALen := Length(AValue);
  AStream.WriteBuffer(ALen, SizeOf(ALen));
  if ALen > 0 then
    AStream.WriteBuffer(AValue[1], ALen * SizeOf(WideChar));
end;

function dxSkinRegisteredPropertyTypes: TList;
begin
  Result := RegisteredPropertyTypes; 
end;

procedure dxSkinInvalidOperation(const AMessage: string);
begin
  raise EdxSkin.Create(AMessage);
end;

procedure dxSkinCheck(ACondition: Boolean; const AMessage: string);
begin
  if not ACondition then
     dxSkinInvalidOperation(AMessage);
end;

procedure dxSkinCheckVersion(const AVersion: TdxSkinVersion);
begin
  if AVersion < 1.00 then
    raise EdxSkin.Create(sdxOldFormat);
end;

function dxSkinCheckSignature(AStream: TStream; out AVersion: TdxSkinVersion): Boolean;
var
  AHeader: TdxSkinHeader;
begin
  Result := (AStream.Read(AHeader, SizeOf(AHeader)) = SizeOf(AHeader)) and
    (AHeader.Signature = dxSkinSignature) and (AHeader.Version >= 1.00);
  if Result then
    AVersion := AHeader.Version;
end;

function dxSkinCheckSkinElement(AElement: TdxSkinElement): TdxSkinElement;
begin
  Result := AElement;
  if Result = nil then
    Result := dxSkinEmptyElement;
end;

procedure dxSkinWriteSignature(AStream: TStream);
var
  AHeader: TdxSkinHeader;
begin
  ZeroMemory(@AHeader, SizeOf(AHeader));
  AHeader.Signature := dxSkinSignature;
  AHeader.Version := dxSkinStreamVersion;
  AStream.WriteBuffer(AHeader, SizeOf(AHeader));
end;

procedure dxSkinsCalculatePartsBounds(const R, AMargins: TRect; var AParts);
var
  R1: TRect;
begin
  R1.Top := Min(R.Top + AMargins.Top, R.Bottom);
  R1.Right := Max(R.Right - AMargins.Right, R.Left);
  R1.Bottom := Max(R.Bottom - AMargins.Bottom, R.Top);
  R1.Left := Min(R.Left + AMargins.Left, R.Right);

  TdxSkinElementPartBounds(AParts)[sipCenter] := R1;
  TdxSkinElementPartBounds(AParts)[sipTopLeft] := Rect(R.TopLeft, R1.TopLeft);
  TdxSkinElementPartBounds(AParts)[sipTop] := Rect(R1.Left, R.Top, R1.Right, R1.Top);
  TdxSkinElementPartBounds(AParts)[sipTopRight] := Rect(R1.Right, R.Top, R.Right, R1.Top);
  TdxSkinElementPartBounds(AParts)[sipLeft] := Rect(R.Left, R1.Top, R1.Left, R1.Bottom);
  TdxSkinElementPartBounds(AParts)[sipRight] := Rect(R1.Right, R1.Top, R.Right, R1.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottomLeft] := Rect(R.Left, R1.Bottom, R1.Left, R.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottom] := Rect(R1.Left, R1.Bottom, R1.Right, R.Bottom);
  TdxSkinElementPartBounds(AParts)[sipBottomRight] := Rect(R1.Right, R1.Bottom, R.Right, R.Bottom);
end;

procedure dxSkinsCheckMargins(var AMargins: TRect; const R: TRect);

  procedure CheckSide(var S1, S2: Integer; ARectSize: Integer);
  var
    ASize, ADelta: Integer;
  begin
    S1 := Max(S1, 0);
    S2 := Max(S2, 0);
    ASize := S1 + S2;
    ADelta := ASize - ARectSize;
    if ADelta > 0 then
    begin
      Dec(S1, MulDiv(S1, ADelta, ASize));
      Dec(S2, MulDiv(S2, ADelta, ASize));
    end;
  end;

begin
  CheckSide(AMargins.Left, AMargins.Right, cxRectWidth(R));
  CheckSide(AMargins.Top, AMargins.Bottom, cxRectHeight(R));
end;

function dxCompareByName(AItem1, AItem2: TdxSkinCustomObject): Integer;
begin
  Result := AnsiCompareStr(AItem1.Name, AItem2.Name);
end;

procedure dxSkinChangeNotify(ASender: TObject; ANotifyEvent: TdxSkinChangeNotify; AChanges: TdxSkinChanges);
begin
  if Assigned(ANotifyEvent) and (AChanges <> []) then
    ANotifyEvent(ASender, AChanges);
end;

function dxSkinElementCheckState(AElement: TdxSkinElement; AState: TdxSkinElementState): TdxSkinElementState;
begin
  Result := AState;
  if not (AState in AElement.Image.States) then
  begin
    case AState of
      esHotCheck, esChecked, esCheckPressed, esDroppedDown:
        Result := esPressed;
      esActiveDisabled, esActive:
        Result := esHot;
    end;
  end;
end;

{ TdxSkinCustomObjectList }

constructor TdxSkinCustomObjectList.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
end;

constructor TdxSkinCustomObjectList.CreateEx(
  AOwner: TPersistent; AChangeHandler: TdxSkinChangeNotify);
begin
  Create(AOwner);
  OnChange := AChangeHandler;
end;

procedure TdxSkinCustomObjectList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxSkinCustomObjectList.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    Changed(FChanges);
end;

procedure TdxSkinCustomObjectList.Changed(AChanges: TdxSkinChanges);
begin
  FSorted := False;
  FChanges := FChanges + AChanges;
  if FUpdateCount = 0 then
  begin
    dxSkinChangeNotify(Self, OnChange, FChanges);
    FChanges := [];
  end;
end;

procedure TdxSkinCustomObjectList.Exchange(Index1, Index2: Integer);
begin
  inherited Exchange(Index1, Index2);
  Changed([scStruct]);
end;

function TdxSkinCustomObjectList.FindItemByName(const AName: string): TdxSkinCustomObject;
var
  L, H, I, C: Integer;
begin
  Sort;
  Result := nil;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) div 2;
    C := AnsiCompareStr(TdxSkinCustomObject(List[I]).Name, AName);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := TdxSkinCustomObject(List[I]);
        Break;
      end
    end;
  end;
end;

procedure TdxSkinCustomObjectList.SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
begin
  Changed(AChanges);
end;

procedure TdxSkinCustomObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited Notify(Ptr, Action);
  Changed([scStruct]);
end;

procedure TdxSkinCustomObjectList.Sort;
begin
  if not FSorted then
  begin
    inherited Sort(TListSortCompare(@dxCompareByName));
    FSorted := True;
  end;
end;

{ TdxSkinControlGroups }

function TdxSkinControlGroups.Add(const AName: string): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup.Create(FOwner, AName);
  Result.OnChange := SubItemChanged;
  inherited Add(Result);
end;

procedure TdxSkinControlGroups.Assign(ASource: TdxSkinControlGroups);
var
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
      Add(ASource[I].Name).Assign(ASource[I]);
  finally
    EndUpdate;
  end;
end;

function TdxSkinControlGroups.FindItemByName(const AName: string): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup(inherited FindItemByName(AName));
end;

procedure TdxSkinControlGroups.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  I: Integer;
begin
  for I := 0 to ReadInteger(AStream) - 1 do
    Add(dxSkinReadStringFromStream(AStream)).DataRead(AStream, AVersion);
end;

procedure TdxSkinControlGroups.DataWrite(AStream: TStream);
var
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count - 1 do
    Items[I].DataWrite(AStream);
end;

function TdxSkinControlGroups.GetItem(Index: Integer): TdxSkinControlGroup;
begin
  Result := TdxSkinControlGroup(inherited Items[Index]);
end;

{ TdxSkinElements }

function TdxSkinElements.Add(const AName: string; AClass: TdxSkinElementClass): TdxSkinElement;
begin
  Result := AClass.Create(FOwner, AName);
  Result.OnChange := SubItemChanged;
  inherited Add(Result);
end;

function TdxSkinElements.GetItem(Index: Integer): TdxSkinElement;
begin
  Result := TdxSkinElement(inherited Items[Index]);
end;

procedure TdxSkinElements.Assign(ASource: TdxSkinElements);
var
  AElement: TdxSkinElement;
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
    begin
      AElement := ASource[I];
      Add(AElement.Name, TdxSkinElementClass(AElement.ClassType)).Assign(AElement);
    end;
  finally
    EndUpdate;
  end;
end;

function TdxSkinElements.FindItemByName(const AName: string): TdxSkinElement;
begin
  Result := TdxSkinElement(inherited FindItemByName(AName));
end;

procedure TdxSkinElements.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  I: Integer;
begin
  for I := 0 to ReadInteger(AStream) - 1 do
    Add(dxSkinReadStringFromStream(AStream), TdxSkinElement).DataRead(AStream, AVersion);
end;

procedure TdxSkinElements.DataWrite(AStream: TStream);
var
  AElement: TdxSkinElement;
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count - 1 do
  begin
    AElement := Items[I];
    dxSkinWriteStringToStream(AStream, AElement.Name);
    AElement.DataWrite(AStream);
  end;
end;

{ TdxSkinProperties }

function TdxSkinProperties.Add(const AName: string; AClass: TdxSkinPropertyClass): TdxSkinProperty;
begin
  Result := AClass.Create(FOwner, AName);
  Result.OnChange := SubItemChanged;
  inherited Add(Result);
end;

procedure TdxSkinProperties.Assign(ASource: TdxSkinProperties);
var
  AProperty: TdxSkinProperty;
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to ASource.Count - 1 do
    begin
      AProperty := ASource.Items[I];
      Add(AProperty.Name, TdxSkinPropertyClass(AProperty.ClassType)).Assign(AProperty);
    end;
  finally
    EndUpdate;
  end;
end;

function TdxSkinProperties.Compare(AProperties: TdxSkinProperties): Boolean;
var
  I: Integer;
begin
  Result := AProperties.Count = Count;
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := AProperties[I].Compare(Items[I]);
      if not Result then Break;
    end;
end;

function TdxSkinProperties.FindItemByName(const AName: string): TdxSkinProperty;
begin
  Result := TdxSkinProperty(inherited FindItemByName(AName));
end;

procedure TdxSkinProperties.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  AClass: TClass;
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ReadInteger(AStream) - 1 do
    begin
      AClass := FindClass(dxSkinReadStringFromStream(AStream));
      Add(dxSkinReadStringFromStream(AStream), TdxSkinPropertyClass(AClass)).DataRead(AStream, AVersion);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinProperties.DataWrite(AStream: TStream);
var
  AProperty: TdxSkinProperty;
  I: Integer;
begin
  WriteIntegerToStream(AStream, Count);
  for I := 0 to Count -1 do
  begin
    AProperty := Items[I];
    dxSkinWriteStringToStream(AStream, AProperty.ClassName);
    dxSkinWriteStringToStream(AStream, AProperty.Name);
    AProperty.DataWrite(AStream);
  end;
end;

function TdxSkinProperties.GetItem(Index: Integer): TdxSkinProperty;
begin
  Result := TdxSkinProperty(inherited Items[Index]);
end;

{ TdxSkinColors }

function TdxSkinColors.Add(const AName: string; AValue: TColor): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited Add(AName, TdxSkinColor));
  Result.Value := AValue;
end;

function TdxSkinColors.FindItemByName(const AName: string): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited FindItemByName(AName));
end;

function TdxSkinColors.GetItem(Index: Integer): TdxSkinColor;
begin
  Result := TdxSkinColor(inherited Items[Index]);
end;

{ TdxSkinPersistent }

constructor TdxSkinPersistent.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FProperties := TdxSkinProperties.CreateEx(Self, SubItemChanged);
end;

destructor TdxSkinPersistent.Destroy;
begin
  FreeAndNil(FProperties);
  inherited Destroy; 
end;

function TdxSkinPersistent.AddProperty(
  const AName: string; APropertyClass: TdxSkinPropertyClass): TdxSkinProperty;
begin
  Result := FProperties.Add(AName, APropertyClass);
end;

function TdxSkinPersistent.AddPropertyBool(
  const AName: string; AValue: Boolean): TdxSkinBooleanProperty;
begin
  BeginUpdate;
  try
    Result := TdxSkinBooleanProperty(AddProperty(AName, TdxSkinBooleanProperty));
    Result.Value := AValue;
  finally
    EndUpdate;
  end;
end;

function TdxSkinPersistent.AddPropertyColor(const AName: string; AValue: TColor): TdxSkinColor;
begin
  BeginUpdate;
  try
    Result := TdxSkinColor(AddProperty(AName, TdxSkinColor));
    Result.Value := AValue;
  finally
    EndUpdate;
  end;
end;

function TdxSkinPersistent.AddPropertyInteger(
  const AName: string; AValue: Integer): TdxSkinIntegerProperty;
begin
  BeginUpdate;
  try
    Result := TdxSkinIntegerProperty(AddProperty(AName, TdxSkinIntegerProperty));
    Result.Value := AValue;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinPersistent.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkinPersistent then
      FProperties.Assign(TdxSkinPersistent(Source).FProperties)
    else
      inherited Assign(Source);
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinPersistent.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxSkinPersistent.CancelUpdate;
begin
  Dec(FUpdateCount);
  FChanges := [];
end;

procedure TdxSkinPersistent.Clear;
begin
  FProperties.Clear;
end;

procedure TdxSkinPersistent.DeleteProperty(const AProperty: TdxSkinProperty);
begin
  FProperties.FreeAndRemove(AProperty);
end;

procedure TdxSkinPersistent.DeleteProperty(const APropertyName: string);
begin
  DeleteProperty(GetPropertyByName(APropertyName));
end;

procedure TdxSkinPersistent.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    Changed(FChanges);
end;

procedure TdxSkinPersistent.ExchangeProperty(AIndex1, AIndex2: Integer);
begin
  FProperties.Exchange(AIndex1, AIndex2);
end;

procedure TdxSkinPersistent.Sort;
begin
  FProperties.Sort;
end;

procedure TdxSkinPersistent.Changed(AChanges: TdxSkinChanges);
begin
  Modified := True;
  FChanges := FChanges + AChanges;
  if UpdateCount = 0 then
  begin
    inherited Changed(FChanges);
    FChanges := [];
  end;
end;

procedure TdxSkinPersistent.SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
begin
  Changed(AChanges);
end;

function TdxSkinPersistent.GetPropertyByName(const AName: string): TdxSkinProperty;
begin
  Result := FProperties.FindItemByName(AName);
end;

function TdxSkinPersistent.GetPropertyByName(
  const AName: string; out AProperty: TdxSkinProperty): Boolean;
begin
  AProperty := GetPropertyByName(AName);
  Result := AProperty <> nil;
end;

function TdxSkinPersistent.GetPropertyCount: Integer;
begin
  Result := FProperties.Count;
end;

function TdxSkinPersistent.GetProperty(Index: Integer): TdxSkinProperty;
begin
  Result := FProperties[Index];
end;

{ TdxSkin }

constructor TdxSkin.Create(const AName: string; ALoadOnCreate: Boolean; hInst: THandle);
begin
  inherited Create(nil, AName);
  FListeners := TInterfaceList.Create;
  FDetails := TdxSkinDetails.Create;
  FDetails.Name := AName;
  FDetails.OnChange := DetailsChanged;
  FColors := TdxSkinColors.CreateEx(Self, SubItemChanged);
  FGroups := TdxSkinControlGroups.CreateEx(Self, SubItemChanged);
  if ALoadOnCreate then
    LoadFromResource(hInst);
end;

destructor TdxSkin.Destroy;
begin
  FreeAndNil(FDetails);
  FreeAndNil(FListeners);
  FreeAndNil(FColors);
  FreeAndNil(FGroups);
  inherited Destroy;
end;

procedure TdxSkin.BeforeDestruction;
begin
  inherited BeforeDestruction;
  FDestroying := True;
end;

function TdxSkin.AddColor(const AName: string; const AColor: TColor): TdxSkinColor;
begin
  Result := FColors.Add(AName, AColor);
end;

function TdxSkin.AddGroup(const AName: string): TdxSkinControlGroup;
begin
  Result := FGroups.Add(AName);
end;

procedure TdxSkin.AddListener(AListener: IUnknown);
begin
  Listeners.Add(AListener);
end;

procedure TdxSkin.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkin then
    begin
      Details.Assign(TdxSkin(Source).Details);
      FColors.Assign(TdxSkin(Source).FColors);
      FGroups.Assign(TdxSkin(Source).FGroups);
    end;
    inherited Assign(Source);
  finally
    EndUpdate;
  end;
end;

procedure TdxSkin.Clear;
begin
  inherited Clear;
  Details.Clear;
  FGroups.Clear;
  FColors.Clear;
end;

procedure TdxSkin.ClearModified;
var
  I: Integer;
begin
  FModified := False;
  for I := 0 to GroupCount - 1 do
    Groups[I].ClearModified;
end;

function TdxSkin.Clone(const AName: string): TdxSkin;
var
  AClass: TdxSkinClass;
begin
  AClass := TdxSkinClass(ClassType);
  Result := AClass.Create(Name, False, 0);
  Result.Assign(Self);
end;

function TdxSkin.GetColorByName(const AName: string): TdxSkinColor;
begin
  Result := FColors.FindItemByName(AName);
end;

procedure TdxSkin.DetailsChanged(Sender: TObject);
begin
  Changed([scDetails]);
end;

procedure TdxSkin.DoChanged(AChanges: TdxSkinChanges);
begin
  NotifyListeners(AChanges);
  inherited DoChanged(AChanges);
end;

procedure TdxSkin.DeleteGroup(const AGroup: TdxSkinControlGroup);
begin
  FGroups.Remove(AGroup);
end;

procedure TdxSkin.DeleteProperty(const AProperty: TdxSkinProperty);
begin
  inherited DeleteProperty(AProperty);
  FColors.FreeAndRemove(AProperty);
end;

procedure TdxSkin.ExchangeColors(AIndex1, AIndex2: Integer);
begin
  FColors.Exchange(AIndex1, AIndex2);
end;

procedure TdxSkin.ExchangeGroups(AIndex1, AIndex2: Integer);
begin
  FGroups.Exchange(AIndex1, AIndex2);
end;

function TdxSkin.GetGroupByName(const AName: string): TdxSkinControlGroup;
begin
  Result := FGroups.FindItemByName(AName);
end;

function TdxSkin.GetGroupByName(const AName: string; out AGroup: TdxSkinControlGroup): Boolean;
begin
  AGroup := GetGroupByName(AName);
  Result := AGroup <> nil;
end;

procedure TdxSkin.LoadFromBinaryFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromBinaryStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.LoadFromBinaryStream(AStream: TStream);
var
  AReader: TdxSkinBinaryReader;
begin
  AReader := TdxSkinBinaryReader.Create(AStream);
  try
    AReader.LoadSkin(Self, 0);
  finally
    AReader.Free;
  end;
end;

procedure TdxSkin.LoadFromStream(AStream: TStream);
var
  AVersion: TdxSkinVersion;
begin
  if not CheckGdiPlus then Exit;
  if not dxSkinCheckSignature(AStream, AVersion) then
    raise EdxSkin.Create(sdxSkinInvalidStreamFormat);
  BeginUpdate;
  try
    Clear;
    Details.DataRead(AStream, AVersion);
    FColors.DataRead(AStream, AVersion);
    FProperties.DataRead(AStream, AVersion);
    FGroups.DataRead(AStream, AVersion);
    if AVersion < 1.04 then
      ReadDetailsFromOldSkinFormat;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkin.LoadFromFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free
  end;
end;

procedure TdxSkin.RemoveListener(AListener: IUnknown);
begin
  Listeners.Remove(AListener);
end;

procedure TdxSkin.SaveToFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free
  end;
end;

procedure TdxSkin.SaveToStream(AStream: TStream);
begin
  dxSkinWriteSignature(AStream);
  Details.DataWrite(AStream);
  FColors.DataWrite(AStream);
  FProperties.DataWrite(AStream);
  FGroups.DataWrite(AStream);
end;

procedure TdxSkin.SaveToBinaryFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToBinaryStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.SaveToBinaryStream(AStream: TStream);
begin
  with TdxSkinBinaryWriter.Create(AStream) do
  try
    AddSkin(Self);
  finally
    Free;
  end;
end;

procedure TdxSkin.NotifyListener(AChanges: TdxSkinChanges; ACustomListener: IUnknown);
var
  AListener: IdxSkinChangeListener;
  AListener2: IdxSkinChangeListener2;
begin
  if Supports(ACustomListener, IdxSkinChangeListener2, AListener2) then
  try
    AListener2.SkinChanged(Self, AChanges);
  finally
    AListener2 := nil;
  end
  else
    if Supports(ACustomListener, IdxSkinChangeListener, AListener) then
    try
      AListener.SkinChanged(Self);
    finally
      AListener := nil;
    end;
end;

procedure TdxSkin.NotifyListeners(AChanges: TdxSkinChanges);
var
  I: Integer;
begin
  if not FDestroying then
  begin
    Inc(FUpdateCount);
    try
      for I := 0 to Listeners.Count - 1 do
        NotifyListener(AChanges, Listeners[I]);
    finally
      Dec(FUpdateCount);
    end;
  end;
end;

procedure TdxSkin.LoadFromResource(hInst: THandle);
var
  AStream: TStream;
begin
  AStream := TResourceStream.Create(hInst, Name, PChar(sdxResourceType));
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkin.ReadDetailsFromOldSkinFormat;

  function GetStringPropertyValue(const APropertyName, ADefaultValue: string): string;
  var
    AProperty: TdxSkinProperty;
  begin
    if GetPropertyByName(APropertyName, AProperty) then
    begin
      Result := (AProperty as TdxSkinStringProperty).Value;
      DeleteProperty(AProperty);
    end
    else
      Result := ADefaultValue;
  end;

  procedure LoadIcons(AGroup: TdxSkinControlGroup);
  const
    SkinIconNames: array[TdxSkinIconSize] of string = (sdxSkinIcon, sdxSkinIconLarge);
  var
    AElement: TdxSkinElement;
    ASize: TdxSkinIconSize;
  begin
    for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
    begin
      if AGroup <> nil then
        AElement := AGroup.GetElementByName(SkinIconNames[ASize])
      else
        AElement := nil;

      if (AElement = nil) or AElement.Image.Texture.Empty then
        Details.ResetIcon(ASize)
      else
        Details.Icons[ASize].Assign(AElement.Image.Texture);

      if AElement <> nil then
        AGroup.RemoveElement(AElement);
    end;
  end;

begin
  BeginUpdate;
  try
    Details.DisplayName := GetStringPropertyValue(sdxDisplayName, Name);
    Details.GroupName := GetStringPropertyValue(sdxSkinGroupName, sdxSkinDefaultGroupName);
    LoadIcons(GetGroupByName(sdxSkinGroupCommon));
  finally
    EndUpdate;
  end;
end;

procedure TdxSkin.Sort;
begin
  inherited Sort;
  FGroups.Sort;
  FColors.Sort;
end;

function TdxSkin.GetName: string;
begin
  Result := Details.Name;
end;

function TdxSkin.GetColor(Index: Integer): TdxSkinColor;
begin
  Result := FColors[Index];
end;

function TdxSkin.GetColorCount: Integer;
begin
  Result := FColors.Count;
end;

function TdxSkin.GetDisplayName: string;
begin
  Result := Details.DisplayName;
  if Result = '' then
    Result := Name;
end;

function TdxSkin.GetGroup(Index: Integer): TdxSkinControlGroup;
begin
  Result := FGroups[Index] as TdxSkinControlGroup;
end;

function TdxSkin.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxSkin.GetHasMissingElements: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to GroupCount - 1 do
  begin
    Result := Groups[I].HasMissingElements;
    if Result then Break;
  end;
end;

procedure TdxSkin.SetName(const Value: string);
begin
  Details.Name := Value;
end;

{ TdxSkinImage }

constructor TdxSkinImage.Create(AOwner: TdxSkinElement);
begin
  inherited Create;
  FOwner := AOwner;
  FStates := [esNormal];
  FTexture := TdxPNGImage.Create();
  FTexture.OnChange := SubItemChanged;
  FMargins := TcxMargin.Create(Self);
  FMargins.OnChange := SubItemChanged;
  FGradientBeginColor := clNone;
  FGradientEndColor := clNone;
  FGradient := gmHorizontal;
  FTransparentColor := clNone;
  FIsDirty := True;
  FImageCount := 1;
end;

destructor TdxSkinImage.Destroy;
begin
  FreeAndNil(FMargins);
  FreeAndNil(FTexture);
  inherited Destroy;
end;

procedure TdxSkinImage.Assign(Source: TPersistent);
begin
  if Source is TdxSkinImage then
  begin
    if TdxSkinImage(Source).Empty then
      Clear
    else
    begin
      Texture.Assign(TdxSkinImage(Source).Texture);
      FSourceName := TdxSkinImage(Source).SourceName;
    end;
    GradientBeginColor := TdxSkinImage(Source).GradientBeginColor;
    GradientEndColor := TdxSkinImage(Source).GradientEndColor;
    Gradient := TdxSkinImage(Source).Gradient;
    ImageCount := TdxSkinImage(Source).ImageCount;
    ImageLayout := TdxSkinImage(Source).ImageLayout;
    Margins.Assign(TdxSkinImage(Source).Margins);
    Stretch := TdxSkinImage(Source).Stretch;
    States := TdxSkinImage(Source).States;
  end;
end;

procedure TdxSkinImage.Clear;
begin
  if (FSourceName <> '') or not Texture.Empty then
  begin
    FSourceName := '';
    Texture.Clear;
    Changed;
  end;
end;

procedure TdxSkinImage.GetBitmap(AImageIndex: Integer;
  AState: TdxSkinElementState; ABitmap: TBitmap; ABackgroundColor: TColor = clNone);
begin
  ABitmap.FreeImage;
  ABitmap.Width := Size.cx;
  ABitmap.Height := Size.cy;
  if ABackgroundColor <> clNone then
  begin
    if ABackgroundColor <> clDefault then
      ABitmap.Canvas.Brush.Color := ABackgroundColor;
    ABitmap.Canvas.FillRect(cxRect(Size));
  end;
  Draw(ABitmap.Canvas.Handle, cxRect(Size), AImageIndex, AState);
end;

procedure TdxSkinImage.LoadFromFile(const AFileName: string);
var
  AStream: TStream;
begin
  FSourceName := AFileName;
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkinImage.LoadFromResource(AInstance: THandle; const AName: string; AType: PChar);
var
  AStream: TStream;
begin
  AStream := TResourceStream.Create(AInstance, AName, AType);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSkinImage.LoadFromStream(AStream: TStream);
begin
  Texture.LoadFromStream(AStream);
end;

procedure TdxSkinImage.SaveToFile(const AFileName: string);
var
  AStream: TStream;
begin
  if not Empty then
  begin
    AStream := TFileStream.Create(ChangeFileExt(AFileName, dxSkinImageExt), fmCreate);
    try
      Texture.SaveToStream(AStream);
    finally
      AStream.Free;
    end;
  end;
end;

procedure TdxSkinImage.SaveToStream(AStream: TStream);
begin
  if not Empty then
    Texture.SaveToStream(AStream);
end;

procedure TdxSkinImage.SetStateMapping(AStateOrder: array of TdxSkinElementState);
var
  ABitmap: TBitmap;
  AImageIndex, AStateIndex: Integer;
  ANewStates: TdxSkinElementStates;
  ATextureSize, AOffset: TSize;
  R: TRect;
begin
  if Texture.Empty then Exit;

  AOffset := Size;
  if ImageLayout = ilHorizontal then
    AOffset.cy := 0
  else
    AOffset.cx := 0;

  ATextureSize := cxSize(Texture.Width, Texture.Height);
  if ImageLayout = ilHorizontal then
    ATextureSize.cx := Size.cx * Length(AStateOrder)
  else
    ATextureSize.cy := Size.cy * Length(AStateOrder);

  ABitmap := TcxBitmap32.CreateSize(ATextureSize.cx, ATextureSize.cy, True);
  try
    ANewStates := [];
    R := cxRect(Size);
    for AImageIndex := 0 to ImageCount - 1 do
      for AStateIndex := Low(AStateOrder) to High(AStateOrder) do
      begin
        if AStateOrder[AStateIndex] in States then
        begin
          Texture.StretchDraw(ABitmap.Canvas.Handle, R,
            StateBounds[AImageIndex, AStateOrder[AStateIndex]]);
        end;
        Include(ANewStates, AStateOrder[AStateIndex]);
        OffsetRect(R, AOffset.cx, AOffset.cy);
      end;

    Texture.SetBitmap(ABitmap);
    States := ANewStates;
  finally
    ABitmap.Free;
  end;
end;

procedure TdxSkinImage.Changed;
begin
  IsDirty := True;
  dxCallNotify(OnChange, Self);
end;

procedure TdxSkinImage.CheckInfo;
begin
  if IsDirty then
  begin
    IsDirty := False;
    InitializeInfo;
  end;
end;

procedure TdxSkinImage.CheckState(var AState: TdxSkinElementState; var AImageIndex: Integer);

  function GetFirstState: TdxSkinElementState;
  begin
    for Result := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if Result in FStates then
        Break;
    end;
  end;

begin
  AImageIndex := Min(AImageIndex, ImageCount - 1);
  if not (AState in FStates) then
  begin
    if FStates <> [] then
      AState := GetFirstState;
  end;
end;

function TdxSkinImage.Compare(AImage: TdxSkinImage): Boolean; 
begin
  Result := (AImage.ImageLayout = ImageLayout) and (AImage.Empty = Empty) and
    (AImage.States = States) and (AImage.Gradient = Gradient) and
    (AImage.GradientBeginColor = GradientBeginColor) and
    (AImage.GradientEndColor = GradientEndColor) and (AImage.Stretch = Stretch) and
    (AImage.Size.cx = Size.cx) and (AImage.Size.cy = Size.cy) and
    AImage.Margins.IsEqual(Margins) and Texture.Compare(AImage.Texture);
end;

procedure TdxSkinImage.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  ACanvas: TdxSkinCanvas;
begin
  ACanvas := TdxSkinCanvas.Create;
  try
    ACanvas.BeginPaint(DC, ARect);
    DrawEx(ACanvas, ARect, AImageIndex, AState);
    ACanvas.EndPaint;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinImage.DrawEx(ACanvas: TdxSkinCanvas; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
begin
  if not Empty then
  begin
    CheckInfo;
    CheckState(AState, AImageIndex);
    ACanvas.DrawImage(Self, ARect, StateBounds[AImageIndex, AState])
  end
  else
    ACanvas.FillRectByGradient(cxRectContent(ARect, Margins.Margin),
      GradientBeginColor, GradientEndColor, Gradient);
end;

procedure TdxSkinImage.InitializeInfo;

  function CalculateStateCount: Integer;
  var
    AState: TdxSkinElementState;
  begin
    Result := 0;
    for AState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if AState in States then
        Inc(Result);
    end;
  end;

  function CalculateFrameSize: TSize;
  begin
    Result := cxSize(Texture.Width, Texture.Height);
    if StateCount > 0 then
    begin
      if ImageLayout = ilHorizontal then
        Result.cx := Result.cx div ImageCount div StateCount
      else
        Result.cy := Result.cy div ImageCount div StateCount;
    end;
  end;

  procedure CalculateStateBounds;
  var
    AOffset: TPoint;
    ARect: TRect;
    AState: TdxSkinElementState;
  begin
    ARect := cxRect(FSize);
    if ImageLayout = ilHorizontal then
      AOffset := Point(FSize.cx, 0)
    else
      AOffset := Point(0, FSize.cy);

    for AState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if AState in States then
      begin
        FStateBounds[AState] := ARect;
        OffsetRect(ARect, AOffset.X, AOffset.Y);
      end
      else
        FStateBounds[AState] := cxNullRect;
    end;
  end;

var
  APart: TdxSkinImagePart;
begin
  FStateCount := CalculateStateCount;
  FSize := CalculateFrameSize;
  CalculateStateBounds;
  dxSkinsCalculatePartsBounds(cxRect(FSize), Margins.Margin, FPartsBounds);
  for APart := Low(TdxSkinImagePart) to High(TdxSkinImagePart) do
    FPartsVisibility[APart] := not IsRectEmpty(FPartsBounds[APart]);
end;

function TdxSkinImage.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TdxSkinImage.GetEmpty: Boolean;
begin
  Result := (FSourceName = '') and Texture.Empty;
end;

function TdxSkinImage.GetIsGradientParamsAssigned: Boolean;
begin
  Result := cxColorIsValid(GradientBeginColor);
end;

function TdxSkinImage.GetName: string;
begin
  if Empty or (Owner = nil) then
    Result := ''
  else
    Result := Owner.ExpandName(Self);
end;

function TdxSkinImage.GetPartBounds(APart: TdxSkinImagePart): TRect;
begin
  Result := FPartsBounds[APart];
end;

function TdxSkinImage.GetPartVisible(APart: TdxSkinImagePart): Boolean;
begin
  Result := FPartsVisibility[APart];
end;

function TdxSkinImage.GetSize: TSize;
begin
  CheckInfo;
  Result := FSize;
end;

function TdxSkinImage.GetSourceName: string;
begin
  Result := FSourceName;
  if (Result = '') and not Empty and (Owner <> nil) then
    Result := Owner.Path + Name;
end;

function TdxSkinImage.GetStateBounds(
  AImageIndex: Integer; AState: TdxSkinElementState): TRect;
begin
  CheckInfo;
  Result := FStateBounds[AState];
  if AImageIndex > 0 then
  begin
    if ImageLayout = ilHorizontal then
      OffsetRect(Result, StateCount * AImageIndex * Size.cx, 0)
    else
      OffsetRect(Result, 0, StateCount * AImageIndex * Size.cy)
  end;
end;

function TdxSkinImage.GetStateCount: Integer;
begin
  CheckInfo;
  Result := FStateCount;
end;

procedure TdxSkinImage.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
begin
  FImageCount := Owner.FReadedImageCount;
  FMargins.LoadFromStream(AStream);
  AStream.ReadBuffer(FImageLayout, SizeOf(TdxSkinImageLayout));
  if AVersion >= 1.10 then
    AStream.ReadBuffer(FImageCount, SizeOf(FImageCount));
  AStream.ReadBuffer(FStates, SizeOf(TdxSkinElementStates));
  AStream.ReadBuffer(FStretch, SizeOf(FStretch));
  if AVersion >= 1.02 then
  begin
    AStream.ReadBuffer(FGradientBeginColor, SizeOf(FGradientBeginColor));
    AStream.ReadBuffer(FGradientEndColor, SizeOf(FGradientEndColor));
    AStream.ReadBuffer(FGradient, SizeOf(FGradient));
  end;
  ReadPngImage(AStream, Texture);
  IsDirty := True;
end;

procedure TdxSkinImage.DataWrite(AStream: TStream);
begin
  FMargins.SaveToStream(AStream);
  AStream.WriteBuffer(FImageLayout, SizeOf(TdxSkinImageLayout));
  AStream.WriteBuffer(FImageCount, SizeOf(FImageCount));
  AStream.WriteBuffer(FStates, SizeOf(TdxSkinElementStates));
  AStream.WriteBuffer(FStretch, SizeOf(FStretch));
  AStream.WriteBuffer(FGradientBeginColor, SizeOf(FGradientBeginColor));
  AStream.WriteBuffer(FGradientEndColor, SizeOf(FGradientEndColor));
  AStream.WriteBuffer(FGradient, SizeOf(FGradient));
  WritePngImage(AStream, Texture);
end;

procedure TdxSkinImage.SetGradientBeginColor(AValue: TColor);
begin
  if AValue <> FGradientBeginColor then
  begin
    FGradientBeginColor := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetGradientEndColor(AValue: TColor);
begin
  if AValue <> GradientEndColor then
  begin
    FGradientEndColor := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetGradientMode(AValue: TdxSkinGradientMode);
begin
  if AValue <> FGradient then
  begin
    FGradient := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetImageCount(AValue: Integer);
begin
  AValue := Max(AValue, 1);
  if ImageCount <> AValue then
  begin
    FImageCount := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetImageLayout(AValue: TdxSkinImageLayout);
begin
  if ImageLayout <> AValue then
  begin
    FImageLayout := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetMargins(AValue: TcxMargin);
begin
  FMargins.Assign(AValue);
end;

procedure TdxSkinImage.SetStates(AValue: TdxSkinElementStates);
begin
  if FStates <> AValue then
  begin
    FStates := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetStretch(AValue: TdxSkinStretchMode);
begin
  if Stretch <> AValue then
  begin
    FStretch := AValue;
    Changed;
  end; 
end;

procedure TdxSkinImage.SetTransparentColor(AValue: TColor);
begin
  if AValue <> TransparentColor then
  begin
    FTransparentColor := AValue;
    Changed;
  end;
end;

procedure TdxSkinImage.SetName(const AValue: string);
begin
  LoadFromFile(AValue);
end;

procedure TdxSkinImage.SubItemChanged(ASender: TObject);
begin
  Changed;
end;

{ TdxSkinCustomObject }

constructor TdxSkinCustomObject.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create;
  FName := AName;
  FOwner := AOwner;
  FState := [sosUnused];
end;

procedure TdxSkinCustomObject.Changed(AChanges: TdxSkinChanges);
begin
  DoChanged(AChanges);
end;

procedure TdxSkinCustomObject.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
end;

procedure TdxSkinCustomObject.DataWrite(Stream: TStream);
begin
end;

procedure TdxSkinCustomObject.DoChanged(AChanges: TdxSkinChanges);
begin
  dxSkinChangeNotify(Self, OnChange, AChanges);
end;

function TdxSkinCustomObject.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TdxSkinCustomObject.SetName(const AValue: string);
begin
  if AValue <> FName then
  begin
    FName := AValue;
    Changed([scStruct]);
  end;
end;

{ TdxSkinProperty }

class procedure TdxSkinProperty.Register;
begin
  RegisteredPropertyTypes.Add(Self);
  RegisterClass(Self);
end;

class procedure TdxSkinProperty.Unregister;
begin
  UnRegisterClass(Self);
  RegisteredPropertyTypes.Remove(Self); 
end;

class function TdxSkinProperty.Description: string;
begin
  Result := StringReplace(ClassName, 'TdxSkin', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Property', '', [rfReplaceAll, rfIgnoreCase]);
end;

function TdxSkinProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := SameText(Name, AProperty.Name);
end;

{ TdxSkinIntegerProperty }

procedure TdxSkinIntegerProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinIntegerProperty then
    Value := TdxSkinIntegerProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinIntegerProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinIntegerProperty) and
    (TdxSkinIntegerProperty(AProperty).Value = Value);
end;

procedure TdxSkinIntegerProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinIntegerProperty.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinIntegerProperty.SetValue(AValue: Integer);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinBooleanProperty }

procedure TdxSkinBooleanProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinBooleanProperty then
    Value := TdxSkinBooleanProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinBooleanProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinBooleanProperty) and
    (TdxSkinBooleanProperty(AProperty).Value = Value)
end;

procedure TdxSkinBooleanProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinBooleanProperty.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinBooleanProperty.SetValue(AValue: Boolean);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinColor }

constructor TdxSkinColor.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FValue := clDefault;  
end;

procedure TdxSkinColor.Assign(Source: TPersistent);
begin
  if Source is TdxSkinColor then
    Value := TdxSkinColor(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinColor.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinColor) and
    (TdxSkinColor(AProperty).Value = Value);
end;

procedure TdxSkinColor.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinColor.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinColor.SetValue(AValue: TColor);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinRectProperty }

constructor TdxSkinRectProperty.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FValue := TcxRect.Create(Self);               
  FValue.OnChange := InternalHandler;
end;

destructor TdxSkinRectProperty.Destroy;
begin
  FValue.Free;
  inherited Destroy;
end;

procedure TdxSkinRectProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinRectProperty then
    Value := TdxSkinRectProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinRectProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinRectProperty) and
    TdxSkinRectProperty(AProperty).Value.IsEqual(Value); 
end;

procedure TdxSkinRectProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
var
  ARect: TRect;
begin
  Stream.ReadBuffer(ARect, SizeOf(TRect));
  FValue.Rect := ARect;   
end;

procedure TdxSkinRectProperty.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FValue.Rect, SizeOf(TRect));
end;

function TdxSkinRectProperty.GetValueByIndex(Index: Integer): Integer;
begin
  Result := FValue.GetValue(Index);
end;

procedure TdxSkinRectProperty.SetValue(Value: TcxRect);
begin
  FValue.Assign(Value);
end;

procedure TdxSkinRectProperty.SetValueByIndex(Index, Value: Integer);
begin
  FValue.SetValue(Index, Value);
end;

procedure TdxSkinRectProperty.InternalHandler(Sender: TObject);
begin
  Changed([scContent]);
end;

{ TdxSkinSizeProperty }

procedure TdxSkinSizeProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinSizeProperty then
    Value := TdxSkinSizeProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinSizeProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinSizeProperty) and
    cxSizeIsEqual(Value, TdxSkinSizeProperty(AProperty).Value);
end;

function TdxSkinSizeProperty.GetValueByIndex(Index: Integer): Integer;
begin
  if Index = 0 then
    Result := FValue.cx
  else
    Result := FValue.cy
end;

procedure TdxSkinSizeProperty.SetValueByIndex(Index, Value: Integer);
var
  AValue: TSize;
begin
  AValue := FValue;
  if Index = 0 then
    AValue.cx := Value
  else
    AValue.cy := Value;
  SetValue(AValue);
end;

procedure TdxSkinSizeProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Stream.ReadBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinSizeProperty.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FValue, SizeOf(FValue));
end;

procedure TdxSkinSizeProperty.SetValue(const AValue: TSize);
begin
  if not cxSizeIsEqual(AValue, Value) then
  begin
    FValue := Value;
    Changed([scContent]);
  end;
end;

{ TdxSkinBorder }
 
constructor TdxSkinBorder.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FColor := clNone;
  FThin := 1;
end;

procedure TdxSkinBorder.Assign(Source: TPersistent);
var
  ASource: TdxSkinBorder;
begin
  if not (Source is TdxSkinBorder) then Exit;
  ASource := TdxSkinBorder(Source);
  Color := ASource.Color;
  FKind := ASource.Kind;
  Thin := ASource.Thin;
end;

function TdxSkinBorder.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := (AProperty is TdxSkinBorder);
  if Result then
    with TdxSkinBorder(AProperty) do
    begin
      Result := (Color = Self.Color) and (Thin = Self.Thin) and (Kind = Self.Kind);
    end;
end;

procedure TdxSkinBorder.Draw(DC: HDC; const ABounds: TRect);
var
  ACanvas: TdxSkinCanvas;
begin
  if Color = clNone then Exit;
  ACanvas := TdxSkinCanvas.Create;
  try
    ACanvas.BeginPaint(DC, ABounds);
    DrawEx(ACanvas, ABounds);
    ACanvas.EndPaint;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinBorder.DrawEx(ACanvas: TdxSkinCanvas; const ABounds: TRect);
begin
  if Color = clNone then Exit;
  with ABounds do
    case Kind of
      bLeft:
        ACanvas.FillRectByColor(Rect(Left, Top, Left + Thin, Bottom), Color);
      bTop:
        ACanvas.FillRectByColor(Rect(Left, Top, Right, Top + Thin), Color);
      bRight:
        ACanvas.FillRectByColor(Rect(Right - Thin, Top, Right, Bottom), Color);
      bBottom:
        ACanvas.FillRectByColor(Rect(Left, Bottom - Thin, Right, Bottom), Color);
    end;
end;

procedure TdxSkinBorder.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
var
  AColor: TColor;
begin
  Stream.ReadBuffer(AColor, SizeOf(FColor));
  Stream.ReadBuffer(FThin, SizeOf(FThin));
  Color := AColor;
end;

procedure TdxSkinBorder.DataWrite(Stream: TStream);
begin
  Stream.WriteBuffer(FColor, SizeOf(FColor));
  Stream.WriteBuffer(FThin, SizeOf(FThin));
end;

procedure TdxSkinBorder.ResetToDefaults;
begin
  Color := clNone;
  Thin := 1;
end;

function TdxSkinBorder.GetContentMargin: Integer;
begin
  if Color <> clNone then
    Result := Thin
  else
    Result := 0;
end;

procedure TdxSkinBorder.SetColor(AValue: TColor);
begin
  if AValue <> FColor then
  begin
    FColor := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinBorder.SetThin(AValue: Integer);
begin
  if AValue <> FThin then
  begin
    FThin := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinBorders }

constructor TdxSkinBorders.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  CreateBorders;
end;

destructor TdxSkinBorders.Destroy;
begin
  DeleteBorders;
  inherited Destroy;
end;

procedure TdxSkinBorders.Assign(ASource: TPersistent);
var
  ABorder: TcxBorder;
begin
  if ASource is TdxSkinBorders then
  begin
    for ABorder := Low(TcxBorder) to High(TcxBorder) do
      FBorders[ABorder].Assign(TdxSkinBorders(ASource).FBorders[ABorder])
  end
  else
    inherited Assign(ASource);
end;

function TdxSkinBorders.Compare(AProperty: TdxSkinProperty): Boolean;
var
  ASide: TcxBorder;
begin
  Result := (AProperty is TdxSkinBorders);
  if Result then
  begin
    for ASide := Low(TcxBorder) to High(TcxBorder) do
      Result := Result and Items[ASide].Compare(TdxSkinBorders(AProperty).Items[ASide]);
  end;
end;

procedure TdxSkinBorders.Draw(ACanvas: TdxSkinCanvas; const ABounds: TRect);
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    Items[ASide].DrawEx(ACanvas, ABounds);
end;

procedure TdxSkinBorders.CreateBorders;
const
  BorderNames: array[TcxBorder] of string = (sdxLeft, sdxTop, sdxRight, sdxBottom);
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
  begin
    FBorders[ASide] := TdxSkinBorder.Create(Self, BorderNames[ASide]);
    FBorders[ASide].FKind := ASide;
    FBorders[ASide].OnChange := SubItemChanged;
  end;
end;

procedure TdxSkinBorders.DeleteBorders;
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FreeAndNil(FBorders[ASide])
end;

procedure TdxSkinBorders.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
  begin
    if AVersion <= 1.09 then
    begin
      dxSkinReadStringFromStream(AStream); // Skip ClassName
      dxSkinReadStringFromStream(AStream); // Skip Name
    end;
    Items[ASide].DataRead(AStream, AVersion);
  end;
end;

procedure TdxSkinBorders.DataWrite(AStream: TStream);
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    Items[ASide].DataWrite(AStream);
end;

procedure TdxSkinBorders.ResetToDefaults;
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    Items[ASide].ResetToDefaults;
end;

procedure TdxSkinBorders.SubItemChanged(ASender: TObject; AChanges: TdxSkinChanges);
begin
  Changed(AChanges);
end;

function TdxSkinBorders.GetBorder(ABorder: TcxBorder): TdxSkinBorder;
begin
  Result := FBorders[ABorder];
end;

function TdxSkinBorders.GetBorderByIndex(Index: Integer): TdxSkinBorder;
begin
  Result := FBorders[TcxBorder(Index)];
end;

function TdxSkinBorders.GetContentMargins: TRect;
begin
  Result := Rect(Left.ContentMargin, Top.ContentMargin, Right.ContentMargin, Bottom.ContentMargin);
end;

procedure TdxSkinBorders.SetBorderByIndex(Index: Integer; AValue: TdxSkinBorder);
begin
  FBorders[TcxBorder(Index)].Assign(AValue);
end;

{ TdxSkinWideStringProperty }

procedure TdxSkinWideStringProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinWideStringProperty then
    Value := TdxSkinWideStringProperty(Source).Value
  else
    inherited Assign(Source);
end;

procedure TdxSkinWideStringProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Value := dxWideStringToString(dxSkinReadWideStringFromStream(Stream));
end;

procedure TdxSkinWideStringProperty.DataWrite(Stream: TStream);
begin
  dxSkinWriteWideStringToStream(Stream, dxStringToWideString(Value));
end;

{ TdxSkinStringProperty }

procedure TdxSkinStringProperty.Assign(Source: TPersistent);
begin
  if Source is TdxSkinStringProperty then
    Value := TdxSkinStringProperty(Source).Value
  else
    inherited Assign(Source);
end;

function TdxSkinStringProperty.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinStringProperty) and
    (AnsiCompareStr(TdxSkinStringProperty(AProperty).Value, Value) = 0);
end;

procedure TdxSkinStringProperty.DataRead(Stream: TStream; const AVersion: TdxSkinVersion);
begin
  Value := dxSkinReadStringFromStream(Stream);
end;

procedure TdxSkinStringProperty.DataWrite(Stream: TStream);
begin
  dxSkinWriteStringToStream(Stream, Value);
end;

procedure TdxSkinStringProperty.SetValue(const AValue: string);
begin
  if AValue <> FValue then
  begin
    FValue := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinAlternateImageAttributes }

constructor TdxSkinAlternateImageAttributes.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FAlpha := MaxByte;
  FGradientBeginColor := clNone;
  FGradientEndColor := clNone;
  FBorders := TdxSkinBorders.Create(Self, sdxBorders);
  FBorders.OnChange := BordersChanged;
  FBordersInner := TdxSkinBorders.Create(Self, sdxBordersInner);
  FBordersInner.OnChange := BordersChanged;;
  FContentOffsets := TcxRect.Create(Self);
  FContentOffsets.OnChange := ContentOffsetsChanged;
end;

destructor TdxSkinAlternateImageAttributes.Destroy;
begin
  FreeAndNil(FContentOffsets);
  FreeAndNil(FBordersInner);
  FreeAndNil(FBorders);
  inherited Destroy;
end;

procedure TdxSkinAlternateImageAttributes.Assign(Source: TPersistent);
begin
  if Source is TdxSkinAlternateImageAttributes then
  begin
    Alpha := TdxSkinAlternateImageAttributes(Source).Alpha;
    Borders := TdxSkinAlternateImageAttributes(Source).Borders;
    BordersInner := TdxSkinAlternateImageAttributes(Source).BordersInner;
    Gradient := TdxSkinAlternateImageAttributes(Source).Gradient;
    GradientBeginColor := TdxSkinAlternateImageAttributes(Source).GradientBeginColor;
    GradientEndColor := TdxSkinAlternateImageAttributes(Source).GradientEndColor;
    ContentOffsets.Rect := TdxSkinAlternateImageAttributes(Source).ContentOffsets.Rect;
  end
  else
    inherited Assign(Source);
end;

procedure TdxSkinAlternateImageAttributes.BordersChanged(
  ASender: TObject; AChanges: TdxSkinChanges);
begin
  Changed(AChanges);
end;

function TdxSkinAlternateImageAttributes.Compare(AProperty: TdxSkinProperty): Boolean;
begin
  Result := inherited Compare(AProperty) and (AProperty is TdxSkinAlternateImageAttributes) and
    (TdxSkinAlternateImageAttributes(AProperty).Alpha = Alpha) and
    (TdxSkinAlternateImageAttributes(AProperty).Gradient = Gradient) and
    (TdxSkinAlternateImageAttributes(AProperty).GradientBeginColor = GradientBeginColor) and
    (TdxSkinAlternateImageAttributes(AProperty).GradientEndColor = GradientEndColor) and
    (TdxSkinAlternateImageAttributes(AProperty).Borders.Compare(Borders)) and
    (TdxSkinAlternateImageAttributes(AProperty).BordersInner.Compare(BordersInner)) and
    (TdxSkinAlternateImageAttributes(AProperty).ContentOffsets.IsEqual(ContentOffsets.Rect));
end;

procedure TdxSkinAlternateImageAttributes.ContentOffsetsChanged(ASender: TObject);
begin
  Changed([scContent]);
end;

procedure TdxSkinAlternateImageAttributes.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
begin
  AStream.ReadBuffer(FAlpha, SizeOf(FAlpha));
  AStream.ReadBuffer(FGradient, SizeOf(FGradient));
  AStream.ReadBuffer(FGradientBeginColor, SizeOf(FGradientBeginColor));
  AStream.ReadBuffer(FGradientEndColor, SizeOf(FGradientEndColor));
  Borders.DataRead(AStream, AVersion);
  BordersInner.DataRead(AStream, AVersion);
  ContentOffsets.LoadFromStream(AStream);
end;

procedure TdxSkinAlternateImageAttributes.DataWrite(AStream: TStream);
begin
  AStream.WriteBuffer(FAlpha, SizeOf(FAlpha));
  AStream.WriteBuffer(FGradient, SizeOf(FGradient));
  AStream.WriteBuffer(FGradientBeginColor, SizeOf(FGradientBeginColor));
  AStream.WriteBuffer(FGradientEndColor, SizeOf(FGradientEndColor));
  Borders.DataWrite(AStream);
  BordersInner.DataWrite(AStream);
  ContentOffsets.SaveToStream(AStream);
end;

procedure TdxSkinAlternateImageAttributes.Draw(ACanvas: TdxSkinCanvas; const R: TRect);
var
  ARect: TRect;
begin
  ARect := cxRectContent(R, ContentOffsets.Rect);
  ACanvas.FillRectByGradient(ARect, GradientBeginColor, GradientEndColor, Gradient, Alpha);
  Borders.Draw(ACanvas, ARect);
  BordersInner.Draw(ACanvas, cxRectContent(ARect, Borders.ContentMargins));
end;

function TdxSkinAlternateImageAttributes.GetIsAlphaUsed: Boolean;
begin
  Result := (Alpha < MaxByte) or not cxRectIsEqual(ContentOffsets.Rect, cxNullRect);
end;

procedure TdxSkinAlternateImageAttributes.SetAlpha(AValue: Byte);
begin
  if Alpha <> AValue then
  begin
    FAlpha := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinAlternateImageAttributes.SetBorders(AValue: TdxSkinBorders);
begin
  FBorders.Assign(AValue);
end;

procedure TdxSkinAlternateImageAttributes.SetBordersInner(AValue: TdxSkinBorders);
begin
  FBordersInner.Assign(AValue);
end;

procedure TdxSkinAlternateImageAttributes.SetContentOffsets(AValue: TcxRect);
begin
  FContentOffsets.Assign(AValue);
end;

procedure TdxSkinAlternateImageAttributes.SetGradientBeginColor(AValue: TColor);
begin
  if AValue <> FGradientBeginColor then
  begin
    FGradientBeginColor := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinAlternateImageAttributes.SetGradientEndColor(AValue: TColor);
begin
  if AValue <> GradientEndColor then
  begin
    FGradientEndColor := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinAlternateImageAttributes.SetGradientMode(AValue: TdxSkinGradientMode);
begin
  if AValue <> FGradient then
  begin
    FGradient := AValue;
    Changed([scContent]);
  end;
end;

{ TdxSkinControlGroup }

constructor TdxSkinControlGroup.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FElements := TdxSkinElements.Create(Self);
  FElements.OnChange := SubItemChanged;
end;

destructor TdxSkinControlGroup.Destroy;
begin
  FreeAndNil(FElements);
  inherited Destroy;
end;

procedure TdxSkinControlGroup.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxSkinControlGroup then
      FElements.Assign(TdxSkinControlGroup(Source).FElements);
    inherited Assign(Source);
  finally
    EndUpdate; 
  end;
end;

function TdxSkinControlGroup.AddElement(const AName: string): TdxSkinElement;
begin
  Result := AddElementEx(AName, TdxSkinElement);
end;

function TdxSkinControlGroup.AddElementEx(
  const AName: string; AElementClass: TdxSkinElementClass): TdxSkinElement;
begin
  Result := FElements.Add(AName, AElementClass);
end;

procedure TdxSkinControlGroup.Clear;
begin
  inherited Clear;
  FElements.Clear;
end;

procedure TdxSkinControlGroup.ClearModified;
var
  I: Integer;
begin
  FModified := False;
  for I := 0 to Count - 1 do
    Elements[I].Modified := False;  
end;

procedure TdxSkinControlGroup.Delete(AIndex: Integer);
begin
  FElements.FreeAndDelete(AIndex);
end;

procedure TdxSkinControlGroup.ExchangeElements(AIndex1, AIndex2: Integer);
begin
  FElements.Exchange(AIndex1, AIndex2);
end;

procedure TdxSkinControlGroup.RemoveElement(AElement: TdxSkinElement);
begin
  FElements.FreeAndRemove(AElement);
end;

procedure TdxSkinControlGroup.RemoveElementByName(const AElementName: string);
var
  AElement: TdxSkinElement;
begin
  if GetElementByName(AElementName, AElement) then
    RemoveElement(AElement);
end;

function TdxSkinControlGroup.GetElementByName(const AName: string): TdxSkinElement;
begin
  Result := FElements.FindItemByName(AName);
end;

function TdxSkinControlGroup.GetElementByName(
  const AName: string; out AElement: TdxSkinElement): Boolean;
begin
  AElement := GetElementByName(AName);
  Result := AElement <> nil;
end;

procedure TdxSkinControlGroup.DataRead(
  AStream: TStream; const AVersion: TdxSkinVersion);
begin
  FElements.DataRead(AStream, AVersion);
  FProperties.DataRead(AStream, AVersion);
end;

procedure TdxSkinControlGroup.DataWrite(AStream: TStream);
begin
  dxSkinWriteStringToStream(AStream, Name);
  FElements.DataWrite(AStream);
  FProperties.DataWrite(AStream);
end;

procedure TdxSkinControlGroup.Sort;
begin
  inherited Sort;
  FElements.Sort;
end;

function TdxSkinControlGroup.GetCount: Integer;
begin
  Result := FElements.Count;
end;

function TdxSkinControlGroup.GetElement(AIndex: Integer): TdxSkinElement;
begin
  Result := FElements[AIndex] as TdxSkinElement;
end;

function TdxSkinControlGroup.GetHasMissingElements: Boolean;
var
  I: Integer;
begin
  Result := sosUnassigned in State;
  if not Result then
  begin
    for I := 0 to Count - 1 do
    begin
      Result := sosUnassigned in Elements[I].State;
      if Result then Break;
    end;
  end;
end;

function TdxSkinControlGroup.GetSkin: TdxSkin;
begin
  Result := GetOwner as TdxSkin;
end;

procedure TdxSkinControlGroup.SetElement(AIndex: Integer; AElement: TdxSkinElement);
begin
  Elements[AIndex].Assign(AElement);
end;

{ TdxSkinElement }

constructor TdxSkinElement.Create(AOwner: TPersistent; const AName: string);
begin
  inherited Create(AOwner, AName);
  FAlpha := MaxByte;
  FColor := clDefault;
  FTextColor := clDefault;
  FImage := TdxSkinImage.Create(Self);
  FImage.OnChange := SubItemChanged;
  FContentOffset := TcxRect.Create(Self);
  FContentOffset.OnChange := SubItemChanged;
  FGlyph := TdxSkinImage.Create(Self);
  FGlyph.OnChange := SubItemChanged;
  FBorders := TdxSkinBorders.Create(Self, sdxBorders);
  FBorders.OnChange := BordersChanged;
  FMinSize := TcxSize.Create(Self);
  FMinSize.OnChange := SubItemChanged;
end;

destructor TdxSkinElement.Destroy;
begin
  UseCache := False;
  FreeAndNil(FMinSize);
  FreeAndNil(FContentOffset);
  FreeAndNil(FImage);
  FreeAndNil(FGlyph);
  FreeAndNil(FBorders);
  inherited Destroy;  
end;

function TdxSkinElement.AddAlternateImageAttributes(
  AState: TdxSkinElementState; AImageIndex: Integer): TdxSkinAlternateImageAttributes;
begin
  Result := TdxSkinAlternateImageAttributes(AddProperty(
    dxSkinGetAlternateImageAttrsPropertyName(AState, AImageIndex),
    TdxSkinAlternateImageAttributes));
end;

procedure TdxSkinElement.Assign(Source: TPersistent);
begin
  if Source is TdxSkinElement then
  begin
    Image.Assign(TdxSkinElement(Source).Image);
    Glyph.Assign(TdxSkinElement(Source).Glyph);
    Color := TdxSkinElement(Source).Color;
    Alpha := TdxSkinElement(Source).Alpha;
    ContentOffset := TdxSkinElement(Source).ContentOffset;
    Borders := TdxSkinElement(Source).Borders;
    MinSize := TdxSkinElement(Source).MinSize;
    TextColor := TdxSkinElement(Source).TextColor;
    UseCache := TdxSkinElement(Source).UseCache;
  end;
  inherited Assign(Source);
end;

function TdxSkinElement.CanUseAlternateImageSet(
  AImageIndex: Integer; AState: TdxSkinElementState; ALowColorsMode: Boolean;
  out AStateAttributes: TdxSkinAlternateImageAttributes): Boolean;
begin
  Result := Image.Empty or (dxSkinsUseImageSet = imsAlternate) or
    ALowColorsMode and (dxSkinsUseImageSet = imsDefault);
  if Result then
  begin
    Image.CheckState(AState, AImageIndex);
    CheckAlternateImageSet(AImageIndex);
    AStateAttributes := FAlternateImageSet[AState];
    Result := AStateAttributes <> nil;
  end;
end;

procedure TdxSkinElement.Changed(AChanges: TdxSkinChanges);
begin
  if scStruct in AChanges then
    AlternateImageSetDirty := True;
  inherited Changed(AChanges);
end;

procedure TdxSkinElement.CheckAlternateImageSet(AIndex: Integer);
var
  AProperty: TdxSkinProperty;
  AState: TdxSkinElementState;
begin
  AlternateImageSetDirty := AlternateImageSetDirty or (AlternateImageSetIndex <> AIndex);
  if AlternateImageSetDirty then
  begin
    for AState := Low(TdxSkinElementState) to High(TdxSkinElementState) do
    begin
      if GetPropertyByName(dxSkinGetAlternateImageAttrsPropertyName(AState, AIndex), AProperty) and
        (AProperty is TdxSkinAlternateImageAttributes)
      then
        FAlternateImageSet[AState] := TdxSkinAlternateImageAttributes(AProperty)
      else
        FAlternateImageSet[AState] := nil;
    end;
    FAlternateImageSetIndex := AIndex;
    FAlternateImageSetDirty := False;
  end;
end;

function TdxSkinElement.Compare(AElement: TdxSkinElement): Boolean;
begin
  Result := SameText(AElement.Name, Name) and (Color = AElement.Color) and
    (Alpha = AElement.Alpha) and (TextColor = AElement.TextColor) and
    MinSize.IsEqual(AElement.MinSize) and ContentOffset.IsEqual(AElement.ContentOffset.Rect) and
    Borders.Compare(AElement.Borders) and FProperties.Compare(AElement.FProperties) and
    Image.Compare(AElement.Image) and Glyph.Compare(AElement.Glyph);
end;

function TdxSkinElement.GetTextColor(
  AState: TcxButtonState; const APropertyPrefix: string = ''): TColor;
var
  AProperty: TdxSkinProperty;
begin
  Result := clDefault;
  if dxSkinElementTextColorPropertyNames[AState] <> '' then
  begin
    if GetPropertyByName(APropertyPrefix + dxSkinElementTextColorPropertyNames[AState], AProperty) then
      Result := (AProperty as TdxSkinColor).Value;
  end;

  if Result = clDefault then
  begin
    if AState <> cxbsNormal then
      Result := GetTextColor(cxbsNormal, APropertyPrefix)
    else
      Result := TextColor;
  end;
end;

procedure TdxSkinElement.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  ACanvas: TdxSkinCanvas;
begin
  if not cxRectIsEmpty(ARect) and RectVisible(DC, ARect) then
  begin
    if UseCache then
      FCache.DrawEx(DC, Self, ARect, AState, AImageIndex)
    else
    begin
      ACanvas := TdxSkinCanvas.Create;
      try
        ACanvas.BeginPaint(DC, ARect);
        try
          DrawEx(ACanvas, ARect, AImageIndex, AState);
        finally
          ACanvas.EndPaint;
        end;
      finally
        ACanvas.Free;
      end;
    end;
  end;
end;

procedure TdxSkinElement.DrawEx(ACanvas: TdxSkinCanvas; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  AAttributes: TdxSkinAlternateImageAttributes;
begin
  ACanvas.FillRectByColor(ARect, Color, Alpha);
  if CanUseAlternateImageSet(AImageIndex, AState, ACanvas.LowColorsMode, AAttributes) then
    AAttributes.Draw(ACanvas, ARect)
  else
    Image.DrawEx(ACanvas, ARect, AImageIndex, AState);
  Borders.Draw(ACanvas, ARect);
  Glyph.DrawEx(ACanvas, cxRectContent(ARect, ContentOffset.Rect), AImageIndex, AState);
end;

procedure TdxSkinElement.SetStateMapping(AStateOrder: array of TdxSkinElementState);
begin
  FImage.SetStateMapping(AStateOrder);
  FGlyph.SetStateMapping(AStateOrder);
end;

function TdxSkinElement.ExpandName(ABitmap: TdxSkinImage): string;
begin
  Result := Name + BitmapNameSuffixes[ABitmap = Image]
end;

procedure TdxSkinElement.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  AColor: TColor;
begin
  AStream.ReadBuffer(AColor, SizeOf(TColor));
  Color := AColor;
  AStream.ReadBuffer(FAlpha, SizeOf(FAlpha));
  if AVersion < 1.10 then
    AStream.ReadBuffer(FReadedImageCount, SizeOf(FReadedImageCount));
  ContentOffset.LoadFromStream(AStream);
  Glyph.DataRead(AStream, AVersion);
  Image.DataRead(AStream, AVersion);
  Borders.DataRead(AStream, AVersion);
  AStream.ReadBuffer(FTextColor, SizeOf(TColor));
  MinSize.LoadFromStream(AStream);
  FProperties.DataRead(AStream, AVersion);
end;

procedure TdxSkinElement.DataWrite(AStream: TStream);
begin
  AStream.WriteBuffer(FColor, SizeOf(TColor));
  AStream.WriteBuffer(FAlpha, SizeOf(Alpha));
  ContentOffset.SaveToStream(AStream);
  Glyph.DataWrite(AStream);
  Image.DataWrite(AStream);
  Borders.DataWrite(AStream);
  AStream.WriteBuffer(FTextColor, SizeOf(TColor));
  MinSize.SaveToStream(AStream);
  FProperties.DataWrite(AStream);
end;

procedure TdxSkinElement.BordersChanged(ASender: TObject; AChanges: TdxSkinChanges);
begin
  Changed(AChanges);
end;

procedure TdxSkinElement.SubItemChanged(ASender: TObject);
begin
  Changed([scContent]);
end;

function TdxSkinElement.GetGroup: TdxSkinControlGroup;
begin
  Result := GetOwner as TdxSkinControlGroup;
end;

function TdxSkinElement.GetImageCount: Integer;
begin
  Result := Image.ImageCount;
end;

function TdxSkinElement.GetIsAlphaUsed: Boolean;
begin
  //todo: check for alternate states
  if Image.Empty then
    Result := not cxColorIsValid(Color) or (Alpha < 255)
  else
    Result := not cxColorIsValid(Color) and Image.Texture.IsAlphaUsed;
end;

function TdxSkinElement.GetPath: string;
begin
  Result := Group.Name + PathDelim;
end;

function TdxSkinElement.GetSize: TSize;
begin
  Result := Image.Size; 
end;

function TdxSkinElement.GetStates: TdxSkinElementStates;
begin
  Result := Image.States;
end;

function TdxSkinElement.GetUseCache: Boolean;
begin
  Result := FCache <> nil;
end;

procedure TdxSkinElement.SetAlpha(AValue: Byte);
begin
  if Alpha <> AValue then
  begin
    FAlpha := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinElement.SetBorders(AValue: TdxSkinBorders);
begin
  FBorders.Assign(AValue);
end;

procedure TdxSkinElement.SetColor(AValue: TColor);
begin
  if AValue <> FColor then
  begin
    FColor := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinElement.SetContentOffset(AValue: TcxRect);
begin
  ContentOffset.Assign(AValue);
end;

procedure TdxSkinElement.SetGlyph(AValue: TdxSkinImage);
begin
  Glyph.Assign(AValue);
end;

procedure TdxSkinElement.SetImage(AValue: TdxSkinImage);
begin
  Image.Assign(AValue);
end;

procedure TdxSkinElement.SetMinSize(AValue: TcxSize);
begin
  FMinSize.Assign(AValue);
end;

procedure TdxSkinElement.SetTextColor(AValue: TColor);
begin
  if FTextColor <> AValue then
  begin
    FTextColor := AValue;
    Changed([scContent]);
  end;
end;

procedure TdxSkinElement.SetUseCache(AValue: Boolean);
begin
  if AValue <> UseCache then
  begin
    if AValue then
      FCache := TdxSkinElementCache.Create
    else
      FreeAndNil(FCache);
  end;
end;

{  TdxSkinEmptyElement }

procedure TdxSkinEmptyElement.Draw(DC: HDC; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal);
var
  RedBrush: HBRUSH; 
begin
  FillRect(DC, ARect, GetStockObject(WHITE_BRUSH));
  RedBrush := CreateSolidBrush(255);
  FrameRect(DC, ARect, RedBrush);
  DeleteObject(RedBrush);
end;

{  TdxSkinPartStream }

constructor TdxSkinPartStream.Create(ASource: TStream; const APosStart, ASize: LongInt);
begin
  inherited Create;
  FPosEnd := APosStart + ASize;
  FPosStart := APosStart;
  FSource := ASource;
end;

{$IFDEF DELPHI7}

function TdxSkinPartStream.GetSize: Int64;
begin
  Result := FPosEnd - FPosStart;
end;

{$ENDIF}

function TdxSkinPartStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := Source.Read(Buffer, Count);
end;

function TdxSkinPartStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  ANewPos: Longint;
begin
  ANewPos := Source.Position + Offset;
  case Origin of
    soFromBeginning:
      ANewPos := PosStart + Offset;
    soFromEnd:
      ANewPos := PosEnd + Offset;
  end;
  Source.Position := Min(Max(PosStart, ANewPos), PosEnd);
  Result := Source.Position - PosStart;
end;

function TdxSkinPartStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := Source.Write(Buffer, Count);
  FPosEnd := Source.Position;
end;

{ TdxSkinCanvas }

function TdxSkinCanvas.IsRectVisible(DC: HDC; const R: TRect): Boolean;
begin
  Result := not cxRectIsEmpty(R) and RectVisible(DC, R);
end;

procedure TdxSkinCanvas.BeginPaint(DC: HDC; const R: TRect);
begin
  FLowColorsMode := dxGpIsDoubleBufferedNeeded(DC);
  FGraphics := dxGpBeginPaint(DC, R);
end;

procedure TdxSkinCanvas.BeginPaint(AGraphics: GpGraphics);
begin
  FLowColorsMode := False;
  FGraphics := dxGpBeginPaint(AGraphics);
end;

procedure TdxSkinCanvas.EndPaint;
begin
  dxGpEndPaint(FGraphics);
end;

procedure TdxSkinCanvas.FillRectByColor(const R: TRect; AColor: TColor; AAlpha: Byte = 255);
begin
  if cxColorIsValid(AColor) then
  begin
      dxGpFillRect(Graphics.Handle, R, dxGpColorToARGB(AColor, AAlpha));
  end;
end;

procedure TdxSkinCanvas.FillRectByGradient(const R: TRect;
  AColor1, AColor2: TColor; AMode: TdxSkinGradientMode; AAlpha: Byte = 255);
const
  GradientModeFlags: array[TdxSkinGradientMode] of TdxGPLinearGradientMode = (
    LinearGradientModeHorizontal, LinearGradientModeVertical,
    LinearGradientModeForwardDiagonal, LinearGradientModeBackwardDiagonal
  );
begin
  if cxColorIsValid(AColor1) then
  begin
    if (AColor1 = AColor2) or not cxColorIsValid(AColor2) then
      FillRectByColor(R, AColor1, AAlpha)
    else
      dxGpFillRectByGradient(Graphics.Handle, R, dxGpColorToARGB(AColor1, AAlpha),
        dxGpColorToARGB(AColor2, AAlpha), GradientModeFlags[AMode]);
  end;
end;

procedure TdxSkinCanvas.DrawFrame(const R: TRect; AColor: TColor;
  ALineWidth: Integer; ABorders: TcxBorders; AAlpha: Byte);
begin
  if cxColorIsValid(AColor) and (ALineWidth > 0) and (ABorders <> []) then
  begin
    if bLeft in ABorders then
      FillRectByColor(cxRect(R.Left, R.Top, Min(R.Left + ALineWidth, R.Right), R.Bottom), AColor, AAlpha);
    if bRight in ABorders then
      FillRectByColor(cxRect(Max(R.Right - ALineWidth, R.Left), R.Top, R.Right, R.Bottom), AColor, AAlpha);
    if bTop in ABorders then
      FillRectByColor(cxRect(R.Left, R.Top, R.Right, Min(R.Top + ALineWidth, R.Bottom)), AColor, AAlpha);
    if bBottom in ABorders then
      FillRectByColor(cxRect(R.Left, Max(R.Bottom - ALineWidth, R.Top), R.Right, R.Bottom), AColor, AAlpha);
  end;
end;

procedure TdxSkinCanvas.DrawImage(AImage: TdxSkinImage; const ADestRect, ASourceRect: TRect);
var
  ADestParts: TdxSkinElementPartBounds;
  AMargins, R: TRect;
  APart: TdxSkinImagePart;
begin
  if AImage.Stretch = smNoResize then
  begin
    Graphics.InterpolationMode := imNearestNeighbor;
    Graphics.Draw(AImage.Texture, cxRectCenter(ADestRect, AImage.Size), ASourceRect);
  end
  else
  begin
    AMargins := AImage.Margins.Margin;
    dxSkinsCheckMargins(AMargins, ADestRect);
    dxSkinsCalculatePartsBounds(ADestRect, AMargins, ADestParts);

    Graphics.InterpolationMode := imDefault;
    for APart := Low(TdxSkinImagePart) to High(TdxSkinImagePart) do
      if AImage.PartVisible[APart] then
      begin
        R := AImage.FPartsBounds[APart];
        OffsetRect(R, ASourceRect.Left, ASourceRect.Top);
        if (APart = sipCenter) and AImage.IsGradientParamsAssigned then
          FillRectByGradient(ADestParts[APart], AImage.GradientBeginColor, AImage.GradientEndColor, AImage.Gradient)
        else
          if AImage.Stretch = smStretch then
            dxGpDrawImage(Graphics.Handle, ADestParts[APart], R, AImage.Texture.Handle)
          else
            dxGpTilePartEx(Graphics.Handle, ADestParts[APart], R, AImage.Texture.Handle);
      end;
  end;
end;

procedure TdxSkinCanvas.DrawTexture(ATexture: TdxGPImage; const R: TRect; AStretchMode: TdxSkinStretchMode);
begin
  case AStretchMode of
    smStretch:
      Graphics.Draw(ATexture, R);
    smTile:
      Graphics.DrawTile(ATexture, R);
    smNoResize:
      Graphics.Draw(ATexture, cxRectCenter(R, ATexture.Width, ATexture.Height));
  end;
end;

{ TdxSkinElementCache }

destructor TdxSkinElementCache.Destroy;
begin
  FreeCache;
  inherited Destroy;
end;

procedure TdxSkinElementCache.FreeCache;
begin
  if Assigned(FCache) then
  begin
    GdipCheck(GdipDisposeImage(FCache));
    FCache := nil;
  end;
  FreeAndNil(FCacheOpaque);
end;

procedure TdxSkinElementCache.CheckCacheState(AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal;
  AImageIndex: Integer = 0);
begin
  if (AElement <> Element) or (AState <> FState) or (FImageIndex <> AImageIndex) or
    (cxRectWidth(R) <> cxRectWidth(FRect)) or (cxRectHeight(R) <> cxRectHeight(FRect)) or
    (FImageSet <> dxSkinsUseImageSet)
  then
  begin
    FRect := R;
    FState := AState;
    FElement := AElement;
    FImageIndex := AImageIndex;
    FImageSet := dxSkinsUseImageSet;
    FreeCache;
    if not IsRectEmpty(R) then
    begin
      if AElement.IsAlphaUsed then
        InitCache(R)
      else
        InitOpaqueCache(R);
    end;
  end;
end;

procedure TdxSkinElementCache.InitCache(R: TRect);
var
  ACanvas: TdxSkinCanvas;
  AGraphics: GpGraphics;
begin
  ACanvas := TdxSkinCanvas.Create;
  try
    OffsetRect(R, -R.Left, -R.Top);
    FCache := dxGpCreateBitmap(R);
    GdipCheck(GdipGetImageGraphicsContext(FCache, AGraphics));
    ACanvas.BeginPaint(AGraphics);
    try
      Element.DrawEx(ACanvas, R, ImageIndex, State);
    finally
      ACanvas.EndPaint;
    end;
  finally
    ACanvas.Free;                                     
  end;
end;

procedure TdxSkinElementCache.InitOpaqueCache(R: TRect);
var
  ACanvas: TdxSkinCanvas;
begin
  ACanvas := TdxSkinCanvas.Create;
  try
    OffsetRect(R, -R.Left, -R.Top);
    FCacheOpaque := TcxBitmap.CreateSize(R, pf32bit);
    ACanvas.BeginPaint(FCacheOpaque.Canvas.Handle, R);
    try
      Element.DrawEx(ACanvas, R, ImageIndex, State);
    finally
      ACanvas.EndPaint;
    end;
  finally
    ACanvas.Free;
  end;
end;

procedure TdxSkinElementCache.Draw(DC: HDC; const R: TRect);
var
  AGraphics: TdxGPGraphics;
begin
  if FCacheOpaque <> nil then
    cxBitBlt(DC, FCacheOpaque.Canvas.Handle, R, cxNullPoint, SRCCOPY)
  else
    if FCache <> nil then
    begin
      AGraphics := dxGpBeginPaint(DC, R);
      try
        GdipCheck(GdipDrawImageRectI(AGraphics.Handle, FCache,
          R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
      finally
        dxGpEndPaint(AGraphics);
      end;
    end;
end;

procedure TdxSkinElementCache.DrawEx(DC: HDC; AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
begin
  CheckCacheState(AElement, R, AState, AImageIndex);
  Draw(DC, R);
end;

procedure TdxSkinElementCache.Flush;
begin
  FElement := nil;
  FRect := cxNullRect;
  FreeCache;
end;

{ TdxSkinElementCacheList }

constructor TdxSkinElementCacheList.Create;
begin
  inherited Create;
  CacheListLimit := dxSkinElementCacheListLimit;
end;

procedure TdxSkinElementCacheList.DrawElement(DC: HDC; AElement: TdxSkinElement;
  const R: TRect; AState: TdxSkinElementState = esNormal; AImageIndex: Integer = 0);
var
  AElementCache: TdxSkinElementCache;
begin
  if not FindElementCache(AElement, R, AElementCache) then
  begin
    AElementCache := TdxSkinElementCache.Create;
    Add(AElementCache);
    CheckListLimits;
  end;
  AElementCache.DrawEx(DC, AElement, R, AState, AImageIndex);
end;

procedure TdxSkinElementCacheList.CheckListLimits;
begin
  if Count > CacheListLimit then
  begin
    ElementCache[0].Free;
    Delete(0);
  end;
end;

procedure TdxSkinElementCacheList.Flush;
begin
  Clear;
end;

function TdxSkinElementCacheList.FindElementCache(AElement: TdxSkinElement;
  const R: TRect; out AElementCache: TdxSkinElementCache): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    AElementCache := ElementCache[I];
    Result := (AElementCache.Element = AElement) and cxRectIsEqual(R, AElementCache.FRect);
    if Result then
      Break;
  end;
end;

function TdxSkinElementCacheList.GetElementCache(AIndex: Integer): TdxSkinElementCache;
begin
  Result := TdxSkinElementCache(Items[AIndex]);
end;

{ TdxSkinBinaryWriter }

constructor TdxSkinBinaryWriter.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
  FHeaderOffset := AStream.Position;
  WriteHeader;
end;

destructor TdxSkinBinaryWriter.Destroy;
begin
  WriteHeader;
  inherited Destroy;
end;

procedure TdxSkinBinaryWriter.AddSkin(ASkin: TdxSkin);
var
  ASavedPosition: Integer;
  ASkinSize: Integer;
begin
  Inc(FCount);
  ASavedPosition := Stream.Position;
  Stream.WriteBuffer(ASkinSize, SizeOf(ASkinSize));
  ASkin.SaveToStream(Stream);
  ASkinSize := Stream.Position - ASavedPosition - SizeOf(ASkinSize);
  Stream.Position := ASavedPosition;
  Stream.WriteBuffer(ASkinSize, SizeOf(ASkinSize));
  Stream.Position := ASavedPosition + ASkinSize + SizeOf(ASkinSize);
end;

procedure TdxSkinBinaryWriter.WriteHeader;
begin
  Stream.Position := FHeaderOffset;
  dxSkinWriteSignature(Stream);
  Stream.WriteBuffer(FCount, SizeOf(FCount));
end;

{ TdxSkinBinaryReader }

constructor TdxSkinBinaryReader.Create(AStream: TStream);
begin
  inherited Create;
  FSkins := TcxObjectList.Create;
  FStream := AStream;
  ReadSkinsInfo;
end;

destructor TdxSkinBinaryReader.Destroy;
begin
  FreeAndNil(FSkins);
  inherited Destroy;
end;

function TdxSkinBinaryReader.IndexOf(const ASkinName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if SameText(ASkinName, SkinName[I]) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxSkinBinaryReader.LoadSkin(ASkin: TdxSkin; ASkinIndex: Integer): Boolean;
begin
  Result := (ASkinIndex >= 0) and (ASkinIndex < Count);
  if Result then
  begin
    Stream.Position := SkinOffset[ASkinIndex];
    ASkin.LoadFromStream(Stream);
  end;
end;

function TdxSkinBinaryReader.LoadSkin(ASkin: TdxSkin; const ASkinName: string): Boolean;
begin
  if ASkinName <> '' then
    Result := LoadSkin(ASkin, IndexOf(ASkinName))
  else
    Result := LoadSkin(ASkin, 0);
end;

function TdxSkinBinaryReader.ReadBinaryProject(AStream: TStream): Boolean;
var
  ASavedPosition: Integer;
  ASkinCount: Integer;
  ASkinSize: Integer;
  AVersion: Double;
  I: Integer;
begin
  Result := False;
  if dxSkinCheckSignature(AStream, AVersion) then
  begin
    if AStream.Read(ASkinCount, SizeOf(ASkinCount)) = SizeOf(ASkinCount) then
    begin
      for I := 0 to ASkinCount - 1 do
      begin
        AStream.ReadBuffer(ASkinSize, SizeOf(ASkinSize));
        ASavedPosition := AStream.Position;
        if not ReadBinarySkin(AStream) then Exit;
        AStream.Position := ASavedPosition + ASkinSize;
      end;
      Result := True;
    end;
  end;
end;

function TdxSkinBinaryReader.ReadBinarySkin(AStream: TStream): Boolean;
var
  ADetails: TdxSkinDetails;
begin
  ADetails := TdxSkinDetails.Create;
  Result := ADetails.LoadFromStream(AStream);
  if Result then
    FSkins.Add(ADetails)
  else
    ADetails.Free;
end;

procedure TdxSkinBinaryReader.ReadSkinsInfo;
var
  ASavedPosition: Integer;
begin
  ASavedPosition := Stream.Position;
  if not ReadBinaryProject(Stream) then
  begin
    Stream.Position := ASavedPosition;
    ReadBinarySkin(Stream);
  end;
end;

function TdxSkinBinaryReader.GetCount: Integer;
begin
  Result := FSkins.Count;
end;

function TdxSkinBinaryReader.GetSkinDetails(Index: Integer): TdxSkinDetails;
begin
  Result := TdxSkinDetails(FSkins[Index]);
end;

function TdxSkinBinaryReader.GetSkinDisplayName(Index: Integer): string;
begin
  Result := SkinDetails[Index].DisplayName;
end;

function TdxSkinBinaryReader.GetSkinName(Index: Integer): string;
begin
  Result := SkinDetails[Index].Name;
end;

function TdxSkinBinaryReader.GetSkinOffset(Index: Integer): Integer;
begin
  Result := SkinDetails[Index].FDataOffset;
end;

{ TdxSkinDetails }

constructor TdxSkinDetails.Create;
var
  ASize: TdxSkinIconSize;
begin
  inherited Create;
  for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
  begin
    FIcons[ASize] := TdxPNGImage.Create;
    FIcons[ASize].OnChange := DoIconsChanged;
  end;
end;

destructor TdxSkinDetails.Destroy;
var
  ASize: TdxSkinIconSize;
begin
  for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
  begin
    FIcons[ASize].OnChange := nil;
    FreeAndNil(FIcons[ASize]);
  end;
  inherited Destroy;
end;

procedure TdxSkinDetails.Assign(Source: TPersistent);
var
  ASize: TdxSkinIconSize;
begin
  if Source is TdxSkinDetails then
  begin
    BeginUpdate;
    try
      Name := TdxSkinDetails(Source).Name;
      Notes := TdxSkinDetails(Source).Notes;
      GroupName := TdxSkinDetails(Source).GroupName;
      DisplayName := TdxSkinDetails(Source).DisplayName;
      for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
        Icons[ASize].Assign(TdxSkinDetails(Source).Icons[ASize]);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxSkinDetails.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxSkinDetails.EndUpdate;
begin
  Dec(FUpdateCount);
  Changed;
end;

procedure TdxSkinDetails.Changed;
begin
  if FUpdateCount = 0 then
  begin
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TdxSkinDetails.Clear;
var
  ASize: TdxSkinIconSize;
begin
  BeginUpdate;
  try
    Name := '';
    Notes := '';
    GroupName := '';
    DisplayName := '';
    for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
      Icons[ASize].Clear;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinDetails.DataRead(AStream: TStream; const AVersion: TdxSkinVersion);
var
  ASize: TdxSkinIconSize;
begin
  BeginUpdate;
  try
    Clear;
    FName := dxSkinReadStringFromStream(AStream);
    if AVersion >= 1.04 then
    begin
      FDisplayName := dxSkinReadStringFromStream(AStream);
      FGroupName := dxSkinReadStringFromStream(AStream);
      FNotes := dxSkinReadWideStringFromStream(AStream);
      ReadPngImage(AStream, Icons[sis16]);
      ReadPngImage(AStream, Icons[sis48]);
    end;
    for ASize := Low(TdxSkinIconSize) to High(TdxSkinIconSize) do
    begin
      if Icons[ASize].Empty then
        ResetIcon(ASize);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxSkinDetails.DataWrite(AStream: TStream);
begin
  dxSkinWriteStringToStream(AStream, Name);
  dxSkinWriteStringToStream(AStream, DisplayName);
  dxSkinWriteStringToStream(AStream, GroupName);
  dxSkinWriteWideStringToStream(AStream, Notes);
  WritePngImage(AStream, Icons[sis16]);
  WritePngImage(AStream, Icons[sis48]);
end;

procedure TdxSkinDetails.DoIconsChanged(Sender: TObject);
begin
  Changed;
end;

function TdxSkinDetails.LoadFromStream(AStream: TStream): Boolean;
var
  ASkin: TdxSkin;
  AVersion: TdxSkinVersion;
begin
  FDataOffset := AStream.Position;
  Result := dxSkinCheckSignature(AStream, AVersion);
  if Result then
  begin
    if AVersion < 1.04 then
    begin
      ASkin := TdxSkin.Create('', False, 0);
      try
        AStream.Position := FDataOffset;
        ASkin.LoadFromStream(AStream);
        Assign(ASkin.Details);
      finally
        ASkin.Free;
      end;
    end
    else
      DataRead(AStream, AVersion);
  end;
end;

procedure TdxSkinDetails.ResetIcon(ASize: TdxSkinIconSize);
const
  SkinIconNames: array[TdxSkinIconSize] of string =
    (sdxSkinDefaultSkinIcon, sdxSkinDefaultSkinIconLarge);
begin
  Icons[ASize].LoadFromResource(HInstance, SkinIconNames[ASize], sdxResourceType);
end;

function TdxSkinDetails.GetIcon(ASize: TdxSkinIconSize): TdxPNGImage;
begin
  Result := FIcons[ASize];
end;

procedure TdxSkinDetails.SetDisplayName(const AValue: string);
begin
  if AValue <> FDisplayName then
  begin
    FDisplayName := AValue;
    Changed;
  end;
end;

procedure TdxSkinDetails.SetGroupName(const AValue: string);
begin
  if AValue <> FGroupName then
  begin
    FGroupName := AValue;
    Changed;
  end;
end;

procedure TdxSkinDetails.SetName(const AValue: string);
begin
  if AValue <> FName then
  begin
    FName := AValue;
    Changed;
  end;
end;

procedure TdxSkinDetails.SetNotes(const AValue: WideString);
begin
  if AValue <> FNotes then
  begin
    FNotes := AValue;
    Changed;
  end;
end;

//

procedure RegisterAssistants;
begin
  dxSkinEmptyElement := TdxSkinEmptyElement.Create(nil, '');
  RegisteredPropertyTypes := TList.Create;
  RegisterClasses([TdxSkinControlGroup, TdxSkinElement, TdxSkinImage]);
  // register properties
  TdxSkinAlternateImageAttributes.Register;
  TdxSkinBooleanProperty.Register;
  TdxSkinColor.Register;
  TdxSkinIntegerProperty.Register;
  TdxSkinRectProperty.Register;
  TdxSkinSizeProperty.Register;
  TdxSkinStringProperty.Register;
  TdxSkinWideStringProperty.Register;
  //
  CheckGdiPlus;
  CheckPngCodec;
end;

procedure UnregisterAssistants;
begin
  UnRegisterClasses([TdxSkinControlGroup, TdxSkinElement, TdxSkinImage]);

  TdxSkinAlternateImageAttributes.Unregister;
  TdxSkinBooleanProperty.Unregister;
  TdxSkinColor.Unregister;
  TdxSkinIntegerProperty.Unregister;
  TdxSkinRectProperty.Unregister;
  TdxSkinSizeProperty.Unregister;
  TdxSkinStringProperty.Unregister;
  TdxSkinWideStringProperty.Unregister;

  FreeAndNil(RegisteredPropertyTypes);
  FreeAndNil(dxSkinEmptyElement);
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterAssistants);

end.
