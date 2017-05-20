package main.java.fobu.common.util;

import java.util.Enumeration;
import java.util.Hashtable;

public class AjaxPageSplit {

	private static String defaultTemplate = null;
		
	static {
		StringBuffer defaultTemplateBuff = new StringBuffer();
		defaultTemplateBuff.append("<!--FRONT_START-->");
		//defaultTemplateBuff.append("<a <!--FIRST_LINK--> class='btn_first'><span>맨앞</span></a>");
		//defaultTemplateBuff.append("<a <!--PREV_LINK--> class='btn_prev'><span>이전</span></a>");
		defaultTemplateBuff.append("<a <!--FIRST_LINK--> > ◀ </a>");
		defaultTemplateBuff.append("<a <!--PREV_LINK--> > ◁ </a>");
		defaultTemplateBuff.append("<!--FRONT_END-->");
		defaultTemplateBuff.append("<!--LOOP_START--><!--PAGE_LINK--><!--PAGE_NUMBER--><!--LOOP_END-->");
		defaultTemplateBuff.append("<!--BACK_START-->");
//		defaultTemplateBuff.append("<a <!--NEXT_LINK--> class='btn_next'><span>다음</span></a>");
//		defaultTemplateBuff.append("<a <!--LAST_LINK--> class='btn_last'><span>맨뒤</span></a>");
		defaultTemplateBuff.append("<a <!--NEXT_LINK--> > ▷ </a>");
		defaultTemplateBuff.append("<a <!--LAST_LINK--> > ▶ </a>");
		defaultTemplateBuff.append("<!--BACK_END-->");
		defaultTemplate = defaultTemplateBuff.toString();
	}
	
	public String getSplitPageLink(int total, int page, int scale, int pageScale, String url) {

		// check template and default splitLinkString
		String linkHtmlContent = defaultTemplate;
		
		// basic info
		if(total == 0)	{ return "";  } // { total = 1;}
		int totalPageCount = getTotalPageCount(total, scale);
		int startPage = getFirstPage(totalPageCount, page, pageScale);
		int repeatCount = getRepeatCount(totalPageCount, page, pageScale);	
		int endPage = startPage + repeatCount;
		int previousPage = getPreviousPage(totalPageCount, page, pageScale);
		int nextPage = getNextPage(totalPageCount, page, pageScale);
			
		// make one line string
		linkHtmlContent = StringUtil.replace(linkHtmlContent, "\n", "");
		// System.out.println("linkHtmlContent:"+linkHtmlContent);
		
		// replace first, prev, next, last Factor
		Hashtable<String, String> partsHash = new Hashtable<String, String>();
		//String pageDelim = ((url).indexOf("?") >= 0) ? "&" : "?";
		
		if (isFirstPageSet(totalPageCount, page, pageScale)) {
			linkHtmlContent = StringUtil.replaceByPattern(linkHtmlContent, "<!--FRONT_START-->.*?<!--FRONT_END-->", "");
		} else {
			partsHash.put("FIRST_LINK", "href=\"javascript:ajaxPageSplit('1');\" ");
			partsHash.put("PREV_LINK" , "href=\"javascript:ajaxPageSplit('"+previousPage +"');\" ");
		}
		
		if (isLastPageSet(totalPageCount, page, pageScale)) {
			// remove back icons (next icon And last icon)
			linkHtmlContent = StringUtil.replaceByPattern(linkHtmlContent, "<!--BACK_START-->.*?<!--BACK_END-->", "");
		} else {
			partsHash.put("NEXT_LINK" , "href=\"javascript:ajaxPageSplit('"+nextPage+"');\" ");
			partsHash.put("LAST_LINK" , "href=\"javascript:ajaxPageSplit('"+totalPageCount+"');\" ");			
		}
		
		Enumeration<String> enum1 = partsHash.keys();
		while (enum1.hasMoreElements()) {
			String key = (String)enum1.nextElement();
			linkHtmlContent = StringUtil.replaceByPattern(linkHtmlContent, "<!--" + key + "-->", (String)partsHash.get(key));
		}
		
		// cut number line template
		StringBuffer numberLinkBuff = new StringBuffer();
		
		for (int i=startPage; i < endPage; i++) {
			if (i == page) {
				//numberLinkBuff.append("<li class='on'>");
				numberLinkBuff.append("<a href='#' class='on'>");
				numberLinkBuff.append(i);
				numberLinkBuff.append("</a>");
				//numberLinkBuff.append("</li>");
			} else {
//				numberLinkBuff.append("<li><a href=\"");
//				numberLinkBuff.append("&nbsp;");
//				numberLinkBuff.append("<b>");
				numberLinkBuff.append("<a href=\"javascript:ajaxPageSplit('");
//				numberLinkBuff.append(url);
//				numberLinkBuff.append(pageDelim);
//				numberLinkBuff.append("page=");
				numberLinkBuff.append(i);
				numberLinkBuff.append("');\">");
				numberLinkBuff.append(i);
				numberLinkBuff.append("</a>");
//				numberLinkBuff.append("</b>");
//				numberLinkBuff.append("&nbsp;");
//				numberLinkBuff.append("</a></li>");
			}
		}
		
		// Replace numberLinkBuffer between <!--LOOP_START--> AND <!--LOOP_END-->
		String loopStart = "<!--LOOP_START-->";
		String loopEnd   = "<!--LOOP_END-->";
		linkHtmlContent = StringUtil.replaceByPattern(linkHtmlContent, loopStart + ".*?" + loopEnd, numberLinkBuff.toString());
		
		return linkHtmlContent;
	}

