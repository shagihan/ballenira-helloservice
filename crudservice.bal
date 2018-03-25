import ballerina.net.http;
import ballerina.data.sql;

@http:configuration {
    basePath:"/demo"
}
service<http> DemoBallerinaService {

    @http:resourceConfig {
        path:"/list"
    }
    resource getGuestList(http:Connection connection, http:InRequest request) {
        endpoint<sql:ClientConnector> demoDb {
            create sql:ClientConnector(sql:DB.MYSQL, "localhost", 3306, "ballerina_demo", "root", "1234", {maximumPoolSize:5});
        }
        table result = demoDb.select("SELECT * FROM MyGuests;",null,null);
        var json_output,err = <json>result;
        http:OutResponse responce = {};
        responce.setJsonPayload(json_output);
        _ = connection.respond(responce);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/newGuest"
    }
    resource insertGuest(http:Connection connection, http:InRequest request) {
        endpoint <sql:ClientConnector> demoDb {
            create sql:ClientConnector(sql:DB.MYSQL, "localhost", 3306, "ballerina_demo", "root", "1234", {maximumPoolSize:5});
        }
        json guest = request.getJsonPayload();
        string email = guest.email.toString();
        string firstname = guest.firstname.toString();
        string lastname = guest.lastname.toString();
        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:firstname};
        sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:lastname};
        sql:Parameter para3 = {sqlType:sql:Type.VARCHAR, value:email};
        params = [para1, para2, para3];
        var count, ids = demoDb.updateWithGeneratedKeys("INSERT INTO MyGuests (firstname, lastname, email) VALUES (?,?,?)", params, null);
        http:OutResponse responce = {};
        responce.setJsonPayload({"status":"done","ID":ids[0]});
        _ = connection.respond(responce);
    }

    @http:resourceConfig {
        methods:["PUT"],
        path:"/updateGuest/{guestid}"
    }
    resource updateGuest(http:Connection connection, http:InRequest request,string guestid) {
        endpoint<sql:ClientConnector> demoDb {
            create sql:ClientConnector(sql:DB.MYSQL, "localhost", 3306, "ballerina_demo", "root", "1234", {maximumPoolSize:5});
        }
        json guest = request.getJsonPayload();
        string email = guest.email.toString();
        string firstname = guest.firstname.toString();
        string lastname = guest.lastname.toString();
        sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:firstname};
        sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:lastname};
        sql:Parameter para3 = {sqlType:sql:Type.VARCHAR, value:email};
        sql:Parameter para4 = {sqlType:sql:Type.INTEGER, value:guestid};
        params = [para1, para2, para3, para4];
        int count= demoDb.update("UPDATE MyGuests SET firstname=?, lastname=?, email=? WHERE id=?", params);
        http:OutResponse responce = {};
        if(count == 1)
        {
            responce.setJsonPayload({"status":"done","UpdatedCount":count});
        }
        else
        {
            responce.setJsonPayload({"status":"Not Updated","UpdatedCount":count});
        }
        _ = connection.respond(responce);
    }

    @http:resourceConfig{
        path:"/deleteGuest/{guestid}",
        methods:["DELETE"]
    }
    resource deleteGuest(http:Connection connection, http:InRequest request,string guestid) {
        endpoint<sql:ClientConnector> demoDb {
            create sql:ClientConnector(sql:DB.MYSQL, "localhost", 3306, "ballerina_demo", "root", "1234", {maximumPoolSize:5});
        }                                                                                                                                                                                                       sql:Parameter[] params = [];
        sql:Parameter para1 = {sqlType:sql:Type.INTEGER, value:guestid};
        params = [para1];
        int count= demoDb.update("DELETE FROM MyGuests WHERE id=?", params);
        http:OutResponse responce = {};
        if(count == 1)
        {
            responce.setJsonPayload({"status":"done","DeletedCount":count});
        }
        else
        {
            responce.setJsonPayload({"status":"Not Deleted","DeletedCount":count});
        }
        _ = connection.respond(responce);
    }
}
