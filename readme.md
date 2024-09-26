# Projeto EKS - José

## Contexto

A **Kaua Sleep**, uma startup de tecnologia inovadora no setor de energia, está em fase de expansão e busca aprimorar a eficiência e qualidade de seus processos de desenvolvimento. Como parte dessa evolução, a empresa pretende implementar uma aplicação web robusta utilizando **Kubernetes**. Além disso, há a necessidade de integrar serviços de segurança e monitoramento para garantir o bom funcionamento da infraestrutura. Nosso grupo de desenvolvedores foi contratado para liderar este projeto, trazendo as melhores práticas de **cloud computing** e automação.

![Diagrama do Projeto](./images/Diagrama_do_projeto.png)

## Planejamento do Projeto

Para garantir uma infraestrutura robusta, escalável e segura, implementaremos os seguintes serviços:

1. **Criação do Cluster Kubernetes**
   - **Amazon EKS (Elastic Kubernetes Service)**: Será utilizado para gerenciar a infraestrutura de contêineres, permitindo a execução eficiente e escalável da aplicação.

2. **Criação do Repositório de Imagens Docker**
   - **Amazon ECR (Elastic Container Registry)**: Armazenará e gerenciará as imagens Docker, facilitando o deploy e a integração contínua com o Kubernetes.

3. **Provisionamento de Armazenamento para os Nodes**
   - **Amazon EBS (Elastic Block Store)**: Fornecerá volumes de armazenamento persistente para os nodes do Kubernetes, garantindo durabilidade e integridade dos dados da aplicação.

4. **Armazenamento de Arquivos e Backups**
   - **Amazon S3 (Simple Storage Service)**: Será utilizado para armazenar arquivos do banco de dados, backups e outros dados não estruturados, garantindo alta disponibilidade e durabilidade.

5. **Configuração de Métricas e Dashboards**
   - **Amazon CloudWatch**: Serviço de monitoramento que será configurado para coletar e visualizar métricas críticas, como a utilização de CPU e o uso de volumes EBS, além de configurar alarmes para acompanhamento proativo.

6. **Gestão Segura de Credenciais**
   - **AWS Systems Manager (SSM)**: Será utilizado para armazenar e gerenciar de forma segura as credenciais e segredos da infraestrutura, além de facilitar a automação de tarefas administrativas.

7. **Garantia de Conectividade Segura**
   - **Amazon VPC (Virtual Private Cloud)**: Fornecerá uma rede privada para garantir a conectividade segura e isolada entre os componentes da aplicação.

8. **Implementação de Segurança com Firewall**
   - **AWS WAF (Web Application Firewall)**: Será utilizado para proteger a aplicação web contra ameaças como injeções SQL, cross-site scripting (XSS) e ataques DDoS.

## Objetivos

- Configurar e gerenciar uma infraestrutura escalável e segura usando **Kubernetes** no **Amazon EKS**.
- Monitorar e otimizar a performance da aplicação usando **Amazon CloudWatch** com alarmes e dashboards personalizados.
- Garantir segurança de dados e acessos com o uso de **AWS Systems Manager** e **AWS WAF**.
- Facilitar o processo de deploy e integração contínua através do **Amazon ECR** para gerenciamento de imagens Docker.
- Utilizar o **Amazon S3** como repositório seguro para arquivos e backups, garantindo alta durabilidade e disponibilidade.