import ballerina/kafka;
import ballerina/io;
import ballerina/log;

kafka:Producer logisticsProducer = new(kafka:DEFAULT_URL);

public function main() returns error? {
    // Get shipment type from user//
    io:println("Select shipment type:");
    io:println("1. Standard Delivery");
    io:println("2. Express Delivery");
    io:println("3. International Delivery");

    string shipmentType = io:readln();
    string selectedType = getShipmentType(shipmentType);

    if selectedType == "Invalid" {
        io:println("Invalid shipment type selected. Exiting...");
        return;
    }

    // Get pickup and delivery locations
    io:println("Enter pickup location:");
    string pickupLocation = io:readln();
    io:println("Enter delivery location:");
    string deliveryLocation = io:readln();

    // Get customer details
    io:println("Enter customer's first name:");
    string firstName = io:readln();
    io:println("Enter customer's last name:");
    string lastName = io:readln();
    io:println("Enter customer's contact number:");
    string contactNumber = io:readln();

    // Get preferred time slot
    io:println("Enter preferred pickup time slot (e.g., 10:00 - 12:00):");
    string timeSlot = io:readln();

    // Construct the request message
    string request = string `{"shipmentType": "${selectedType}", "pickupLocation": "${pickupLocation}", 
                              "deliveryLocation": "${deliveryLocation}", "customer": {"firstName": "${firstName}", 
                              "lastName": "${lastName}", "contact": "${contactNumber}"}, 
                              "timeSlot": "${timeSlot}"}`;

    log:printInfo("Sending logistics request: " + request);

    // Send the request to Kafka topic
    check logisticsProducer->send({
        topic: "logistics-topic",
        value: request
    });
    
    io:println("Logistics request for " + selectedType + " sent successfully!");
}

// Helper function to get the shipment type
function getShipmentType(string choice) returns string {
    if choice == "1" {
        return "standard";
    } else if choice == "2" {
        return "express";
    } else if choice == "3" {
        return "international";
    } else {
        return "Invalid";
    }
}
