/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.patientnarratives.api;

import org.openmrs.api.APIException;
import org.openmrs.module.patientnarratives.NarrativeComments;
import org.openmrs.module.patientnarratives.api.db.PatientNarrativesDAO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * This service exposes module's core functionality. It is a Spring managed bean which is configured in moduleApplicationContext.xml.
 * <p>
 * It can be accessed only via Context:<br>
 * <code>
 * Context.getService(PatientNarrativesService.class).someMethod();
 * </code>
 * 
 * @see org.openmrs.api.context.Context
 */
@Transactional
public interface PatientNarrativesService {

    public void setPatientNarrativesDAO(PatientNarrativesDAO dao);

    public void saveNarrativesComment(NarrativeComments narrativeComments) throws APIException;

    public List<NarrativeComments> getNarrativeComments(Integer encounterId) throws APIException;

}