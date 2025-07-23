program LoginConsole3vezes;

{$APPTYPE CONSOLE}
{$R *.res}

uses System.SysUtils;

var
  logado: Boolean;

procedure MostrarMenu;
begin
  // Menu
  WriteLn('----------- Menu -----------');
  WriteLn('| 1 - Fazer Login           |');
  WriteLn('| 2 - Cadastrar             |');
  WriteLn('| 9 - Sair                  |');
  WriteLn('----------------------------');
  WriteLn('Digite sua opção de destino:');
end;

procedure MostrarMenuUsuarioLogado;
begin
  // Menu
  WriteLn('----------- Menu -----------');
  WriteLn('| 1 - Adicionar usuário     |');
  WriteLn('|                           |');
  WriteLn('| 9 - Logout                |');
  WriteLn('----------------------------');
  WriteLn('Digite sua opção de destino:');
end;

const
  usuarioAdmin: String = 'Admin';
  senhaAdmin: String = 'Admin';

function LoginValido(usuario, senha: String): Boolean;
begin
  result := false;
  if (usuario = usuarioAdmin) and (senha = senhaAdmin) then
  begin
    logado := true;
    result := true;
  end;
end;

var
  nome, email, senhaCad, senhaConf: String;

procedure CadastroInfo;
begin

  Write('Informe seu nome: ');
  ReadLn(nome);
  Write('Informe seu email: ');
  ReadLn(email);
  Write('Crie uma senha: ');
  ReadLn(senhaCad);
  Write('Confirme a senha: ');
  ReadLn(senhaConf);
end;

function CadastroValido(senhaCad, senhaConf: String): Boolean;
begin
  result := (senhaConf = senhaCad);
end;

// Criar uma funcionalidade de login a partir de dados informados por um usuário.
// - Usuário - Senha
// Funcionalidade: confirmar o acesso

var
  usuario, senha, opcaoDeDestino, nomeLogado, emailLogado: String;
  controle: Boolean;
  i, idade: Integer;

begin
  try
    // Menu

    controle := true;

    while controle do
    begin
      MostrarMenu;
      ReadLn(opcaoDeDestino);
      if (opcaoDeDestino = '9') then
      begin
        WriteLn('Encerrando...');
        Sleep(1500);
        exit;
      end
      else if (opcaoDeDestino = '1') then
      begin
        WriteLn('Digite seu Usuário: ');
        ReadLn(usuario);
        WriteLn('Digite sua senha: ');
        ReadLn(senha);

        if LoginValido(usuario, senha) then
        begin
          WriteLn('Login efetuado com sucesso!');
          controle := false;
        end
        else
        begin
          WriteLn('Credenciais incorretas, tente novamente.');
          Sleep(1500);
          Write(sLineBreak);
          i := i + 1;
          if i > 2 then
          begin
            Write('Número de tentativas permitidas excedido. Encerrando o sistema...');
            Sleep(2000);
            exit;
          end;
        end;
      end
      else if (opcaoDeDestino = '2') then
      begin
        while controle do
        begin
          CadastroInfo;
          if CadastroValido(senhaCad, senhaConf) then
          begin
            WriteLn('Um email de verificação foi enviado para ', email);
            controle := false;
            Break;
          end
          else
          begin
            Write('Senhas não correspondem. Tente novamente.');
            Sleep(1500);
            Write(sLineBreak);
            Write(sLineBreak);
          end;
        end;
      end;
    end;

    while controle do
    begin
      MostrarMenuUsuarioLogado;
      ReadLn(opcaoDeDestino);
      if opcaoDeDestino = '1' then
      begin
        Write('Digite o nome completo do usuário: ');
        ReadLn(nomeLogado);
        Write('Digite a idade do usuário: ');
        ReadLn(idade);
        Write('Digite o e-mail do usuário: ');
        ReadLn(emailLogado);
      end
      else if opcaoDeDestino = '9' then
      begin
        logado := false;
      end
      else
      begin
        WriteLn('Opção inválida');
        Sleep(1000);
      end;
    end;
    ReadLn;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
