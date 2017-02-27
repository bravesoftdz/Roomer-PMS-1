{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2014 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit dxServerModeDBXDataSourceReg;

{$I cxVer.inc}

interface

uses
  Windows, Types, Classes, DesignIntf, DesignEditors,
  dxCoreReg, dxServerModeData, dxServerModeReg, dxServerModeDBXDataSource;

procedure Register;

implementation

uses
  TreeIntf;

type
  TdxServerModeCustomDataSourceAccess = class(TdxServerModeCustomDataSource);

  { TdxServerModeSchemaNameProperty }

  TdxServerModeSchemaNameProperty = class(TStringProperty)
  private
    function GetDataSource: TdxServerModeCustomDataSource;
    function GetDataSourceHelper: TdxServerModeDBXDataSourceHelper;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TdxServerModeSchemaNameProperty }

function TdxServerModeSchemaNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TdxServerModeSchemaNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  AValues: TStringList;
begin
  AValues := TStringList.Create;
  try
    GetDataSourceHelper.PopulateSchemaNames(AValues);
    for I := 0 to AValues.Count - 1 do
      Proc(AValues[I]);
  finally
    AValues.Free;
  end;
end;

function TdxServerModeSchemaNameProperty.GetDataSource: TdxServerModeCustomDataSource;
begin
  Result := (GetComponent(0) as TdxServerModeDBXDataSourceOptions).Owner;
end;

function TdxServerModeSchemaNameProperty.GetDataSourceHelper: TdxServerModeDBXDataSourceHelper;
begin
  with TdxServerModeCustomDataSourceAccess(GetDataSource) do
    Result := Helper as TdxServerModeDBXDataSourceHelper;
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
{$IFNDEF NONDB}
  RegisterComponents(dxCoreLibraryProductPage, [TdxServerModeDBXDataSource, TdxServerModeDBXQueryDataSource]);
  RegisterPropertyEditor(TypeInfo(string), TdxServerModeDBXDataSourceOptions, 'SchemaName', TdxServerModeSchemaNameProperty);
{$ENDIF}
end;

end.
