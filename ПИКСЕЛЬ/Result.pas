unit Result;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.IOUtils,
  Vcl.Imaging.pngimage;
type
  TForm5 = class(TForm)
    Image1: TImage;
    Image3: TImage;
    ListBox1: TListBox;
    Image6: TImage;
    Image2: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form5: TForm5;
implementation
{$R *.dfm}
uses Main, Sniper;
procedure TForm5.Image1Click(Sender: TObject);
var
  Lines: TStringList;
begin
  Lines := TStringList.Create;
  try
    if TFile.Exists('�������/Arcanoid.txt') then
    begin
      Lines.LoadFromFile('�������/Arcanoid.txt');
      ListBox1.Items.Assign(Lines);
    end;
  finally
    Lines.Free;
  end;
end;
procedure TForm5.Image2Click(Sender: TObject);
begin
  Application.Terminate;
end;
procedure TForm5.Image3Click(Sender: TObject);
var
  Lines1: TStringList;
begin
  Lines1 := TStringList.Create;
  try
    if TFile.Exists('�������/Sniper.txt') then
    begin
      Lines1.LoadFromFile('�������/Sniper.txt');
      ListBox1.Items.Assign(Lines1);
    end;
  finally
    Lines1.Free;
  end;
end;
procedure TForm5.Image6Click(Sender: TObject);
begin
  Form5.Hide;
  Form1.Show;
  Form1.Edit1.Hide;
  Form1.ToggleControls(true);
end;
end.

