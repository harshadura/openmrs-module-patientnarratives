<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>

<openmrs:htmlInclude file="/dwr/engine.js" />
<openmrs:htmlInclude file="/dwr/util.js" />
<openmrs:htmlInclude file="/dwr/interface/DWRreCaptchaService.js" />

<openmrs:htmlInclude file="/moduleResources/patientnarratives/css/styles.css"/>
<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/jquery.fileupload-ui.css" />

<openmrs:hasPrivilege privilege="Add Patient Narratives">

<script type="text/javascript">
    var RecaptchaOptions = {
        theme : 'clean'
    };

    EnableSubmit = function(val)
    {
        var submitMainForm = document.getElementById("submitMainForm");
        var nextUploads = document.getElementById("nextUploads");

        if (val.checked == true)
        {
            submitMainForm.disabled = false;
            nextUploads.disabled = false;
        }
        else
        {
            submitMainForm.disabled = true;
            nextUploads.disabled = true;
        }
    }

    $j(document).ready(function(){
        logging: true;

        $j('#dialogUploads').dialog({
            autoOpen: false,
            modal: true
        });

        $j("#nextUploads").click(function() {
                $j('#dialogUploads').dialog({
                    autoOpen: true,
                    width: '50%'
                });
        });

        $j("#submitPopup").click(function() {
            alert("Thanks, Record saved!");
            location.reload();
        });

    });

</script>


<style>
    #uploadStatus{
        display: none;
        font-weight: bold;
        color:#000099;
    }
</style>


<div id="main-wrap">

    <div id="sidebar">

        <div id="formEntryDialog22">
            <c:catch var="ex">
                <c:choose>
                    <c:when test="${formType == 'HTML-Form'}">
                        <openmrs:portlet url="htmlFormEntry" id="htmlFormEntryForm" moduleId="patientnarratives" />
                    </c:when>
                    <c:when test="${formType == 'X-Form'}">
                        <openmrs:portlet url="xFormEntry" id="xFormEntryForm" moduleId="patientnarratives" />
                    </c:when>
                </c:choose>
            </c:catch>
            <c:if test="${not empty ex}">
                <div class="error">
                    <openmrs:message code="fix.error.plain"/> <br/>
                    <b>${ex}</b>
                    <div style="height: 200px; width: 800px; overflow: scroll">
                        <c:forEach var="row" items="${ex.cause.stackTrace}">
                            ${row}<br/>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <div id="content-wrap">

    <div id="dialogUploads" style="display: none" title="Upload Files/Record Video">

        <b class="boxHeader">Narrate your sickness here</b>
        <div class="box" >

        <div id="info-wrap">
            <center>
                </br>

                <video id="client-video" width="320" height="240" autoplay loop muted></video>

                <br/><br/>

                <button id="clear-record" disabled>Clear</button>
                <button id="start-record">Start Recording</button>
                <button id="stop-record" disabled>Stop</button>
                <button id="upload-record" disabled>Upload</button>

                <br/><br/>
                <div style="display: none;" id="result"></div>
                <progress id="videoUploadProgressBar" min="0" max="100" value="0">0% Completed</progress>
                <div id="uploadStatus"> Video uploaded successfully!</div>

            </center>
        </div>
       </div>

        <b class="boxHeader">Upload files (X-ray, reports, etc)</b>
        <div class="box" >

        <div id="info-wrap">
            </br>

            <div id="fileupload">
                <form action="<openmrs:contextPath/>/module/patientnarratives/multiFileUpload.form" method="POST" enctype="multipart/form-data">
                    <div class="fileupload-buttonbar">
                        <label class="fileinput-button">
                            <span>Add files...</span>
                            <input id="file" type="file" name="files[]" multiple>
                        </label>
                        <button type="submit" class="start">Start upload</button>
                        <button type="reset" class="cancel">Cancel upload</button>
                        <button type="button" class="delete">Delete files</button>
                    </div>
                </form>
                <div class="fileupload-content">
                    <table class="files"></table>
                    <div class="fileupload-progressbar"></div>
                </div>
            </div>
        </div>

        </div>

        <br/>
        <center> <input id="submitPopup" type="submit" value="Submit now!" /> </center>
        <br/>
    </div>
            <%--<table border="1">--%>
            <%--<tr>--%>
            <%--<td> <span>Upload files (X-ray, reports, etc)</span> </td>--%>
            <%--<td>--%>
            <%--<input type="file" name="file" id="file" size="40"/>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--</table>--%>


        <div id="info-wrap">
            </br></br>
            <form id="captchaForm" method="post">
                <%
                    ReCaptcha c = ReCaptchaFactory.newReCaptcha("6LdAWuMSAAAAAD3RQXMNBKgI9-1OiYjDx_sl0xYy", "6LdAWuMSAAAAALxWgnM5yRj_tGVRQCk4lit8rLHb", false);
                    out.print(c.createRecaptchaHtml(null, null));
                %>

                </br>
            </form>

            <input type="checkbox" name="agreement" value="Accept" onClick="EnableSubmit(this)">

            <span>
              <%--<strong>--%>
                  I agree to the OpenMRS - Patient Narratives Module <br> <a target="_blank" href="http://openmrs.org/privacy/">Terms of Service</a> and <a target="_blank" id="PrivacyLink" href="http://openmrs.org/privacy/">Privacy Policy</a>
              <%--</strong>--%>
            </span>
            <br> <br>

            <input id="submitMainForm" type="button" value="Submit Now" disabled />
            <input id="nextUploads" type="button" value="Next - Upload Files/Record Video" disabled />
        </div>
    </div>
