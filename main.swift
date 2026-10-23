import Foundation


func buscarNome(_ nome: String, em pessoas: [String: [String]]) -> String? {
    return pessoas.keys.first {
        $0.lowercased() == nome.lowercased()
    }
}

func lerTexto(_ mensagem: String) -> String {
    while true {
        print(mensagem, terminator: "")
        let texto = (readLine() ?? "").trimmingCharacters(in: .whitespaces)

        if !texto.isEmpty {
            return texto
        }

        print("O campo não pode ficar vazio.")
    }
}

func lerDados() -> [String] {
    let email = lerTexto("Digite o email da pessoa: ")
    let telefone = lerTexto("Digite o telefone da pessoa: ")
    let idade = lerTexto("Digite a idade da pessoa: ")

    return [email, telefone, idade]
}


func incluirPessoa(_ pessoas: inout [String: [String]]) {
    let nome = lerTexto("Digite o nome da pessoa: ")

    if buscarNome(nome, em: pessoas) != nil {
        print("Já existe uma pessoa com esse nome.")
        return
    }

    let dados = lerDados()
    pessoas[nome] = dados

    print("Pessoa adicionada com sucesso!")
}


func alterarPessoa(_ pessoas: inout [String: [String]]) {
    let nome = lerTexto("Digite o nome da pessoa que deseja alterar: ")

    guard let nomeAntigo = buscarNome(nome, em: pessoas) else {
        print("Pessoa não encontrada!")
        return
    }

    print("Digite os novos dados da pessoa.")
    let novoNome = lerTexto("Digite o novo nome da pessoa: ")

    if let nomeExistente = buscarNome(novoNome, em: pessoas),
       nomeExistente != nomeAntigo {
        print("Já existe outra pessoa com esse nome!")
        return
    }

    let novosDados = lerDados()

    pessoas.removeValue(forKey: nomeAntigo)
    pessoas[novoNome] = novosDados

    print("Dados alterados com sucesso!")
}


func apagarPessoa(_ pessoas: inout [String: [String]]) {
    let nome = lerTexto("Digite o nome da pessoa que deseja apagar: ")

    guard let nomeEncontrado = buscarNome(nome, em: pessoas) else {
        print("Pessoa não encontrada!")
        return
    }

    pessoas.removeValue(forKey: nomeEncontrado)

    print("Pessoa apagada com sucesso!")
}


func exibirPessoa(_ pessoas: [String: [String]]) {
    let nome = lerTexto("Digite o nome da pessoa que deseja exibir: ")

    guard let nomeEncontrado = buscarNome(nome, em: pessoas),
          let dados = pessoas[nomeEncontrado] else {
        print("Pessoa nao encontrada!")
        return
    }

    print("\nDados de \(nomeEncontrado):")
    print("Email: \(dados[0])")
    print("Telefone: \(dados[1])")
    print("Idade: \(dados[2])")
}


func exibirTodasPessoas(_ pessoas: [String: [String]]) {
    if pessoas.isEmpty {
        print("Nenhuma pessoa cadastrada.")
        return
    }

    print("\nDados de todas as pessoas cadastradas:\n")

    for nome in pessoas.keys.sorted() {
        if let dados = pessoas[nome] {
            print("Nome: \(nome)")
            print("Email: \(dados[0])")
            print("Telefone: \(dados[1])")
            print("Idade: \(dados[2])")
            print("")
        }
    }
}


var pessoas: [String: [String]] = [:]

while true {
    print("""

    Escolha uma opção:

    1. Incluir dados de uma pessoa

    2. Alterar dados de uma pessoa

    3. Apagar dados de uma pessoa

    4. Exibir dados de uma pessoa

    5. Exibir dados de todas as pessoas

    6. Finalizar o programa

    """)

    guard let opcao = readLine() else {
        break
    }

    switch opcao {
    case "1":
        incluirPessoa(&pessoas)

    case "2":
        alterarPessoa(&pessoas)

    case "3":
        apagarPessoa(&pessoas)

    case "4":
        exibirPessoa(pessoas)

    case "5":
        exibirTodasPessoas(pessoas)

    case "6":
        print("Programa finalizado.")
        break

    default:
        print("Opcao invalida! Escolha de 1 a 6.")
    }

    if opcao == "6" {
        break
    }
}
