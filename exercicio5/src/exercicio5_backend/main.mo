import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";


actor {

    public shared(message) func get_principal_client() : async Text {
      return "Principal: " # Principal.toText(message.caller) # "!";
    };

    type Tarefa = {    
                  id: Nat;          // Identificador único da tarefa
                  categoria: Text;  // Categoria da tarefa   
                  descricao: Text;  // Descrição detalhada da tarefa   
                  urgente: Bool;    // Indica se a tarefa é urgente (true) ou não (false) 
                  concluida: Bool;  // Indica se a tarefa foi concluída (true) ou não (false)   
    };

    /* Esta variável será utilizada para armazenar o número do último identificador gerado para uma tarefa. 
      Ela será incrementada sempre que uma nova tarefa for adicionada */
    var idTarefa : Nat = 0;

    // Esta estrutura será utilizada para armazenar as "tarefas"  
    var tarefas : Buffer.Buffer<Tarefa> = Buffer.Buffer<Tarefa>(10);

    // Função para adicionar itens ao buffer 'tarefas'.
    public func addTarefa(desc: Text, cat: Text, urg: Bool, con: Bool) : async () {

        idTarefa += 1;
        let t : Tarefa = {  id = idTarefa;
                            categoria = cat;    
                            descricao = desc;                          
                            urgente = urg;                   
                            concluida = con;                   
                          };

        tarefas.add(t);
    };

    // Função para remover itens ao buffer 'tarefas'.
    public func excluirTarefa(idExcluir: Nat) : async () {

      func localizaExcluir(i: Nat, x: Tarefa) : Bool {
        return x.id != idExcluir;
      };

      tarefas.filterEntries(localizaExcluir); 

    };

    // Função para alterar itens ao buffer 'tarefas'.
    public func alterarTarefa(idTar: Nat, 
                            cat: Text,
                            desc: Text,                             
                            urg: Bool, 
                            con: Bool) : async () {

      let t : Tarefa = {  id = idTar;
                          categoria = cat;    
                          descricao = desc;                        
                          urgente = urg;                      
                          concluida = con;
                      };

      func localizaIndex (x: Tarefa, y: Tarefa) : Bool {
        return x.id == y.id;
      };

      let index : ?Nat = Buffer.indexOf(t, tarefas, localizaIndex);

      switch(index){
        case(null) {
          // não foi localizado um index
        };
        case(?i){
          tarefas.put(i,t);
        }
      };

    };

    // Função para retornar os itens do buffer 'tarefas'.
    public func getTarefas() : async [Tarefa] {
      return Buffer.toArray(tarefas);
    };

     // --- INÍCIO DAS NOVAS FUNÇÕES ---

    /**
     * @notice Retorna a quantidade de tarefas que possuem o atributo `concluida` definido como `false`.
     * @return Retorna um número natural (Nat) com o total de tarefas em andamento.
     */
    public query func totalTarefasEmAndamento() : async Nat {
      var contador : Nat = 0;
      for (tarefa in tarefas.vals()) {
        if (not tarefa.concluida) {
          contador += 1;
        };
      };
      return contador;
    };

    /**
     * @notice Retorna a quantidade de tarefas que possuem o atributo `concluida` definido como `true`.
     * @return Retorna um número natural (Nat) com o total de tarefas concluídas.
     */
    public query func totalTarefasConcluidas() : async Nat {
      var contador : Nat = 0;
      for (tarefa in tarefas.vals()) {
        if (tarefa.concluida) {
          contador += 1;
        };
      };
      return contador;
    };

    // --- FIM DAS NOVAS FUNÇÕES ---
};