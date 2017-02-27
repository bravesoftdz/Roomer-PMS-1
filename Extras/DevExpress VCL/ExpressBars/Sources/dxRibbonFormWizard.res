        ��  ��                  K  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxBarApplicationMenu.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxBarApplicationMenu *dxBarApplicationMenu1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
private:	// User declarations
public:     // User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

 p  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxBarApplicationMenu"
#pragma link "dxRibbon"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
�  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, 
  cxLookAndFeels, cxLookAndFeelPainters, cxClasses;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarApplicationMenu1: TdxBarApplicationMenu;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

end.   \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxBarApplicationMenu1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxBarApplicationMenu1: TdxBarApplicationMenu
    BarManager = dxBarManager1
    Left = 536
    Top = 8
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
end �  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif
 �  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
  S  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

end. 
  \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    Style = rs2010
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recents'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmButton
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end   �  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

:  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall T%FormIdent%::FormCreate(TObject *Sender)
{
     DisableAero = True;
}
//---------------------------------------------------------------------------

  �  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

{ T%FormIdent% }

procedure T%FormIdent%.FormCreate(Sender: TObject);
begin
  DisableAero := True;
end;

end.
   �
  \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  OnCreate = FormCreate
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    Style = rs2013
    ColorSchemeName = 'White'
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recent'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        BorderStyle = cxcbsNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.ContentOffset.All = 0
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmTag
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end   �      �� ��     0          (       @         �                     	

!! ##"   	
	 ! ##"%%$(('	
	  ""!%%$''&**)	

""!$$#''&))(,,+TUT	

!! $$#&&%))(++*..-���565	
	!! ##"&&%(('++*--,00/������	
	  "#"%%$''&**)--,//.221���������	

  ""!$%$''&**),,+/.-110443������������	

!"!$$#&&%))(,,+..-10/332665���������������	

!! ##"&&%(('++*.-,00/321554887������������������	
	 ! ##"%%$(('**)--,0/.221554776::9���������������������	
	  ""!%%$''&**),,+//.210443765998<<;������������������������%&%	

""!$$#''&))(,,+..-110432665987;;:>>=���������������������������WXW!! $$#&&%))(++*..-00/332654887;:9>=<@@?/Nɱ�����������������������������!! ##"&&%(('++*--,00/221554876::9=<;@?>BBA/O�/Pˊ�����������������������������@@?  "#"%%$''&**)--,//.221543776:98<<;??>BA@EDC/O�/Q�.R�p��������������������������������))( ""!$%$''&**),,+/.-110443765998<;:?>=AA@DCBGFE/P�.Q�.S�-U�Gk�������������������������������sss!"!$$#&&%))(,,+..-10/332665987;;:>=<A@?CCBFEDIHG/P�.R�.S�-U�-W�,X҉��������������������������������\\\(('++*.-,00/321554887;:9==<@?>CBAEEDHGFKJI/Q�.R�.T�-V�-W�,Y�,Z�Fpڼ��������������������������������||{0/.221554776::9=<;??>BA@EDCGGFJIHMLK.Q�.S�-U�-V�,X�,Y�+[�+]�*^�_����������������������������������噙�PON998<<;?>=BA@DCBGFEJIHLKJONM.R�.S�-U�-W�,X�,Z�+[�+]�*_�*`�)b�z�������������������������������������ړ��YXWDCBFEDIHGLKJNMLQPO.R�.T�-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�^���������������������������������������ܣ��xwwNMLQPOSRQ.S�-T�-V�,X�,Y�+[�+]�*^�*`�)a�)c�(e�(f�(h�'i�B~撵������������������������������������������޽��.S�-U�-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�N����������������������������������������.T�-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&n�%o�%q�$r�$t�?��v����������������������������-T�-V�,X�,Y�+[�+]�*^�*`�)a�)c�(e�(f�(h�'i�'k�&l�&n�%p�%q�$s�$t�#v�#w�"y�"z�/��Y�����������������-U�-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�%p�$r�$s�#u�#v�#x�"y�"{�!|�!~� � �� �� �� ��-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&n�%o�%q�$r�$t�#u�#w�"x�"z�!{�!}� ~� �� �� �� �� ��-V�,X�,Y�+[�+]�*^�*`�)a�)c�)e�(f�(h�'i�'k�&l�&n�%p�%q�$s�$t�#v�#w�"y�"z�!|�!}� � �� �� �� �� ��-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�%p�$r�$s�#u�#v�#x�"y�"{�!|�!~� � �� �� �� �� ��   ,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&m�%o�%q�$r�$t�#u�#w�"x�"z�!{�!}� ~� �� �� �� �� ��   �                                                                                                                          �  h      �� ��     0          (                @                  	
	!! %&%	 $$#))(CCC	##"(('--,���565""!''&,,+110������

