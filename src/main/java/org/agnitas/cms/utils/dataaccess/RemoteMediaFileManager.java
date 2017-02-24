/*********************************************************************************
 * The contents of this file are subject to the Common Public Attribution
 * License Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.openemm.org/cpal1.html. The License is based on the Mozilla
 * Public License Version 1.1 but Sections 14 and 15 have been added to cover
 * use of software over a computer network and provide for limited attribution
 * for the Original Developer. In addition, Exhibit A has been modified to be
 * consistent with Exhibit B.
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * The Original Code is OpenEMM.
 * The Original Developer is the Initial Developer.
 * The Initial Developer of the Original Code is AGNITAS AG. All portions of
 * the code written by AGNITAS AG are Copyright (c) 2014 AGNITAS AG. All Rights
 * Reserved.
 *
 * Contributor(s): AGNITAS AG. 
 ********************************************************************************/

package org.agnitas.cms.utils.dataaccess;

import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.rpc.ServiceException;

import org.agnitas.cms.webservices.generated.MediaFile;
import org.agnitas.cms.webservices.generated.RemoteMediaFileManagerServiceLocator;
import org.agnitas.cms.webservices.generated.RemoteMediaFileManager_PortType;
import org.agnitas.util.AgnUtils;
import org.apache.log4j.Logger;

/**
 * Provide remote functionality to MediaFileManager.
 * Invokes service from central content repository.
 *
 * @author Igor Nesterenko
 * @see org.agnitas.cms.webservices.MediaFileService
 */

public class RemoteMediaFileManager implements MediaFileManager {
	private static final transient Logger logger = Logger.getLogger(RemoteMediaFileManager.class);

	private RemoteMediaFileManager_PortType mediaFileManager;

	public void setPortUrl(String portUrlString) {
		final RemoteMediaFileManagerServiceLocator serviceLocator = new RemoteMediaFileManagerServiceLocator();
		try {
			mediaFileManager = serviceLocator
					.getRemoteMediaFileManager(new URL(portUrlString));
		} catch(ServiceException e) {
			logger.error("Error while acces to service by port=" + portUrlString + " " + e, e);
		} catch(MalformedURLException e) {
			logger.error("Error while parsing port address portAddress=" + portUrlString + " " + e, e);
		}

	}

	public MediaFile createMediaFile(MediaFile mediaFile) {
		try {
			return mediaFileManager.createMediaFile(mediaFile);
		} catch(RemoteException e) {
			logger.error("Error while create " + MediaFile.class.getSimpleName() + " " + e, e);
		}
		return null;
	}

	public MediaFile getMediaFile(int id) {
		try {
			return mediaFileManager.getMediaFile(id);
		} catch(RemoteException e) {
			logger.error("Error while get " + MediaFile.class.getSimpleName() +
					" by id=" + id + e, e);
		}
		return null;
	}

	public void removeMediaFile(int id) {
		try {
			mediaFileManager.removeMediaFile(id);
		} catch(RemoteException e) {
			logger.error("Error while remove mediaFile by id=" + id + e, e);
		}
	}

	public void removeMediaFilesForCMTemplateId(int cmTemplateId) {
		try {
			mediaFileManager.removeMediaFilesForCMTemplateId(cmTemplateId);
		} catch(RemoteException e) {
			logger.error("Error while remove " + MediaFile.class.getSimpleName() +
							" from cmTemplateId=" + cmTemplateId + e, e);
		}
	}

	public void removeContentModuleImage(int contentModuleId, String mediaName) {
		try {
			mediaFileManager.removeContentModuleImage(contentModuleId, mediaName);
		} catch(RemoteException e) {
			logger.error("Error while remove " + MediaFile.class.getSimpleName() +
							" from content module id=" + contentModuleId +
							" and media name=" + mediaName + e, e);
		}
	}

