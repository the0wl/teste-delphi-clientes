# teste-delphi-clientes

## Definição

**1. Criar uma tela para consulta dos clientes permitindo:**  
**a)** *Filtrar por nome e/ou somente ativos.*   
**b)** *Incluir, alterar e excluir.*   

**2. Criar um cadastro de clientes contendo:**   
**a)** *nome, obrigatório;*    
**b)** *tipo (pessoa física ou jurídica), obrigatório;*   
**c)** *CPF (se pessoa física) ou CNPJ (se pessoa jurídica), obrigatório;*     
**d)** *RG (se pessoa física) ou IE (se pessoa jurídica);*    
**e)** *Data de Cadastro;*    
**f)** *Ativo (se está ativo);*          
**g)** *Telefone, contendo ddd e número, permitir adicionar mais do que um e remover os adicionados. (Mestre Detalhe)*   
**h)** *Endereço, contendo logradouro, número, CEP (Via CEP Rest), Bairro, Cidade, estado, país. (Mestre Detalhe)*    
**i)** *Ao gravar validar se já existe um cliente cadastrado com o CPF/CNPJ informado.*    

## Considerações

Utilizei estas considerações para me guiar em pontos que achei vagos ou que não consegui interpretar.

- Haverá somente um endereço.
- Não há restrição no quantidade ou formato de telas.
- Não especifica como deve ser a validação do CPF (fiz no banco de dados).

## Setup

Caso deseje alterar o banco de dados ou alterá-lo de local, deve ser alterado também na view `frmDataset` no componente `conDatabase`. 

Além disso, deve-se garantir a propriedade `Active` como `True` nos componentes `conDatabase`, `tbClients`, `tbPhones` e `tbAddresses`.

## Executável

O executável se encontra na pasta `Win32\Realease\` com o nome `TesteDelphi.exe`.

É necessário copiar a pasta `BANCO DE DADOS` para o diretório raiz `C:`. Sendo assim, deve existir uma pasta `c:\\BANCO DE DADOS\`.
