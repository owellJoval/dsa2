import ballerina/kafka;
import ballerina/http;
import ballerina/log;
import ballerina/mongo;
import ballerina/time;
import ballerina/jsonutils; // Needed to convert between JSON and records

type ShipmentRequest record {
    string shipmentType;
    string pickupLocation;
    string deliveryLocation;
    string firstName;
    string lastName;
    string contactNumber;
    string preferredTimeSlot;
};

type ShipmentResponse record {
    string status;
    string trackingId;
    string estimatedDeliveryTime;
};

// Kafka consumer to listen to requests
listener kafka:Consumer kafkaConsumer = new({
    bootstrapServers: "localhost:9092",
    groupId: "logistics_group",
    topics: ["logistics_requests"],
    pollingInterval: 1000
});

// MongoDB client to store customer data
mongo:Client dbClient = check new("mongodb://localhost:27017", "logistics_db");

// HTTP clients for specialized services
http:Client standardServiceClient = check new("http://localhost:8081");
http:Client expressServiceClient = check new("http://localhost:8082");
http:Client internationalServiceClient = check new("http://localhost:8083");

service on kafkaConsumer {
    // Remote method to process Kafka consumer records
    remote function onConsumerRecord(kafka:ConsumerRecord[] records) returns error? {
        foreach kafka:ConsumerRecord record in records {
            // Convert Kafka record value from JSON to ShipmentRequest
            ShipmentRequest request = check jsonutils:fromJSON(record.value, ShipmentRequest);

            // Depending on the shipment type, call the appropriate service
            string response;
            if request.shipmentType == "standard" {
                response = check standardServiceClient->post("/process", request);
            } else if request.shipmentType == "express" {
                response = check expressServiceClient->post("/process", request);
            } else if request.shipmentType == "international" {
                response = check internationalServiceClient->post("/process", request);
            }

            // Convert the response from JSON to ShipmentResponse
            ShipmentResponse shipmentResponse = check jsonutils:fromJSON(response, ShipmentResponse);
            log:printInfo("Shipment processed: " + shipmentResponse.toString());

            // Store shipment information in MongoDB (optional)
            check dbClient->insert("shipments", shipmentResponse);
        }
    }
}
