
<%@ page import="auctionhaus.Listing" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'listing.label', default: 'Listing')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-listing" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-listing" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list listing">
			
				<g:if test="${listingInstance?.listingName}">
				<li class="fieldcontain">
					<span id="listingName-label" class="property-label"><g:message code="listing.listingName.label" default="Listing Name" /></span>
					
						<span class="property-value" aria-labelledby="listingName-label"><g:fieldValue bean="${listingInstance}" field="listingName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${listingInstance?.startingBidPrice}">
				<li class="fieldcontain">
					<span id="startingBidPrice-label" class="property-label"><g:message code="listing.startingBidPrice.label" default="Starting Bid Price" /></span>
					
						<span class="property-value" aria-labelledby="startingBidPrice-label"><g:fieldValue bean="${listingInstance}" field="startingBidPrice"/></span>
					
				</li>
				</g:if>

                <g:if test="${listingInstance?.showDescription}">
			    	<g:if test="${listingInstance?.listingDescription}">
			    	<li class="fieldcontain">
				    	<span id="listingDescription-label" class="property-label"><g:message code="listing.listingDescription.label" default="Listing Description" /></span>


                            <span class="property-value" aria-labelledby="seller-label"><g:link controller="listing" action="hideDescription" id="${listingInstance?.id}">Hide Description</g:link></span>


						    <span class="property-value" aria-labelledby="listingDescription-label"><g:fieldValue bean="${listingInstance}" field="listingDescription"/></span>
					
		    		</li>
			    	</g:if>
                </g:if>


                <g:if test="${!listingInstance?.showDescription}">
                    <g:if test="${listingInstance?.listingDescription}">
                        <li class="fieldcontain">


                            <span class="property-value" aria-labelledby="seller-label"><g:link controller="listing" action="showDescription" id="${listingInstance?.id}">Show Description</g:link></span>



                        </li>
                    </g:if>
                </g:if>





				<g:if test="${listingInstance?.listingEndDateTime}">
				<li class="fieldcontain">
					<span id="listingEndDateTime-label" class="property-label"><g:message code="listing.listingEndDateTime.label" default="Listing End Date Time" /></span>
					
						<span class="property-value" aria-labelledby="listingEndDateTime-label"><g:formatDate date="${listingInstance?.listingEndDateTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${listingInstance?.winner}">
				<li class="fieldcontain">
					<span id="winner-label" class="property-label"><g:message code="listing.winner.label" default="Winner" /></span>
					
						<span class="property-value" aria-labelledby="winner-label"><g:link controller="customer" action="show" id="${listingInstance?.winner?.id}">${listingInstance?.winner?.encodeAsHTML()}</g:link></span>

				</li>
				</g:if>
			
				<g:if test="${listingInstance?.bids}">
				<li class="fieldcontain">
					<span id="bids-label" class="property-label"><g:message code="listing.bids.label" default="Most Recent Bid" /></span>

						<span class="property-value" aria-labelledby="bids-label"><g:link controller="bid" action="show" id="${listingInstance?.getMostRecentBid()?.id}">${listingInstance?.getMostRecentBid()?.encodeAsHTML()}</g:link></span>

					
				</li>
				</g:if>
			
				<g:if test="${listingInstance?.listingCreatedDate}">
				<li class="fieldcontain">
					<span id="listingCreatedDate-label" class="property-label"><g:message code="listing.listingCreatedDate.label" default="Listing Created Date" /></span>
					
						<span class="property-value" aria-labelledby="listingCreatedDate-label"><g:formatDate date="${listingInstance?.listingCreatedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${listingInstance?.seller}">
				<li class="fieldcontain">
					<span id="seller-label" class="property-label"><g:message code="listing.seller.label" default="Seller" /></span>
					
						<span class="property-value" aria-labelledby="seller-label"><g:link controller="customer" action="show" id="${listingInstance?.seller?.id}">${listingInstance?.seller?.email?.tokenize("@")?.first().encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>


                <li class="fieldcontain">
                <span class="property-value" aria-labelledby="seller-label"><g:link controller="bid" action="create" params="['listing.id': listingInstance?.id]">Place bid on listing</g:link></span>
                </li>


            </ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${listingInstance?.id}" />
					<g:link class="edit" action="edit" id="${listingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
