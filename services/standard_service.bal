import ballerina/kafka;
import ballerina/log;

listener kafka:Listener standardListener = new(kafka:DEFAULT_URL, {
    groupId: "standard-service-group",
    topics: ["standard-delivery"]
});

// Define the service that handles incoming messages for standard deliveries
service on standardListener {
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
            string request = message.value.toString();
            log:printInfo("Processing standard delivery request: " + request);
            // Process and confirm the standard delivery
        }
    }
}
