unit Sniper;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.MPlayer;
type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TimeTimer: TTimer;
    ShootTimer: TTimer;
    BirdImage: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image6: TImage;
    Sleep: TTimer;
    fon: TImage;
    music: TImage;
    Background: TImage;
    MediaPlayer1: TMediaPlayer;
    OpenDialog1: TOpenDialog;
    procedure TimeTimerTimer(Sender: TObject);
    procedure ShootTimerTimer(Sender: TObject);
    procedure BirdImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure SleepTimer(Sender: TObject);
    procedure fonClick(Sender: TObject);
    procedure musicClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure SafeSN;
    procedure RestartGame;
  private
    t: Integer;
    fx, fy: Integer;
    n, p: Integer;
    RunGame: Boolean;
    TimeForShoot: Integer;
    Level: Integer;
  public
    RecordFileName: string;
    RecordFile: TextFile;
    PlayerName: string;
  end;
var
  Form3: TForm3;
implementation
{$R *.dfm}
uses
  Result, Main;
procedure TForm3.SafeSN;
begin
  RecordFileName := ExtractFilePath(Application.ExeName) + '�������/Sniper.txt';
  AssignFile(RecordFile, RecordFileName);
  if FileExists(RecordFileName) then
    Append(RecordFile)
  else
    Rewrite(RecordFile);
  Writeln(RecordFile, PlayerName + '      |' + Label5.Caption);
  CloseFile(RecordFile);
end;
procedure TForm3.fonClick(Sender: TObject);
begin
  TimeTimer.Enabled := False;
  ShootTimer.Enabled := False;
  if OpenDialog1.Execute then
  begin
    Background.Picture.LoadFromFile(OpenDialog1.FileName);
    TimeTimer.Enabled := True;
    ShootTimer.Enabled := True;
  end;
end;
procedure TForm3.FormCreate(Sender: TObject);
begin
  RestartGame;
end;
procedure TForm3.Image3Click(Sender: TObject);
begin
  if Level = 1 then
  begin
    n := 50;
    p := 0;
    t := 90;
    TimeForShoot := 850;
    RunGame := True;
    TimeTimer.Enabled := True;
    ShootTimer.Enabled := True;
    Label1.Caption := '������� 2';
    Label2.Caption := '���� 50/';
    Label3.Caption := '0';
    Image1.Visible := False;
    Image3.Visible := False;
    Image4.Visible := False;
    Inc(Level);
  end
  else if Level = 2 then
  begin
    n := 70;
    p := 0;
    t := 60;
    TimeForShoot := 700;
    Label1.Caption := '������� 3';
    Label2.Caption := '���� 70/';
    Label3.Caption := '0';
    RunGame := True;
    TimeTimer.Enabled := True;
    ShootTimer.Enabled := True;
    Image1.Visible := False;
    Image3.Visible := False;
    Image4.Visible := False;
    Inc(Level);
  end;
end;
procedure TForm3.Image4Click(Sender: TObject);
begin
  SafeSN;
  Hide;
  Form5.Show;
  RestartGame;
end;
procedure TForm3.musicClick(Sender: TObject);
begin
  TimeTimer.Enabled := False;
  ShootTimer.Enabled := False;
  if OpenDialog1.Execute then
  begin
    MediaPlayer1.FileName := OpenDialog1.FileName;
    MediaPlayer1.Open;
    MediaPlayer1.Play;
    TimeTimer.Enabled := True;
    ShootTimer.Enabled := True;
  end;
end;
procedure TForm3.TimeTimerTimer(Sender: TObject);
begin
  if (t > 0) and RunGame then
  begin
    t := t - 1;
    Label7.Caption := IntToStr(t);
    if t = 0 then
    begin
      RunGame := False;
      TimeTimer.Enabled := False;
      ShootTimer.Enabled := False;
      Image2.Visible := True;
      Image4.Visible := True;
    end;
  end;
end;
procedure TForm3.ShootTimerTimer(Sender: TObject);
begin
  if RunGame then
  begin
    ShootTimer.Interval := TimeForShoot;
    fx := Random(1400);
    fy := Random(600);
    BirdImage.Left := fx;
    BirdImage.Top := fy;
  end;
end;
procedure TForm3.SleepTimer(Sender: TObject);
begin
  Image6.Visible := False;
  Sleep.Enabled := False;
end;
procedure TForm3.BirdImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if RunGame then
  begin
    p := p + 1;
    Label3.Caption := IntToStr(p);
    Label5.Caption := IntToStr(StrToInt(Label5.Caption) + 50);
    Image6.Left := BirdImage.Left;
    Image6.Top := BirdImage.Top;
    Image6.Visible := True;
    Sleep.Enabled := True;
    if (Level = 1) and (p = 30) then
    begin
      Image1.Visible := True;
      Image4.Visible := True;
      Image3.Visible := True;
      TimeTimer.Enabled := False;
      ShootTimer.Enabled := False;
      RunGame := False;
    end
    else if (Level = 2) and (p = 50) then
    begin
      Image1.Visible := True;
      Image4.Visible := True;
      Image3.Visible := True;
      TimeTimer.Enabled := False;
      ShootTimer.Enabled := False;
      RunGame := False;
    end
    else if (Level = 3) and (p = 70) then
    begin
      Image1.Visible := True;
      Image4.Visible := True;
      Image3.Visible := False;
      TimeTimer.Enabled := False;
      ShootTimer.Enabled := False;
      RunGame := False;
    end;
  end;
end;
procedure TForm3.RestartGame;
begin
  Level := 1;
  t := 100;
  n := 0;
  p := 0;
  RunGame := True;
  TimeForShoot := 1000;
  Label1.Caption := '������� 1';
  Label2.Caption := '���� 30/';
  Label3.Caption := '0';
  Label5.Caption := '0';
  Label7.Caption := IntToStr(t);
  Image1.Visible := False;
  Image2.Visible := False;
  Image3.Visible := False;
  Image4.Visible := False;
  TimeTimer.Enabled := True;
  ShootTimer.Enabled := True;
end;
end.

