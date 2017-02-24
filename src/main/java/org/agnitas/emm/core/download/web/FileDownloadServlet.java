package org.agnitas.emm.core.download.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.agnitas.emm.core.download.model.FileData;
import org.agnitas.emm.core.download.service.DownloadConstants;
import org.agnitas.emm.core.download.service.DownloadIdNotFoundException;
import org.agnitas.emm.core.download.service.DownloadService;
import org.agnitas.util.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.web.context.ContextLoader;

/**
 * Servlet for file download.
 * 
 * @author md
 */
public class FileDownloadServlet extends HttpServlet {
	
	/** Serial version UID. */
	private static final long serialVersionUID = 7960980002662696503L;

	/** Logger. */
	private static final transient Logger logger = Logger.getLogger( FileDownloadServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession( false);
		
		// No session? Stop here
		if( session == null) {
			if( logger.isInfoEnabled())
				logger.info( "No session data");
		}
		
		// Get ID of download
		String downloadId = getDownloadId( req);
		
		// No ID? Stop
		if( downloadId == null) {
			if( logger.isInfoEnabled())
				logger.info( "Parameter for download ID is missing");
			
			return;
		}
		
		try {
			FileData data = getDownloadService().getDownloadData( downloadId, session);
			
			emitFile( data, resp);
		} catch( DownloadIdNotFoundException e) {
			logger.warn( "Download ID unknown: " + e.getDownloadId(), e);
		}
	}

	/**
	 * Returns the download ID given at the request parameter.
	 * 
	 * @param request HTTP request
	 * 
	 * @return ID of download or null
	 */
	private String getDownloadId( HttpServletRequest request) {
		return request.getParameter( DownloadConstants.DOWNLOAD_ID_PARAMETER_NAME);
	}
	
	/**
	 * Write temporary file to HTTP response.
	 * 
	 * @param data download information
	 * @param response HTTP response
	 */
	private void emitFile( FileData data, HttpServletResponse response) {
		File file = new File( data.getTempFileName());
		
		if( !file.exists()) {
			logger.warn( "Temporary file for download does not exist: " + data.getTempFileName());
			return;
		}
		
		try {
			FileInputStream fis = new FileInputStream( file);
			
			try {
				response.setContentType( data.getMimeType().toString());
                if (data.getDownloadName() != null && !data.getDownloadName().isEmpty()) {
                    response.setHeader( "Content-Disposition", "attachment; filename=\"" + data.getDownloadName() + "\";");
                }
				
				@SuppressWarnings("resource") // Needed, because the container manages the stream. (Otherwise Eclipse complains about a potential resource leak)
				OutputStream outputStream = response.getOutputStream();

				FileUtils.streamToStream( fis, file.length(), outputStream);
			} catch( IOException e) {
				logger.error( "Error sending file", e);
			} finally {
				fis.close();
			}
		} catch( FileNotFoundException e) {
			logger.error( "Temporary file for download not found: " + data.getTempFileName(), e);
		} catch( IOException e) {
			logger.error( "Error sending file", e);
		}
	}
	
	// ------------------------------------------------------------------------------------------ Dependecy Injection

	/**
	 * Returns the download service defined in Spring. 
	 * 
	 * @return download service
	 */
	public DownloadService getDownloadService() {
		// Required, because Spring cannot inject into plain servlets
		return (DownloadService) ContextLoader.getCurrentWebApplicationContext().getBean( "DownloadService");
	}
}
