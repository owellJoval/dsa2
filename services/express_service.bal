import ballerina/kafka;
import ballerina/log;

listener kafka:Listener expressListener = new(kafka:DEFAULT_URL, {
    groupId: "express-service-group",
    topics: ["express-delivery"]
});

service on expressListener {
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
            string request = message.value.toString();
            log:printInfo("Processing express delivery request: " + request);
            // Process and confirm express delivery
        }
    }
}
