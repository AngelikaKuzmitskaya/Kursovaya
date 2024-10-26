program Pixel;



uses
  Vcl.Forms,
  Arcanoid in 'Arcanoid.pas' {Form2},
  Sniper in 'Sniper.pas' {Form3},
  Main in 'Main.pas' {Form1},
  Result in 'Result.pas' {Form5},
  Zastavka in 'Zastavka.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
