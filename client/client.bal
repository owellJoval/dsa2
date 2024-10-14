import ballerina/io;
import ballerina/kafka;
import ballerina/json;

// Define the shipment request record type
type ShipmentRequest record {
    string shipmentType;
    string pickupLocation;
    string deliveryLocation;
    string firstName;
    string lastName;
    string contactNumber;
    string preferredTimeSlot;
    string toLower;
};

// Define Kafka producer configuration
kafka:Producer kafkaProducer = check new({
    bootstrapServers: "localhost:9092"
});

const string LOGISTICS_TOPIC = "logistics_requests";

public function main() returns error? {
    // Get user input for shipment details
    ShipmentRequest request = getUserShipmentDetails();

    // Convert the shipment request to JSON
    json shipmentRequestJson = check json.convert(request);
    kafka:ProducerRecord record = {
        value: shipmentRequestJson.toString()
    };

    // Send the request to the Kafka topic
    check kafkaProducer->send({
        topic: LOGISTICS_TOPIC,
        value: shipmentRequestJson.toString()
    });

    io:println("Shipment request sent successfully.");
}

// Function to capture user input for shipment details
function getUserShipmentDetails() returns ShipmentRequest {
    string shipmentType = getValidShipmentType();
    
    io:println("Enter pickup location:");
    string pickupLocation = io:readln().trim();

    io:println("Enter delivery location:");
    string deliveryLocation = io:readln().trim();

    io:println("Enter first name:");
    string firstName = io:readln().trim();

    io:println("Enter last name:");
    string lastName = io:readln().trim();

    io:println("Enter contact number:");
    string contactNumber = io:readln().trim();

    io:println("Enter preferred time slot (e.g., 9 AM - 11 AM):");
    string preferredTimeSlot = io:readln().trim();

    return {
        shipmentType: shipmentType,
        pickupLocation: pickupLocation,
        deliveryLocation: deliveryLocation,
        firstName: firstName,
        lastName: lastName,
        contactNumber: contactNumber,
        preferredTimeSlot: preferredTimeSlot
    ,toLower: ""};
}

// Function to validate shipment type
function getValidShipmentType() returns string {
    while (true) {
        io:println("Enter shipment type (standard/express/international):");
        string shipmentType = io:readln().trim().toLower();

        if (shipmentType == "standard" || shipmentType == "express" || shipmentType == "international") {
            return shipmentType;
        } else {
            io:println("Invalid shipment type! Please enter 'standard', 'express', or 'international'.");
        }
    }
}

//kafka:Producer kafkaProducer = check new({
 ///   bootstrapServers: "localhost:9092",
  //  clientId: "logistics_client"
//});

//public function main() returns error? {
   // ShipmentRequest shipment = {
    //    shipmentType: "express",
   //     pickupLocation: "123 Main St",
   //     deliveryLocation: "456 Elm St",
  //      firstName: "John",
  //      lastName: "Doe",
  //      contactNumber: "555-1234",
  //      preferredTimeSlot: "09:00-12:00"
  //  };
//
  //  json shipmentJson = shipment.toJson();
   // kafka:ProducerRecord record = {value: shipmentJson};

  //  check kafkaProducer->send(record, topic = "logistics_requests");
   // log:printInfo("Shipment request sent!");
//}

//kafka:Producer kafkaProducer = check new({
 //   bootstrapServers: "localhost:9092",
   // clientId: "logistics_client"
//});

p//ublic function main() returns error? {
  //  ShipmentRequest shipment = {
     //   shipmentType: "express",
  //      pickupLocation: "123 Main St",
    //    deliveryLocation: "456 Elm St",
      //  firstName: "John",
     //   lastName: "Doe",
     //   contactNumber: "555-1234",
     //   preferredTimeSlot: "09:00-12:00"
   // };

   // json shipmentJson = shipment.toJson();
   // kafka:ProducerRecord record = {value: shipmentJson};

   // check kafkaProducer->send(record, topic = "logistics_requests");
   // log:printInfo("Shipment request sent!");
//}
