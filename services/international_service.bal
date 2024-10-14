import ballerina/http;
import ballerina/log;

service /process on new http:Listener(8083) {
    resource function post shipment(http:Caller caller, http:Request req) returns error? {
        json shipmentData = check req.getJsonPayload();
        log:printInfo("International delivery service processing: " + shipmentData.toString());

        json response = {status: "confirmed", trackingId: "IN123", estimatedDeliveryTime: "7 days"};
        check caller->respond(response);
    }
}
