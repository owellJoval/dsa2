import ballerina/kafka;
import ballerina/log;


// Define a Kafka listener to subscribe to the "express-delivery" topic
listener kafka:Listener expressListener = new(kafka:DEFAULT_URL, {
    groupId: "express-service-group",
    topics: ["express-delivery"]
});

// Define the service that listens for Kafka messages
service on expressListener {
// Remote function that gets triggered when messages are received from Kafka
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
// Convert the message value to a string
            string request = message.value.toString();
// Log the received express delivery request
            log:printInfo("Processing express delivery request: " + request);
            // Process and confirm express delivery
        }
    }
}
