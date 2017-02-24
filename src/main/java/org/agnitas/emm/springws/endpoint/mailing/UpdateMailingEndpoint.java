package org.agnitas.emm.springws.endpoint.mailing;

import javax.annotation.Resource;

import org.agnitas.emm.core.mailing.service.MailingModel;
import org.agnitas.emm.core.mailing.service.MailingService;
import org.agnitas.emm.springws.endpoint.Utils;
import org.agnitas.emm.springws.jaxb.ObjectFactory;
import org.agnitas.emm.springws.jaxb.UpdateMailingRequest;
import org.agnitas.emm.springws.jaxb.UpdateMailingRequest.TargetIDList;
import org.agnitas.emm.springws.jaxb.UpdateMailingResponse;
import org.springframework.ws.server.endpoint.AbstractMarshallingPayloadEndpoint;

public class UpdateMailingEndpoint extends AbstractMarshallingPayloadEndpoint {

	@Resource
	private MailingService mailingService;
	@Resource
	private ObjectFactory objectFactory; 

	@Override
	protected Object invokeInternal(Object arg0) throws Exception {
		UpdateMailingRequest request = (UpdateMailingRequest) arg0;

		MailingModel model = new MailingModel();
		model.setMailingId(request.getMailingID());
		model.setCompanyId(Utils.getUserCompany());
		model.setShortname(request.getShortname());
		model.setDescription(request.getDescription());
		model.setMailinglistId(request.getMailinglistID());
		TargetIDList targetIDList = request.getTargetIDList();
		if (targetIDList != null) {
			model.setTargetIDList(targetIDList.getTargetID());
		}
		model.setTargetMode(request.getMatchTargetGroups());
		model.setMailingType(request.getMailingType());
		model.setSubject(request.getSubject());
		model.setSenderName(request.getSenderName());
		model.setSenderAddress(request.getSenderAddress());
		model.setReplyToName(request.getReplyToName());
		model.setReplyToAddress(request.getReplyToAddress());
		model.setCharset(request.getCharset());
		model.setLinefeed(request.getLinefeed());
		model.setFormatString(request.getFormat());
		model.setOnePixelString(request.getOnePixel());
//		model.setAutoUpdate(request.isAutoUpdate());

		UpdateMailingResponse response = objectFactory.createUpdateMailingResponse();
		mailingService.updateMailing(model);
		return response;
	}

}