</div>

</openmrs:hasPrivilege>

<%@ include file="/WEB-INF/template/footer.jsp"%>

<script id="template-upload" type="text/x-jquery-tmpl">
    <tr class="template-upload{{if error}} ui-state-error{{/if}}">
        <td class="preview"></td>
        <td class="name">${name}</td>
        <td class="size">${sizef}</td>
        {{if error}}
        <td class="error" colspan="2">Error:
            {{if error === 'maxFileSize'}}File is too big
            {{else error === 'minFileSize'}}File is too small
            {{else error === 'acceptFileTypes'}}Filetype not allowed
            {{else error === 'maxNumberOfFiles'}}Max number of files exceeded
            {{else}}${error}
            {{/if}}
        </td>
        {{else}}
        <td class="progress"><div></div></td>
        <td class="start"><button>Start</button></td>
        {{/if}}
        <td class="cancel"><button>Cancel</button></td>
    </tr>
</script>
<script id="template-download" type="text/x-jquery-tmpl">
    <tr class="template-download{{if error}} ui-state-error{{/if}}">
        {{if error}}
        <td></td>
        <td class="name">${namefdsa}</td>
        <td class="size">${sizef}</td>
        <td class="error" colspan="2">Error:
            {{if error === 1}}File exceeds upload_max_filesize (php.ini directive)
            {{else error === 2}}File exceeds MAX_FILE_SIZE (HTML form directive)
            {{else error === 3}}File was only partially uploaded
            {{else error === 4}}No File was uploaded
            {{else error === 5}}Missing a temporary folder
            {{else error === 6}}Failed to write file to disk
            {{else error === 7}}File upload stopped by extension
            {{else error === 'maxFileSize'}}File is too big
            {{else error === 'minFileSize'}}File is too small
            {{else error === 'acceptFileTypes'}}Filetype not allowed
            {{else error === 'maxNumberOfFiles'}}Max number of files exceeded
            {{else error === 'uploadedBytes'}}Uploaded bytes exceed file size
            {{else error === 'emptyResult'}}Empty file upload result
            {{else}}${error}
            {{/if}}
        </td>
        {{else}}
        <td class="preview">
            {{if Thumbnail_url}}
            <a href="${url}" target="_blank"><img src="${Thumbnail_url}"></a>
            {{/if}}
        </td>
        <td class="name">
            <a href="${url}"{{if thumbnail_url}} target="_blank"{{/if}}>${Name}</a>
        </td>
        <td class="size">${Length}</td>
        <td colspan="2"></td>
        {{/if}}
        <td class="delete">
            <button data-type="${delete_type}" data-url="${delete_url}">Delete</button>
        </td>
    </tr>
</script>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>

<%--<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/jquery.tmpl.min.js" />--%>

<openmrs:htmlInclude file="/moduleResources/patientnarratives/js/webRtc/whammy.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/js/webRtc/StereoRecorder.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/js/webRtc/record-rtc.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/js/webRtc/main.js" />

<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/jquery.iframe-transport.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/jquery.fileupload.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/jquery.fileupload-ui.js" />
<openmrs:htmlInclude file="/moduleResources/patientnarratives/fileupload/application.js" />

