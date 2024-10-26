unit Zastavka;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls;
type
  TForm4 = class(TForm)
    Image4: TImage;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ProgressValue: Double;
    TargetValue: Integer;
    RandomTexts: array of string;
  public
    { Public declarations }
  end;
var
  Form4: TForm4;
implementation
{$R *.dfm}
procedure TForm4.FormCreate(Sender: TObject);
begin
  ProgressValue := 0;
  ProgressBar1.Position := 0;
  TargetValue := 100;
  SetLength(RandomTexts, 5);
  RandomTexts[0] := '���������';
  RandomTexts[1] := '������ �������� �� ��������� ������';
  RandomTexts[2] := '����� �������?';
  RandomTexts[3] := '����������� � "�������"';
  RandomTexts[4] := '���-��';
  Label1.Caption := RandomTexts[Random(Length(RandomTexts))];
  Label1.Alignment := taCenter;
end;
procedure TForm4.Timer1Timer(Sender: TObject);
begin
  if ProgressValue < TargetValue then
  begin
    ProgressValue := ProgressValue + 10;
    ProgressBar1.Position := Round(ProgressValue);
    Label1.Caption := RandomTexts[Random(Length(RandomTexts))];
  end
  else
  begin
    Timer1.Enabled := False;
    Close;
  end;
end;
end.
