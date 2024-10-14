import ballerina/kafka;
import ballerina/log;

listener kafka:Listener internationalListener = new(kafka:DEFAULT_URL, {
    groupId: "international-service-group",
    topics: ["international-delivery"]
});

service on internationalListener {
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
            string request = message.value.toString();
            log:printInfo("Processing international delivery request: " + request);
            // Process and confirm international delivery
        }
    }
//end
}
