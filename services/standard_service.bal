import ballerina/http;
import ballerina/log;

service /process on new http:Listener(8081) {
    resource function post shipment(http:Caller caller, http:Request req) returns error? {
        json shipmentData = check req.getJsonPayload();
        log:printInfo("Standard delivery service processing: " + shipmentData.toString());

        json response = {status: "confirmed", trackingId: "ST123", estimatedDeliveryTime: "3 days"};
        check caller->respond(response);
    }
}
