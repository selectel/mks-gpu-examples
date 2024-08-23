# mks-gpu-examples
Данный репозиторий включает в себя примеры использования terraform для деплоя Managed Kubernetes с GPU нодами и с автоскейлингом.
А также примеры настройки GPU нод с помощью GPU-operator

# Подготовка инфраструктуры
## Добавление зеркала terraform
если вы хотите использовать зеркало, создайте отдельный конфигурационный файл ~/.terraformrc и добавьте в него блок:

```
provider_installation {
  network_mirror {
    url = "https://mirror.selectel.ru/3rd-party/terraform-registry/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
Подробнее о настройках зеркал в инструкции [CLI Configuration File](https://developer.hashicorp.com/terraform/cli/config/config-file) документации HashiCorp.


## Создание кластера с помощью terraform

Если вы хотите хранить terraform state в selectel s3, то нужно создать `backend.tfvars` и указать там
```toml
access_key = <s3_access_key>
secret_key = <secret_key>
```

Также создайте `terraform.tfvars` файл, где укажите
```toml
# Данные для провайдера Selectel
# Задаются в личном кабинете my.selectel.ru
selectel_domain_name = 

# Данные для провайдера Openstack
project_id             = 
selectel_user_name     = 
selectel_user_password = 

```

```bash
cd terraform
terraform init -reconfigure -backend-config=backend.tfvars
terraform plan
terraform apply
```

## Подготовка ноды для работы с GPU
Установите prometheus stack и gpu operator с нужными values
```
cd kubernetes
helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack -f prometheus-stack/values.yaml
helm upgrade --install gpu-operator -n gpu-operator --create-namespace nvidia/gpu-operator -f gpu-operator/values.yaml
```

### Включение MIG
Если вы используете ноды с GPU архитектурой Ampere и выше, после установки GPU оператор вы можете включить поддержку MIG
В values gpu operator добавим следующие поля
```yaml
mig:
  strategy: single

migManager:
  enabled: true
  config:
    name: "default-mig-parted-config"
    default: "all-disabled"
```
Далее после установки нового релиза вы можете залейблить ноду, где требуется конфигурация MIG
```bash
kubectl label node <node-name> nvidia.com/mig.config=all-2g.10gb --overwrite
```

# Запуск инференса ChatGPT2 в кластере MKS
## Запуск ChatGPT2 в кластере MKS
Установим инференс с chatpgt2
```bash
kubectl apply -f common
```
Пробросим порт и перейдем в браузере по адресу localhost:8000/docs
```
kubectl port-forward svc/vllm-openai-svc 8000:8000 --address='0.0.0.0'
```
## Как настроить автоскейлинг инференса по кастомным метрикам
Поставим prometheus-adapter с нужной кастомной метрикой
```
helm upgrade --install prometheus-adapter prometheus-community/prometheus-adapter -f vllm/prometheus-adapter.yaml
```
установим vllm с loadbalancer и публичным ip адресом
```bash
kubectl apply -f ha
```
Полезная информация про мониторинг vllm [здесь](https://github.com/vllm-project/vllm/tree/main/examples/production_monitoring)
Заимпортим в grafana [дашборд](kubernetes/vllm/grafana.json)
И подадим нагрузку с помощью [genai perf](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/client/src/c%2B%2B/perf_analyzer/genai-perf/README.html)
```
docker run --net host -it -v /tmp:/workspace nvcr.io/nvidia/tritonserver:24.05-py3-sdk
genai-perf   -m gpt2   --service-kind openai   --endpoint v1/completions   --concurrency 50 --url <loadbalancer_ip>:8000 --endpoint-type completions --num-prompts 100 --random-seed 123 --synthetic-input-tokens-mean 20 --synthetic-input-tokens-stddev 0 --tokenizer hf-internal-testing/llama-tokenizer --measurement-interval 1000 -p 100000
```
Если менять --concurrency от 50 до 100, то при этом average задержка будет варьироваться от 200мс до 400

В файле artifacts/gpt2-openai-completions-concurrency50/llm_inputs.json хранятся сгенерированные промты

