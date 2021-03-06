<?xml version="1.0" encoding="UTF-8"?>
<!--
******************************************************************************************************************

		PEPPOLInstance Documentation - reference stylesheet 	

		title= Stylesheet_Full.xsl	
		publisher= "Difi"
		created= 2014-12-02
		conformsTo= UBL-Invoice-2.1.xsd
		description= "Stylesheet for EHF Invoice and Creditnote, PEPPOL BIS 4A and 5A, version 2.0
		This stylesheet was drawn up to serve developers and end-users as a neutral reference tool when
		assessing transaction content. The purpose of the reference stylesheet is
		- To visualise all data structures, including all their occurrences, in transaction instances 
		  compliant to EHF Invoice and creditnote, in addition to BIS 4A and 5A; 
		- To show all data as is, i.e. without any editing;
		- To show relevant attributes: that is, attributes are displayed only to the extent that they have 
		  any impact on the understanding or interpretation of an element value. For example, a fix listID  
		  (like UNCL1001) would not be displayed. 

		The assumption is that is that the stylesheet is applied to messages that are formally correct, i.e. 
		messages that comply with XML schema and schematron rules. However, as this reference stylesheet is 
		likely to be used also in test environments, some basic validation features have been included, 
		and any consequential errors are displayed as needed."
		
		Derived from work by SFTI, Sweden and OIOUBL, Denmark.
		
