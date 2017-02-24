package org.agnitas.emm.springws.endpoint.component;

import javax.annotation.Resource;

import org.agnitas.beans.MailingComponent;
import org.agnitas.emm.core.component.service.ComponentModel;
import org.agnitas.emm.core.component.service.ComponentService;
import org.agnitas.emm.springws.endpoint.Utils;
import org.agnitas.emm.springws.jaxb.ObjectFactory;
import org.agnitas.emm.springws.jaxb.UpdateAttachmentRequest;
import org.agnitas.emm.springws.jaxb.UpdateAttachmentResponse;
import org.springframework.ws.server.endpoint.AbstractMarshallingPayloadEndpoint;

public class UpdateAttachmentEndpoint extends AbstractMarshallingPayloadEndpoint {

	@Resource
	private ComponentService componentService;
	@Resource
	private ObjectFactory objectFactory;
	
	@Override
	protected Object invokeInternal(Object arg0) throws Exception {
		UpdateAttachmentRequest request = (UpdateAttachmentRequest) arg0;
		
		ComponentModel model = new ComponentModel();
		model.setCompanyId(Utils.getUserCompany());
		model.setComponentId(request.getComponentID());
		model.setMimeType(request.getMimeType());
		model.setComponentType(MailingComponent.TYPE_ATTACHMENT);
		model.setComponentName(request.getComponentName());
		model.setData(request.getData());

		UpdateAttachmentResponse response = objectFactory.createUpdateAttachmentResponse();
		componentService.updateComponent(model);
		return response;
	}

}
