package org.agnitas.emm.springws.endpoint.recipient;

import javax.annotation.Resource;

import org.agnitas.emm.core.recipient.service.RecipientModel;
import org.agnitas.emm.core.recipient.service.RecipientService;
import org.agnitas.emm.springws.endpoint.Utils;
import org.agnitas.emm.springws.jaxb.DeleteSubscriberRequest;
import org.agnitas.emm.springws.jaxb.DeleteSubscriberResponse;
import org.agnitas.emm.springws.jaxb.ObjectFactory;
import org.springframework.ws.server.endpoint.AbstractMarshallingPayloadEndpoint;

public class DeleteSubscriberEndpoint extends AbstractMarshallingPayloadEndpoint {

	@Resource
	private RecipientService recipientService;
	@Resource
	private ObjectFactory objectFactory; 
	
	@Override
	protected Object invokeInternal(Object arg0) throws Exception {
		DeleteSubscriberRequest request = (DeleteSubscriberRequest) arg0;
		DeleteSubscriberResponse response = objectFactory.createDeleteSubscriberResponse();

		RecipientModel model = parseModel(request);
		
		recipientService.deleteSubscriber(model);
		return response;
	}

	static RecipientModel parseModel(DeleteSubscriberRequest request) {
		RecipientModel model = new RecipientModel();
		model.setCompanyId(Utils.getUserCompany());
		model.setCustomerId(request.getCustomerID());
		return model;
	}

}
