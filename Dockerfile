FROM python:3.11.3
WORKDIR /app
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir -p ./google/bert-base-local-results
RUN wget -O ./google/bert-base-local-results/pytorch_model.bin https://cdn.huggingface.co/serpapi/bert-base-local-results/pytorch_model.bin
RUN wget -O ./google/bert-base-local-results/config.json https://cdn.huggingface.co/serpapi/bert-base-local-results/config.json
COPY ./google/bert-base-local-results/.gitkeep ./google/bert-base-local-results/
COPY . .
CMD ["gunicorn", "main:app", "--workers", "1", "--worker-class", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0"]