	public List<MediaFile> getMediaFilesForContentModule(int contentModuleId) {
		final ArrayList<MediaFile> mediaFileList = new ArrayList<MediaFile>();
		try {
			final Object[] mediaFiles = mediaFileManager
					.getMediaFilesForContentModule(contentModuleId);
			for(Object mediaFile : mediaFiles) {
				mediaFileList.add(((MediaFile) mediaFile));
			}
		} catch(RemoteException e) {
			logger.error("Error while getting " + MediaFile.class.getSimpleName() + " of content module id=" + contentModuleId + " " + e, e);
		}
		return mediaFileList;
	}

	public void removeMediaFilesForContentModuleId(int contentModuleId) {
		try {
			mediaFileManager.removeMediaFilesForContentModuleId(contentModuleId);
		} catch(RemoteException e) {
			logger.error("Error while remove media file of content module id=" + contentModuleId + " " + e, e);
		}
	}

	public MediaFile getPreviewOfContentModule(int contentModuleId) {
		try {
			return mediaFileManager.getPreviewOfContentModule(contentModuleId);
		} catch(RemoteException e) {
			logger.error("Error while getting preview of content module id=" + contentModuleId + " " + e, e);
		}
		return null;
	}

	public MediaFile getPreviewOfContentModuleType(int cmtId) {
		try {
			return mediaFileManager.getPreviewOfContentModuleType(cmtId);
		} catch(RemoteException e) {
			logger.error("Error while getting preview of content module type id=" + cmtId + " " + e, e);
		}
		return null;
	}

	public MediaFile getPreviewOfContentModuleTemplate(int cmTemplateId) {
		try {
			return mediaFileManager.getPreviewOfContentModuleTemplate(cmTemplateId);
		} catch(RemoteException e) {
			logger.error("Error while getting preview of content module template id=" +
							cmTemplateId + e, e);
		}
		return null;
	}

	public void removePreviewOfContentModule(int contentModuleId) {
		try {
			mediaFileManager.removePreviewOfContentModule(contentModuleId);
		} catch(RemoteException e) {
			logger.error("Error while remove preview of content module id=" + contentModuleId + e, e);
		}
	}

	public void removePreviewOfContentModuleType(int contentModuleTypeId) {
		try {
			mediaFileManager.removePreviewOfContentModuleType(contentModuleTypeId);
		} catch(RemoteException e) {
			logger.error("Error while remove preview of content module type  id=" + contentModuleTypeId + e, e);
		}
	}

	public void removePreviewOfContentModuleTemplate(int cmTemplateId) {
		try {
			mediaFileManager.removePreviewOfContentModuleTemplate(cmTemplateId);
		} catch(RemoteException e) {
			logger.error("Error while removing  preview of content module template id=" + cmTemplateId + e, e);
		}
	}

    public void updateMediaFile(int id, byte[] content) {
        try {
            mediaFileManager.updateMediaFile(id, content);
        } catch (RemoteException e) {
            logger.error("Error while update media file of content module template id=" + id + " " + e, e);
        }

    }

    public void updateMediaFile(MediaFile mediaFile) {
        try {
            mediaFileManager.updateMediaFile(mediaFile);
        } catch (Exception e) {
            logger.error("Error while update media file of content module template id=" + mediaFile.getId() + " " + e, e);
        }
    }

    public List<MediaFile> getMediaFilesForContentModuleTemplate(int cmTemplateId) {
       final ArrayList<MediaFile> mediaFileList = new ArrayList<MediaFile>();
		try {
			final Object[] mediaFiles = mediaFileManager
					.getMediaFilesForContentModuleTemplate(cmTemplateId);
			for(Object mediaFile : mediaFiles) {
				mediaFileList.add(((MediaFile) mediaFile));
			}
        } catch (Exception e) {
            logger.error("Error while get list media file of content module template cmTemplateId=" + cmTemplateId + " " + e, e);
        }
        return mediaFileList;
    }

    public MediaFile getMediaFileForContentModelAndMediaName(int cmTemplateId, String mediaName) {
        try {
            return mediaFileManager.getMediaFileForContentModelAndMediaName(cmTemplateId, mediaName);
        } catch (Exception e) {
            logger.error("Error while get media file of content module template cmTemplateId=" +
                            cmTemplateId+" and media_name="+mediaName+" " + e, e);
        }
        return null;
    }
}
