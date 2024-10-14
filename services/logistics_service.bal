import ballerina/kafka;
import ballerina/log;
import ballerina/io;

// Initialize a Kafka listener to consume messages from the "logistics-topic" topic
listener kafka:Listener kafkaListener = new(kafka:DEFAULT_URL, {
    groupId: "logistics-service-group",
    topics: ["logistics-topic"]
});

// Define the service to handle and process logistics messages
service on kafkaListener {
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
            string request = message.value.toString();
            log:printInfo("Received logistics request: " + request);
            // Process request and delegate to appropriate service
            // Assuming the message has a shipment type
            if (request.includes("standard")) {
                check kafka:produce("standard-delivery", request);
            // Route to the express delivery service
            } else if (request.includes("express")) {
                check kafka:produce("express-delivery", request);
            // Route to the express delivery service
            } else if (request.includes("international")) {
                check kafka:produce("international-delivery", request);
            }
        }
    }
//end
}
