import ballerina/kafka;
import ballerina/log;

// Initialize a Kafka listener to consume messages from the "international-delivery" topic
listener kafka:Listener internationalListener = new(kafka:DEFAULT_URL, {
    groupId: "international-service-group",
    topics: ["international-delivery"]
});

// Define the service that processes incoming Kafka messages
service on internationalListener {

// This remote function is triggered whenever messages are received from the topic
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
// Loop through each received message
        foreach var message in messages {
// Convert the message payload to a string
            string request = message.value.toString();
            log:printInfo("Processing international delivery request: " + request);
            // Process and confirm international delivery
        }
    }
//end
}
