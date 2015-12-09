package com.itda.servlet

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionListener; 
import javax.servlet.http.HttpSessionEvent;
import org.apache.commons.logging.Log; 
import org.apache.commons.logging.LogFactory; 
import com.itda.UserSession;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;

public class SessionListener implements HttpSessionListener {

	private static final Log log = LogFactory.getLog(SessionListener.class);
	private static SessionFactory sessionFactory;

	public static void setSessionFactory(SessionFactory sf) { sessionFactory = sf; }

	public static void shutdown() { sessionFactory.close(); }

	public void sessionDestroyed(HttpSessionEvent event) { 
		boolean isDebug = log.isDebugEnabled()
		if ( isDebug )
			log.debug("Session ending "); 
       /*
		HttpSession sess = event.getSession();
		org.hibernate.Session hibSess ;
		boolean hasNoCurrTrans = false
		try {
			if ( isDebug )
				log.debug("trying to open session and begin transaction.");
			try { hibSess = sessionFactory.getCurrentSession(); }
			catch(Exception e) {
				if ( isDebug )
					log.debug "open new hibernate session "
				hibSess = sessionFactory.openSession()
				//This is how spring ties the hibernate session to the current transaction/thread it 
				//actually binds a SessionHolder object containing the session. This bindResource 
				//method expects the spring proxy sessionFactory and not the Hibernate session 
				//factory in order to work correctly.
				//Bind the Session to the current thread/transaction
				TransactionSynchronizationManager.bindResource(sessionFactory, 
						new SessionHolder(hibSess));
				//Activate transaction synchronization for the current thread.
				TransactionSynchronizationManager.initSynchronization();
				hibSess.beginTransaction()
				hasNoCurrTrans = true
			}

			UserSession userSess = UserSession.findBySessionId(sess.getId())
			if(userSess && userSess.loggedIn) {
				userSess.loggedIn = false;
				userSess.expirationTime = new Date()
				if(!userSess.save(flush:true))
					userSess.errors.each { log.error(it) }
			}

			if (hasNoCurrTrans) {
				hibSess.getTransaction().commit();
				//hibSess.close();
			}

		} catch ( Exception e ){
			log.error ("error destroying session ", e); 
			if(hasNoCurrTrans && hibSess)
				try {  hibSess.getTransaction().commit(); }
				catch(Exception e1) {}
				
		//} finally {
			//sess.invalidate();
		}
      */
	} 

	public void sessionCreated(HttpSessionEvent event) 
	{ 
		if ( log.isDebugEnabled())
			log.debug("Session starting"); 
	} 

}