!! &&%++*00/654���������565	
	  %%$**)//.443:98������������FGF$$#))(..-332887>=<;Y����������������##"(('--,221776=<;BA@/P�;^ѣ��������������VVU""!''&,,+110665;;:A@?FED.Q�-T�,X�a�����������������RRQ0/.554::9@?>EDCJJI.R�-U�,Y�+\�*_؇����������������̄��JJIDCBIHGONM.S�-W�,Z�+]�*`�)c�(g�x�������������������Ц��{zy-T�,X�,[�+^�*a�)d�(h�'k�&n�@�ꄱ���������������-U�,Y�+\�*_�)b�(e�'i�&l�%o�$r�#u�"x�!{�:��T��y��-V�,Z�+]�*`�)c�(f�'j�&m�%p�$s�#v�"y�!|� � �� ��-X�,[�+^�*a�)d�(h�'k�&n�%q�$t�#w�"z�!}� �� �� ��                                                                �      �� ��     0          (   0   `         �                        	

 !! ##"         		
	!! ""!$$#&&%   		
	

  ""!#$#%%$''&(('	
	

  !"!##"%%$''&(('**)	

 !! ##"$%$&&%(('**)++*	

!! "#"$$#&&%''&))(++*--,���		
	 ! ""!$$#%%$''&))(++*,,+..-���565		
	

  ""!##"%%$''&(('**),,+.-,//.������	
	

  !! ##"%%$&&%(('**)++*--,//.10/���������	

 !! ##"$$#&&%(('))(++*--,..-00/221������������		
	!! ""!$$#&&%''&))(++*,,+..-00/210332���������������		
	

  ""!#$#%%$''&(('**),,+..-//.110332543���������������ddd	
	

  !"!##"%%$''&(('**),,+--,//.110321443665������������������ddd	

 !! ##"$%$&&%(('**)++*--,/.-10/221443654776���������������������ddd	

!! "#"$$#&&%''&))(++*--,..-00/221432554776987������������������������ddd		
	 ! ""!$$#%%$''&))(++*,,+..-0/.110332554765887::9������������������������������		
	

  ""!##"%%$''&(('**),,+.-,//.110321443665887:98;;:���������������������������������	
	

  !! ##"%%$&&%(('**)++*--,//.10/221443665876998;;:=<;������������������������������������	

 !! ##"$$#&&%(('))(++*--,..-00/221432554776998;:9=<;>>=���������������������������������������676	
	!! ""!$$#&&%''&))(++*,,+..-00/210332554765987::9<<;>=<@?>~�����������������������������������������fgf  ""!#$#%%$''&(('**),,+..-//.110332543765887::9<;:>=<??>A@?0N�}��������������������������������������������  !"!##"%%$''&(('**),,+--,//.110321443665876:98;;:==<?>=A@?BBA/N�/O�c|�������������������������������������������>?> !! ##"$%$&&%(('**)++*--,/.-10/221443654776998;:9=<;>>=@@?BA@DCB/N�/P�/Q�Us����������������������������������������������!! "#"$$#&&%''&))(++*--,..-00/221432554776987::9<<;>=<@?>BA@CCBEED/O�/P�/Q�.R�;^����������������������������������������������RSR ! ""!$$#%%$''&))(++*,,+..-0/.110332554765887::9<;:>=<??>AA@CBAEDCGFE/O�/P�.Q�.R�.S�-Uϖ�����������������������������������������������++*  ""!##"%%$''&(('**),,+.-,//.110321443665887:98;;:==<??>A@?CBAEDCFFEHGF/P�/Q�.R�.S�.T�-U�-V�b����������������������������������������������񏏏//.##"%%$&&%(('**)++*--,//.10/221443665876998;;:=<;?>=A@?BBADCBFEDHGFJIH/P�/Q�.R�.S�.T�-U�-V�-W�9cբ�����������������������������������������������vvv&&%(('))(++*--,..-00/221432554776998;:9=<;>>=@@?BA@DCBFEDGFEIHGKJI/P�.Q�.R�.S�-U�-V�-W�,X�,Y�,Z�`��������������������������������������������������zzy887,,+..-00/210332554765987::9<<;>=<@?>BA@CCBEDCGFEIHGJJILKJ/Q�.R�.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\֕�������������������������������������������������򖖕<<;110332543765887::9<;:>=<??>A@?CBAEDCFFEHGFJIHLKJNML/Q�.R�.S�.T�-U�-V�-W�,Y�,Z�,[�+\�+]�+^�Esݯ�����������������������������������������������������ggf665876:98;;:==<?>=A@?BBADCBFEDHGFJIHKKJMLKONM.Q�.R�.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�Du������������������������������������������������������朜�TSR=<;>>=@@?BA@DCBFEDGGFIIHKJIMLKONMQPO.R�.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�_���������������������������������������������������������ڔ��ZYXCCBEEDGFEIHGKJIMLKNMLPONRQP.R�.S�.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�Cy�����������������������������������������������������������箮����UUTLKJNMLPONRQPSRQ.R�.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)d�(e�(f�(g�'h�5r↫���������������������������������������������������������������ݲ�����ihgUTS.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�\����������������������������������������������������������������������.S�.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'j�'k�&l�&m�&n�%o�i�������������������������������������������������������������.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)d�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�i����������������������������������������������������.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�#u�#v�?��v�����������������������������������������.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�/��Y�����������������������������-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"z�"{�!|�!}�!~� � � ��<��X�����������-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�#u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� ��-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!{�!|�!}�!~� � �� �� �� �� �� �� ��-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"{�!|�!}�!~� � � �� �� �� �� �� �� ��-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�$u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� �� ��-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!{�!|�!}�!~� � �� �� �� �� �� �� �� ��   ,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�(h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!|�!}�!~� � � �� �� �� �� �� �� ��         ,Y�,Z�+[�+\�+]�*^�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%p�$r�$s�$t�$u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� ��      �      �                                                                                                                                                                                                                                                                                                                                                                      �      �      0   D   �� D X R I B B O N F O R M W I Z A R D         0                    �       h   00    �   