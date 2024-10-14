import ballerina/kafka;
import ballerina/log;
import ballerina/io;

listener kafka:Listener kafkaListener = new(kafka:DEFAULT_URL, {
    groupId: "logistics-service-group",
    topics: ["logistics-topic"]
});

service on kafkaListener {
    remote function onMessage(kafka:ConsumerMessage[] messages) returns error? {
        foreach var message in messages {
            string request = message.value.toString();
            log:printInfo("Received logistics request: " + request);
            // Process request and delegate to appropriate service
            // Assuming the message has a shipment type
            if (request.includes("standard")) {
                check kafka:produce("standard-delivery", request);
            } else if (request.includes("express")) {
                check kafka:produce("express-delivery", request);
            } else if (request.includes("international")) {
                check kafka:produce("international-delivery", request);
            }
        }
    }
//end
}
