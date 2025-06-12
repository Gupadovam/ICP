import Buffer "mo:base/Buffer";
import Text "mo:base/Text";

actor {
  // Buffer para armazenar os nomes das pessoas
  let pessoas = Buffer.Buffer<Text>(0);

  // Adiciona uma nova pessoa ao Buffer
  public func adicionarPessoas(nomePessoa: Text): async () {
    pessoas.add(nomePessoa);
  };

  // Retorna uma lista (Array) com todos os nomes adicionados
  public func listarPessoas(): async [Text] {
    return Buffer.toArray(pessoas);
  };
};
