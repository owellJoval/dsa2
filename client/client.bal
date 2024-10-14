import ballerina/kafka;
import ballerina/io;
import ballerina/log;

// Create a Kafka producer instance for sending logistics requests
kafka:Producer logisticsProducer = new(kafka:DEFAULT_URL);

public function main() returns error? {
    // Get shipment type from user//
    io:println("Select shipment type:");
    io:println("1. Standard Delivery");
    io:println("2. Express Delivery");
    io:println("3. International Delivery");


// Capture user input for shipment type
    string shipmentType = io:readln();

// Determine the selected shipment type based on user input
    string selectedType = getShipmentType(shipmentType);

//If the user provides invalid input, display an error message and terminate the program
    if selectedType == "Invalid" {
        io:println("Invalid shipment type selected. Exiting...");
        return;
    }

    // Prompt the user to enter the pickup location
    io:println("Enter pickup location:");
    string pickupLocation = io:readln();
    io:println("Enter delivery location:");
    string deliveryLocation = io:readln();

    // Collect customer's first name from the user
    io:println("Enter customer's first name:");
    string firstName = io:readln();
    // Collect customer's last name from the user
    io:println("Enter customer's last name:");
    string lastName = io:readln();
    // Collect customer's contact number from the user
    io:println("Enter customer's contact number:");
    string contactNumber = io:readln();

    // Prompt the user to enter the preferred pickup time slot
    io:println("Enter preferred pickup time slot (e.g., 10:00 - 12:00):");
    string timeSlot = io:readln();

    // Construct the request message
    string request = string `{"shipmentType": "${selectedType}", "pickupLocation": "${pickupLocation}", 
                              "deliveryLocation": "${deliveryLocation}", "customer": {"firstName": "${firstName}", 
                              "lastName": "${lastName}", "contact": "${contactNumber}"}, 
                              "timeSlot": "${timeSlot}"}`;
    // Log the request details before sending
    log:printInfo("Sending logistics request: " + request);

    // Send the request to Kafka topic
    check logisticsProducer->send({
        topic: "logistics-topic",
        value: request
    });

    // Confirm successful submission of the logistics request to the user
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
//end
}
