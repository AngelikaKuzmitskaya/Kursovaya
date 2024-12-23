unit Main;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Arcanoid, Sniper, ShellAPI, Vcl.Menus;
type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Memo1: TMemo;
    Image6: TImage;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ToggleControls(Enable: Boolean);
  end;
var
  Form1: TForm1;
implementation
{$R *.dfm}
uses Result;
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;
procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;
procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if Edit1.Text <> '' then
    begin
      Edit1.Hide;
      ToggleControls(True);
    end;
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Hide;
  BorderStyle := bsNone;
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;
  ToggleControls(False);
end;
procedure TForm1.Image1Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    Form2.PlayerName := Edit1.Text;
    Form1.Hide;
    Form2.Show;
  end;
end;
procedure TForm1.Image2Click(Sender: TObject);
begin
  Image1.Hide;
  Edit1.Hide;
  Image2.Hide;
  Image3.Hide;
  Image4.Hide;
  Image5.Visible := True;
  Image6.Visible := True;
  Memo1.Visible := True;
end;
procedure TForm1.Image3Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    Form3.PlayerName := Edit1.Text;
    Form1.Hide;
    Form3.Show;
  end;
end;
procedure TForm1.Image6Click(Sender: TObject);
begin
  Image5.Hide;
  Image6.Hide;
  Memo1.Hide;
  Image1.Visible := True;
  Image2.Visible := True;
  Image3.Visible := True;
  Image4.Visible := True;
end;
procedure TForm1.N1Click(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'), PChar('Help.chm'), nil, nil, SW_SHOW);
end;
procedure TForm1.N3Click(Sender: TObject);
begin
  Close;
end;
procedure TForm1.ToggleControls(Enable: Boolean);
begin
  Image1.Enabled := Enable;
  Image2.Enabled := Enable;
  Image3.Enabled := Enable;
end;
end.

