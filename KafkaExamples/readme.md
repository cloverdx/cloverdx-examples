# Apache Kafka examples

This project is a demo of Apache Kafka components. It showcases the following:

* How to produce and consume massages to / from Kafka topics.
* How to create a [Kafka Message Listener](https://doc.cloverdx.com/latest/operations/listeners.html#id_kafka_msg_listeners) in CloverDX Server.
* How a CloverDX graph can be triggered by a Kafka Message Listener.

The project contains two set of resources:
* **Initialization resources** (init folder)
	- _compose.yml_ - docker compose with two services used by below mentioned CloverDX graphs.
	- _CreateDbTable.grf_ - a graph that will create a DB table used by the KafkaConsumer graph.
* **Kafka related resources**
	- _KafkaProducer.grf_ - A job that reads customer details from a flat file, converts them to JSON messages and produce them to a Kafka topic. 
	- _KafkaConsumer.grf_ - A consumer job that consumes messages from a Kafka Topic, parses them and writes data into a DB table. The messages are only committed after the data is written into the DB table.
	- _kafka-event-listener-export.xml_ - An exported Kafka Message Listener configuration that is linked to KafkaConsumer graph. The graph is executed upon arrival of a new message.

## Dependencies
The example graphs use externalized connections (_conn_ directory) to a Kafka broker and PostgreSQL DB. Both services can be deployed using attached docker compose file in _init_ folder. If another instances are used, the connections must be updated to match your services. Default addresses are:
* **Kafka broker** - localhost:19092
* **PostgreSQL DB** - localhost:15432

## Installation

1. Deploy the whole project into your CloverDX Server.
2. Ensure the dependencies are deployed and available to CloverDX Server - you can 'test' connections from the CloverDX Designer to check port availability.
3. Import Kafka message listener from kafka-event-listener-export.xml via CloverDX Server console (Configuration > Import).

## Usage and licensing

Feel free to reuse or fork this project in your own CloverDX solutions.

Note that the code in this repository is provided on an **"as is" basis, without
warranties or conditions of any kind, either express or implied, including,
without limitation, any warranties or conditions of title, non-infringement,
merchantability, or fitness for a particular purpose.**  

Unless otherwise specified, the code in this repository is licensed under
[Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

## Contributing

We welcome your feedback and contributions. You can:
- Submit comments or pull requests here on GitHub.

- Reach out to us through [cloverdx.com](https://www.cloverdx.com).

