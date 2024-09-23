# Projeto EKS - José

## Contexto

A Kaua Sleep, uma startup de tecnologia inovadora no setor de energia, está em fase de expansão e busca aprimorar a eficiência e qualidade de seus processos de desenvolvimento. Como parte dessa evolução, a empresa pretende implementar uma aplicação web robusta utilizando Kubernetes. Além disso, há a necessidade de integrar serviços de segurança e monitoramento para garantir o bom funcionamento da infraestrutura. Nosso grupo de desenvolvedores foi contratado para liderar este projeto, trazendo as melhores práticas de cloud computing e automação.

## Planejamento do Projeto

O projeto envolve a implementação de diversos serviços essenciais para garantir a escalabilidade, segurança e monitoramento da aplicação web. A seguir estão os componentes planejados:

- **Amazon EKS (Elastic Kubernetes Service)**: Responsável por gerenciar a infraestrutura Kubernetes, permitindo a execução de contêineres de forma escalável e gerenciada.
  
- **Amazon ECR (Elastic Container Registry)**: Armazenamento e gerenciamento das imagens Docker que serão utilizadas no cluster Kubernetes.
  
- **Amazon EBS (Elastic Block Store)**: Fornecerá volumes de armazenamento persistente para os nodes e será integrado ao EKS para armazenar dados da aplicação.

- **Amazon S3 (Simple Storage Service)**: Utilizado para armazenar os arquivos do banco de dados, backups e dados não estruturados da aplicação.

- **Amazon CloudWatch**: Serviço de monitoramento para configurar alarmes de métricas críticas, como utilização de CPU e uso de volumes EBS, garantindo a visibilidade do estado da infraestrutura.

- **AWS Systems Manager (SSM)**: Será utilizado para armazenar e gerenciar de forma segura as credenciais e usuários, além de facilitar a automação de tarefas administrativas.

- **Amazon VPC (Virtual Private Cloud)**: Fornecerá a rede privada para garantir a conectividade segura entre os componentes da aplicação.

- **AWS WAF (Web Application Firewall)**: Implementará um firewall para proteger a aplicação web contra ameaças e ataques, como injeções SQL e ataques DDoS.

## Objetivos

- Configurar e gerenciar uma infraestrutura escalável e segura usando Kubernetes no Amazon EKS.
- Implementar monitoramento contínuo com o CloudWatch para otimizar a performance da aplicação.
- Garantir segurança de dados e acessos através do AWS Systems Manager e do WAF.
- Armazenar e gerenciar imagens Docker no ECR para facilitar o processo de deploy.
- Utilizar o S3 como repositório de arquivos e backups, garantindo alta disponibilidade e durabilidade dos dados.









Abaixo está um exemplo básico de como usar o módulo de VPC. O código define uma VPC com sub-redes públicas e privadas:

```hcl
module "vpc" {
  source = "./modules/vpc"  # Caminho do módulo VPC

  vpc_name   = "my-vpc"
  cidr_block = "10.0.0.0/16"

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true

  tags = {
    Project     = "meu-projeto"
    Environment = "dev"
  }
}

module "security_group" {
  source = "./modules/security_group"  # Caminho do módulo de Security Group

  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Project     = "meu-projeto"
    Environment = "dev"
  }
}
```

### Estrutura de Diretórios
A estrutura de módulos no Terraform é muito importante para organização e reutilização. Aqui está um exemplo de estrutura que você pode seguir para organizar os módulos em seu projeto:

```
.
├── main.tf                 # Arquivo principal do Terraform
├── variables.tf            # Definição de variáveis usadas no projeto
├── outputs.tf              # Outputs do projeto
├── modules/
│   ├── vpc/
│   │   ├── main.tf         # Configuração da VPC
│   │   ├── variables.tf    # Variáveis para o módulo de VPC
│   │   └── outputs.tf      # Outputs do módulo de VPC
│   ├── security_group/
│   │   ├── main.tf         # Configuração dos Security Groups
│   │   ├── variables.tf    # Variáveis para o módulo de Security Group
│   │   └── outputs.tf      # Outputs do módulo de Security Group
│   └── ...                 # Outros módulos como EC2, RDS, S3, etc.
```

### Detalhe dos Módulos

#### Módulo de VPC (`modules/vpc/main.tf`):

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
    for key, value in var.tags : key => value
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
    for key, value in var.tags : key => value
  }
}

# Outros recursos como NAT Gateway, Subnets privadas, Internet Gateway, etc.
```

#### Variáveis para o Módulo de VPC (`modules/vpc/variables.tf`):

```hcl
variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block para a VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "Lista de CIDR blocks para subnets públicas"
}

variable "private_subnets" {
  type        = list(string)
  description = "Lista de CIDR blocks para subnets privadas"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Habilitar ou não o NAT Gateway"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão"
}
```

#### Outputs para o Módulo de VPC (`modules/vpc/outputs.tf`):

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}
```

---

Esse é um exemplo básico para começar a estruturar seus módulos do Terraform. Dependendo do diagrama que você tem em mente e dos componentes AWS que seu projeto precisa, você pode estender essa abordagem para outros serviços, como EC2, RDS, Load Balancers, etc.

Se precisar de mais detalhes ou ajustes em outro módulo, me avise!