	/**
	* 총 페이지 갯수를 얻는다.
	*/
	public int getTotalPageCount(int total, int scale) {
		int remainder = total % scale;
		int quotient = total / scale;
		
		return (remainder > 0) ? quotient + 1 : quotient; 
	}

	/**
	* 나머지 페이지 갯수를 얻는다.
	*/
	public int getPageRemainder(int totalPageCount, int pageScale) {
		int remainder = totalPageCount % pageScale;
		
		return remainder; 
	}
	
	/**
	* 몫을 얻는다.
	*/
	public int getPageQuotient(int totalPageCount, int pageScale) {
		int quotient = totalPageCount / pageScale;
		
		return quotient; 
	}
	

	/**
	* 현재 페이지가 소속된 페이지 묶음의 첫번째 페이지 번호를 얻는다.
	*/
	public int getFirstPage(int totalPageCount, int page, int pageScale) {
		int remainder = page % pageScale;
		int quotient = page / pageScale;
		return (remainder > 0) ? (quotient * pageScale)+1 : ((quotient-1) * pageScale)+1; 
	}

	/**
	* 현재 페이지 묶음의 요소 갯수(반복 횟수)
	*/
	public int getRepeatCount(int totalPageCount, int page, int pageScale) {
		int repeatCount = -1;
		// 다음 pageSet 의 첫번째 번호
		if (isLastPageSet(totalPageCount, page, pageScale)) {
			repeatCount = (getPageRemainder(totalPageCount, pageScale) == 0) ? pageScale : getPageRemainder(totalPageCount, pageScale);
		} else {
			repeatCount = pageScale;
		}
		
		return repeatCount;
	}
	
	/**
	* 이전 페이지 묶음의 가장 뒷쪽 페이지
	*/
	public int getPreviousPage(int totalPageCount, int page, int pageScale) {
		int previousPage = -1;
		if (getCurrentPageSet(page, pageScale) > 1) {
			previousPage = getFirstPage(totalPageCount, page, pageScale) - 1;
		}
		return previousPage;
	}

	/**
	* 다음 페이지 묶음의 첫번째 페이지를 얻어온다.
	*/
	public int getNextPage(int totalPageCount, int page, int pageScale) {
		int nextPage = -1;
		
		if (!isLastPageSet(totalPageCount, page, pageScale)) {
			nextPage = getFirstPage(totalPageCount, page, pageScale) + pageScale;
		}
		return nextPage;
	}

	/**
	* 페이지 번호로 현재 페이지 묶음을 얻어온다.
	*/
	public int getCurrentPageSet(int page, int pageScale) {
		int remainder = page % pageScale;
		int quotient = page / pageScale;
		
		return (remainder > 0) ? quotient + 1 : quotient; 
	}
	
	/**
	* 총 페이지 묶음의 값을 얻어온다.
	*/
	public int getTotalPageSetCount(int totalPageCount, int pageScale) {
		int remainder = totalPageCount % pageScale;
		int quotient = totalPageCount / pageScale;
		return (remainder > 0) ? quotient + 1 : quotient; 
	}

	/**
	* 현재 페이지 묶음이 첫번째면 true
	*/
	public boolean isFirstPageSet(int totalPageCount, int page, int pageScale) {
		boolean firstPageSetFlag = false;
		
		if (getFirstPage(totalPageCount, page, pageScale) == 1) {
			firstPageSetFlag = true;	
		}	
		return firstPageSetFlag;
	}

	/**
	* 현재 페이지 묶음이 마지막이면 true;
	*/
	public boolean isLastPageSet(int totalPageCount,  int page, int pageScale) {
		boolean lastPageSetFlag = false;
		
		int currentPageSet = getCurrentPageSet(page, pageScale);
		int totalPageSetCount = getTotalPageSetCount(totalPageCount, pageScale);
		if (currentPageSet == totalPageSetCount) {
			lastPageSetFlag = true;		
		}
		return lastPageSetFlag;
	}
}