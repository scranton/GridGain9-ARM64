# Building GridGain 9 ARM64 docker image and Running Getting Started

Assumptions

- Building against GridGain 9.0.5
- All files are in same directory
- Have Trial license. Request Trial License [here](https://www.gridgain.com/tryfree#modal-key-form)

GridGain 9 Getting Started guide located [here](https://www.gridgain.com/docs/gridgain9/latest/quick-start/getting-started-guide)

## Download GridGain DB and CLI bundles

Download GridGain 9.0.5 both

- Database Platform (DB)
- Command Line interface (CLI)

Unzip both downloads

## Build Docker image

```shell
docker build . --tag gridgain/gridgain9:9.0.5-arm64
```

## Run

```shell
docker compose --file docker-compose.yml up --detach
```

## Interact the GridGain

### Start GridGain 9 CLI Interactive Mode

```shell
gridgain9-cli-9.0.5/bin/gridgain9
```

You should see a prompt acking to connect to `http://localhost:10300`. Enter `Y`

You'll then see the CLI Interactive Mode prompt similar to this `[node1]>`

### Initalize the Cluster

You only need to do this once

```shell
cluster init --name=sampleCluster --metastorage-group=defaultNode --config-files=license.conf
```

### Create an example table using SQL

```shell
sql "CREATE TABLE IF NOT EXISTS Person (id int primary key,  city varchar,  name varchar,  age int,  company varchar)"
```

### Populate example table with sample data

```shell
sql "INSERT INTO Person (id, city, name, age, company) VALUES ('1', 'London', 'John Doe', '42', 'Apache')"
sql "INSERT INTO Person (id, city, name, age, company) VALUES ('2', 'New York', 'Jane Doe', '36', 'Apache')"
```

### Query data

```shell
sql "SELECT * FROM Person"
```

## Cleanup

Shutdown the cluster

```shell
docker compose --file docker-compose.yml down
```
