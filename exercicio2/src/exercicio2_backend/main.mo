import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Text "mo:base/Text";

actor {

  // Declaração de variáveis
  var numero1 : Nat = 10;
  var numero2 : Int = 20;
  var mensagem : Text = "Meu primeiro Dapp";

  // Função que soma dois números naturais
  public func somar(a : Nat, b : Nat) : async Nat {
    return a + b;
  };

  // Função que subtrai dois números naturais
  // Retorna 0 se o segundo número for maior (pois Nat não aceita negativos)
  public func subtrair(a : Nat, b : Nat) : async Nat {
    if (a < b) {
      return 0;
    };
    return a - b;
  };

  // Função que multiplica dois números naturais
  public func multiplicar(a : Nat, b : Nat) : async Nat {
    return a * b;
  };
};
