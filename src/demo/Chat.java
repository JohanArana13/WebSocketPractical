package demo;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by HaouJohan on 11/28/2016.
 */
@ServerEndpoint("/chat/{id}")
public class Chat {

    private static Set<Session> allSessions = new HashSet<Session>();
    @OnOpen
    public void register(@PathParam("id") String id, Session session){
        System.out.println("Registering id: " + id + "for session: " + session.getId());
        session.getUserProperties().put("id", id);
        allSessions.add(session);
        try{
            session.getBasicRemote().sendText(id + " registered successfully!");
        }catch(IOException ioe){
            System.out.println(ioe.getMessage());
        }
    }

    @OnMessage
    public void onMessage(String txt, Session session) throws IOException {
        System.out.println("Received: " + txt);
        System.out.println(session.getOpenSessions().size());
        for(Session s:allSessions){
            try{
                String msg = (String)session.getUserProperties().get("id") + ">>" + txt;
                s.getBasicRemote().sendText(msg);
                System.out.println("Sent: " + msg);
            }catch(IOException ioe){
                System.out.println(ioe.getMessage());
            }
        }
    }

    @OnClose
    public void onClose(CloseReason reason, Session session){
        allSessions.remove(session);
        System.out.println("Closing a WebSocket due to " + reason.getReasonPhrase());
    }
}