******************************************************************************************************************
-->
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/xhtml"
 xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
 xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
 xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
 xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
 xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
 xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2"
 xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
 exclude-result-prefixes="n1 n2 cac cbc ccts sdt udt">
	<xsl:include href="CommonTemplates.xsl"/>
	<xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
	<xsl:strip-space elements="*"/>


	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="n1:Invoice | n2:CreditNote">
		<!-- Start HTML -->
		<html>
			<head>
				<link rel="Stylesheet" type="text/css" href="PEPPOL.css"/>
				<title>EHF Faktura og kreditnota</title>
			</head>
			<body>
				<!-- Start on header-->
				 

				<table border="0" width="100%" cellspacing="0" cellpadding="2">


					<tr>
						
					<td colspan="4">

							<h3>
							<b>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='IssueDate']/g-lang[lang($pLang)]"/>&#160;</b>
							<!-- Inserting Invoice Date -->
							<br/><xsl:value-of select="cbc:IssueDate"/>

							</h3>
						</td>
						<td colspan="2">
							
							<h3>
							<b>
								<xsl:choose>		
									<xsl:when test="/n1:Invoice">
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='InvoiceID']/g-lang[lang($pLang)]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='CreditNoteID']/g-lang[lang($pLang)]"/>
									</xsl:otherwise>
								</xsl:choose>
							</b></h3>
							<!-- Inserting Invoice ID -->
								<br/><xsl:value-of select="cbc:ID"/>

							
						</td>

					</tr>
					
				
				
					<tr>
				
						<td valign="top" colspan="2">

							<xsl:if test="cbc:AccountingCost !=''">
								<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccountingCost']/g-lang[lang($pLang)]"/>&#160;</h2>
								<xsl:value-of select="cbc:AccountingCost"/>
							</xsl:if>

						</td>
						<td valign="top" colspan="2">

							<xsl:if test="cac:InvoicePeriod !=''">

								<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='InvoicePeriod']/g-lang[lang($pLang)]"/>
								</h2>

								<xsl:apply-templates select="cac:InvoicePeriod"/>

							</xsl:if>
						</td>

						<td valign="top" colspan="2">
							<xsl:if test="cac:OrderReference/cbc:ID !=''">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='OrderReferenceID']/g-lang[lang($pLang)]"/>&#160;</h2>
							<!-- Inserting Order reference number  -->
							<xsl:value-of select="cac:OrderReference/cbc:ID"/>
							</xsl:if>

						</td>
					</tr>
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>


			<!-- Start of Parties (in header) -->
					<tr>
						<td valign="top" colspan="2">
							<!-- Inserting Accounting Supplier Party-->
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccountingSupplierInv']/g-lang[lang($pLang)]"/>
							</h2>
						
							<xsl:apply-templates select="cac:AccountingSupplierParty"/>
						</td>
						<td valign="top" colspan="2">
							<!-- Inserting contact information -->
							<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
								<h2>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccSupContact']/g-lang[lang($pLang)]"/>
								</h2>
						
								<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="accsupcontact"/>
							</xsl:if>
						</td>

						<td valign="top" colspan="2">
							<!-- Inserting Accounting Customer Party -->
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccountingCustomerInv']/g-lang[lang($pLang)]"/>
							</h2>
						
							<xsl:apply-templates select="cac:AccountingCustomerParty"/>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !=''">
								<!-- Inserting Contact information-->
								<h2>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AccCusContact']/g-lang[lang($pLang)]"/>
								</h2>
							
								<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="acccuscontact"/>
							</xsl:if>
						</td>
					</tr>
				<xsl:if test="cac:PayeeParty !='' or cac:TaxRepresentativeParty !='' or cac:Delivery !='' ">
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>

					<tr>
						<td valign="top" colspan="2">
							<xsl:if test="cac:PayeeParty !=''">
								<!-- Inserting Payee Party -->
								<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PayeeParty']/g-lang[lang($pLang)]"/>
								</h2>
								<xsl:apply-templates select="cac:PayeeParty"/>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<xsl:if test="cac:TaxRepresentativeParty !=''">
								<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxRepresentativeParty']/g-lang[lang($pLang)]"/>
								</h2>
								<xsl:apply-templates select="cac:TaxRepresentativeParty"/>
							</xsl:if>


						<xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>

						</td>
					</tr>
				</xsl:if>

					<!-- Any additional information on document level or referenced/attached documents: -->
					
					<xsl:if test="cbc:Note[.!=''] or cac:ContractDocumentReference !='' or cac:AdditionalDocumentReference !=''or cac:BillingReference !=''">
						<tr>
							<td colspan="8">
								<hr size="2"/>
							</td>
						</tr>
						
						<tr>
							<td valign="top" colspan="4">
								<xsl:if test="cbc:Note[.!='']">
									<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='HeaderNotes']/g-lang[lang($pLang)]"/>
									</h2>
									<xsl:apply-templates select="cbc:Note"/>
								</xsl:if>
							</td>
							
							<td valign="top" colspan="4">
								
								<xsl:if test="cac:ContractDocumentReference !=''">
									<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ContractDocumentReference']/g-lang[lang($pLang)]"/>
									</h2>
									
									<xsl:apply-templates select="cac:ContractDocumentReference"/>
									
								</xsl:if>
								
								<xsl:if test="cac:AdditionalDocumentReference !=''">
									<xsl:if test="cac:ContractDocumentReference !=''">
									</xsl:if>
									<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AdditionalDocumentReferenceID']/g-lang[lang($pLang)]"/>
									</h2><xsl:apply-templates select="cac:AdditionalDocumentReference"/>
								</xsl:if>
								
								<xsl:if test="cac:BillingReference !=''">
									<xsl:if test="cac:ContractDocumentReference !='' or cac:AdditionalDocumentReference !=''">
									</xsl:if>
									<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='BillingReference']/g-lang[lang($pLang)]"/>
									</h2><xsl:apply-templates select="cac:BillingReference"/>
									
								</xsl:if>
								
							</td>
						</tr>
					</xsl:if>

				<!-- Allowances and charges on document level: -->
				<xsl:if test="cac:AllowanceCharge !='' ">
					<tr>

						<td colspan="8">

							<hr size="2"/>
						</td>

					</tr>


					<tr>

						<td colspan="8">

							<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='DocLevelAllowanceChargeInf']/g-lang[lang($pLang)]"/></h2>

						</td>

					</tr>

					<tr>

						<td valign="top" colspan="2">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceOrChargeIndicator']/g-lang[lang($pLang)]"/></b>

						</td>

						<td valign="top" colspan="2">
							<xsl:if test="cac:AllowanceCharge/cbc:AllowanceChargeReasonCodeType !=''">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceOrChargeReasonCode']/g-lang[lang($pLang)]"/></b>
							</xsl:if>
						</td>

						<td valign="top" colspan="2">

							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceOrChargeReason']/g-lang[lang($pLang)]"/></b>

						</td>
						<td valign="top">

							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceOrChargeTax']/g-lang[lang($pLang)]"/></b>

						</td>
						<td valign="top" align="right">

							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceOrChargeAmount']/g-lang[lang($pLang)]"/></b>

						</td>

					</tr>

						<xsl:apply-templates select="cac:AllowanceCharge" mode="DocumentLevel-new"/>


				</xsl:if>

			<!-- End of invoice header -->


			<!-- Start tax totals: -->
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>

					<tr>
						<td valign="top" colspan="2">
						<h2>
							<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxInfo']/g-lang[lang($pLang)]"/>
						</h2>

						</td>

						<td valign="top" colspan="2">
							<xsl:if test="cbc:TaxPointDate !=''">
								<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxPointDate']/g-lang[lang($pLang)]"/></b>

								&#160;<xsl:value-of select="cbc:TaxPointDate"/>
							</xsl:if>

						</td>

						<td valign="top" colspan="4">

							<xsl:if test="cbc:TaxCurrencyCode !=''">
								<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxCurrencyCode']/g-lang[lang($pLang)]"/></b>

								&#160;<xsl:value-of select="cbc:TaxCurrencyCode"/>

								<xsl:if test="cbc:TaxCurrencyCode/@listID !='ISO4217'">
									<small>&#160;[<xsl:value-of select="cbc:TaxCurrencyCode/@listID"/> - invalid listID]</small>

								</xsl:if>
							</xsl:if>

							<xsl:if test="cac:TaxExchangeRate !='' ">
								<small>
								<br/>
									&#160;<xsl:apply-templates select="cac:TaxExchangeRate"/>
								</small>
							</xsl:if>

						</td>

					</tr>

					<xsl:if test="cac:TaxTotal">
						<tr class="TAXInformationHeader">
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TAXCategoryIDInf']/g-lang[lang($pLang)]"/>
								</b>
							</td>
							<td valign="top" colspan="2">
								<xsl:if test="cac:TaxSubTotal/cac:TaxCategory/cbc:TaxExemptionReason !='' ">
								<b>
									
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxExemptionReason']/g-lang[lang($pLang)]"/>
								</b>
								</xsl:if>
							</td>
							<td valign="top" colspan="2">
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TaxableAmountInf']/g-lang[lang($pLang)]"/>
								</b>
							</td>
							<td valign="top" align="right">
								<xsl:if test="cac:TaxSubTotal/cbc:TransactionCurrencyAmount !='' ">
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TransactionCurrencyTaxAmount']/g-lang[lang($pLang)]"/>
								</b>
								</xsl:if>
							</td>
							<td valign="top" align="right">
								<b>
									<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='TAXAmountInf']/g-lang[lang($pLang)]"/>
								</b>
							</td>

						</tr>
						<xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>

					</xsl:if> 
			<!--End document taxes -->




			<!-- Start document totals: -->

					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>
					

					<!-- Fix document totals -->
				<tr>

					<td valign="top" colspan="7">

						<h2> <xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='DocTotals']/g-lang[lang($pLang)]"/> </h2>

					</td>

					<td valign="top" align="right">

						<xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">

							<small>

								<b> <xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PayableRoundingAmount']/g-lang[lang($pLang)]"/></b>

						<br/>
							<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount"/>
							&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount/@currencyID"/>

							</small>
						</xsl:if>

					</td>

				</tr>

				<xsl:apply-templates select="cac:LegalMonetaryTotal" mode="New"/>


			<!-- Start on PAYMENT TERMS information -->
					<xsl:if test="cac:PaymentTerms !=''">
					<tr>
						<td colspan="8">
							<hr size="2"/>
						</td>
					</tr>

			
					<tr>
						<td valign="top" colspan="2">

							<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentTerms']/g-lang[lang($pLang)]"/>
							</h2>

						</td>

						<td valign="top" colspan="6">

							<table>

								<xsl:apply-templates select="cac:PaymentTerms"/>
							</table>

						</td>

					</tr>
					</xsl:if>
			<!-- End of PAYMENT TERMS information -->


			<!-- Start on PAYMENT MEANS information -->
					<xsl:if test="cac:PaymentMeans !=''">
						<tr>
							<td colspan="8">
								<hr size="2"/>
							</td>
						</tr>
					<tr>

						<td valign="top" colspan="4">
							<h2><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentMeans']/g-lang[lang($pLang)]"/>
							</h2>
						</td>

					</tr>

					<tr>

						<td valign="top">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentMeansCode']/g-lang[lang($pLang)]"/></b>&#160;&#160;
						</td>
						<td valign="top">
							<xsl:if test="cac:PaymentMeans/cbc:PaymentChannelCode !=''">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentChannelCode']/g-lang[lang($pLang)]"/></b>
							</xsl:if>
						</td>
						<td valign="top" colspan="2">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PayeeFinancialAccountID']/g-lang[lang($pLang)]"/></b>
 
						</td>
						<td valign="top" colspan="2">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='FinancialInstitutionID']/g-lang[lang($pLang)]"/></b>

						</td>
						<td valign="top">
							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentRef']/g-lang[lang($pLang)]"/></b>

						</td>
						<td valign="top" align="right">

							<b><xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PaymentDueDate']/g-lang[lang($pLang)]"/></b>
						</td>

					</tr>


					<xsl:apply-templates select="cac:PaymentMeans"/>
			<!-- End of PAYMENT MEANS information -->
						</xsl:if>
				</table>


			<!--Start Invoice & Credit Note line-->
				<table border="0" width="100%" cellspacing="0" cellpadding="2">

					<tr>
						<td colspan="9">
							<hr size="2"/>
						</td>
					</tr>

					<tr class="UBLInvoiceLineHeader">
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='LineID']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='SellersItemIdentification']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='ItemName']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top" align="right">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='Quantity']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='QuantityUnitCode']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='PriceUnit']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='LineTaxDetails']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='AllowanceCharge(Line)']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
						<td align="right" valign="top">
							<h2>
								<xsl:value-of select="$moduleDoc/module/document-merge/g-funcs/g[@name='LineExtensionAmountLine']/g-lang[lang($pLang)]"/>
							</h2>
						</td>
					</tr>
					<xsl:apply-templates select="cac:InvoiceLine | cac:CreditNoteLine"/>
				</table>
				<!--End Invoice & Credit Note line -->





			</body>
		</html>
	</xsl:template>


	

</xsl:stylesheet>
