import ballerina/http;
import ballerina/log;

service /process on new http:Listener(8082) {
    resource function post shipment(http:Caller caller, http:Request req) returns error? {
        json shipmentData = check req.getJsonPayload();
        log:printInfo("Express delivery service processing: " + shipmentData.toString());

        json response = {status: "confirmed", trackingId: "EX123", estimatedDeliveryTime: "1 day"};
        check caller->respond(response);
    }
}
