package main.java.fobu.common.util;

import org.apache.regexp.RE;
import org.apache.regexp.RESyntaxException;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

/**
 * String 처리를 위한 함수 모음
 */
public class StringUtil {
	
	private static String charSet = "MS949";
	private static final String DEFAULT_CHARSET = "UTF-8";
    private static final String KOR_CHARSET = "EUC-KR";
    private static final String ENG_CHARSET = "ISO-8859-1";
	
	private StringUtil() {
	}
	
    public static String replaceAll(String text, String oldChar, String newChar) {
        String newText = text;
        if (text != null) {
            StringBuffer sb = new StringBuffer((int)(text.length() * 1.5));
            int index = 0;
            while ( (index = text.indexOf(oldChar)) > -1) {
                sb.append(text.substring(0, index));
                sb.append(newChar);
                if (index + oldChar.length() < text.length()) {
                    text = text.substring(index + oldChar.length());    
                } else {
                    text = "";
                    break;
                }
            }
            sb.append(text);
            newText = sb.toString();
            
        }
        return newText;
    }

	public static String crop(String source, int length, String tail, String charset) throws UnsupportedEncodingException {
		if (source == null) return null;
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes(charset).length > length) {
		    length = length - tail.length();
			while ( (bLength + 1) <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
	}

	public static String crop(String source, int length, String tail) {
		if (source == null) return null;
		
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes().length > length) {
		    length = length - tail.length();
			while ( (bLength + 1)  <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
		
	}
	
	public static String htmlCrop(String str, int length, String tail) {
		StringBuffer result = new StringBuffer();

		int remain = length;
		int position = 0;
		int bIndex = -1;
		int eIndex = -1;
		String temp = str;
		
		while (position < temp.length()) {
			bIndex = temp.indexOf("<");
			eIndex = temp.indexOf(">", bIndex);
			
			if (bIndex > -1) {
				if (remain > 0) {
					result.append(crop(temp.substring(0, bIndex), remain, tail));
				}
				if (bIndex < eIndex) {
					position = eIndex + 1;
					result.append(temp.substring(bIndex, position));
					temp = temp.substring(position);
				} else {
					if (remain > 0) {
						result.append(crop(temp, remain, tail));
						temp = "";
					}
				}	
			} else {
				if (remain > 0) {
					result.append(crop(temp, remain, tail));
						temp = "";
				}
				position = temp.length();
			}
		}

		if (remain > 0) {
			result.append(crop(temp, remain, tail));
		}
		
		return result.toString();
	}
/*
	public static String[] toStringArray(String str, String delimiter) {
        String[] result = null;
        if (str != null) {
            Tokenizer t = new Tokenizer(str, delimiter);
            result = new String[t.countTokens()];
            for( int i = 0; t.hasMoreTokens(); i++) {
                result[i] = t.nextToken();
            }            
        }
		return result;
	}

	public static int[] toIntArray(String str, String delimiter, int defaultIntValue) {
		Tokenizer t = new Tokenizer(str, delimiter);
		int[] result = new int[t.countTokens()];
		for( int i = 0; t.hasMoreTokens(); i++) {
			result[i] = TypeConvertUtil.convertInt(t.nextToken(), defaultIntValue);
		}
		return result;
	}
*/
	public static String encode(String s) 	{
		return encode(s, charSet) ;
	}

	public static String encode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;
		
		try { 
			out = new String(s.getBytes("8859_1"), charset);
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}	

	public static String decode(String s) 	{
		return decode(s, charSet) ;
	}

	public static String decode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;
		try { 
			out = new String(s.getBytes(charset), "8859_1");
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}
	
	/*
	 * null 이면 true
	 */
	public static boolean isNull(String value) {
		if(value != null && !value.trim().equals("")) {
			return false;
		} else {
			return true;
		}
	}
	
	public static String makeRandomString(int strLength)
	{
		//임시비번 update
		String result = "";
		String letter[] = {"A","B","C","D","E","F","G","H","I","J","K","M","N","P","Q","R","S","T","U","V","W","X","Y","2","3","4","5","6","7","8","9"};
		Random rn = new Random();
		
		for(int i=0; i<strLength; i++)
		{
			result = result + letter[rn.nextInt(letter.length)];
		}
		
		return result;
	}
	
	/**
	 * string split, godbasic[2010.03.09]
	 * @param sourceString
	 * @param token
	 * @return
	 */
	public static String[] split( String sourceString, String token) {
		String[] strData = sourceString.split("[" + token + "]");
		return strData;
	}
	
	/**
	 * parameter -> map, godbasic[2010.03.09]
	 * @param request
	 * @return
	 */
	public static Map<String, String> getParameterMap(HttpServletRequest request){
		Map<String, String> parameterMap = new HashMap<String, String>();
		Enumeration<String> enums = request.getParameterNames();
		while(enums.hasMoreElements()){
			String paramName = (String)enums.nextElement();
			String[] parameters = request.getParameterValues(paramName);
			parameterMap.put(paramName, parameters[0]);
		}
		return parameterMap; 
	}
	
	public static Map<String, Object> getParameterMap2(HttpServletRequest request){
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Enumeration<String> enums = request.getParameterNames();
		while(enums.hasMoreElements()){
			String paramName = (String)enums.nextElement();
			Object[] parameters = request.getParameterValues(paramName);
			parameterMap.put(paramName, parameters[0]);
		}
		return parameterMap; 
	}
	
	public static Map<String, String> getAjaxParameterMap(HttpServletRequest request){
		Map<String, String> parameterMap = new HashMap<String, String>();
		Enumeration<String> enums = request.getParameterNames();
		String[] paramNames = enums.nextElement().split("&");
		for (String str : paramNames) {
			String[] param = str.split("=");
			if(param.length == 2 )parameterMap.put(param[0], param[1]);
		}
		return parameterMap; 
	}
	
	public static String encodeKor(String param){
		try {
			if(isNull(param)) return "";
			return URLEncoder.encode(param, "euc-kr");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}
	}
	
	public static String decodeKor(String param){
		try {
			if(isNull(param)) return "";
			return URLDecoder.decode(param, "euc-kr");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}
	}
	/*
	public static String numberFormat(String str, String format)
	{
	    DecimalFormat df = new DecimalFormat(format);//("#,##0.00");
	    return df.format(TypeConvertUtil.convertDouble(str, 0));
	}
	*/
	
	// SMS문자전송시 문자내용을 자르기위해 사용 2010.06.10.
	public static String[] parseStringByBytes(String raw, int len) {        
        if (raw == null) return null;
        String[] ary = null;
        try {
            // raw 의 byte
            byte[] rawBytes = raw.getBytes();
            int rawLength = rawBytes.length;
            
            int index = 0;
            int minus_byte_num = 0;
            int offset = 0;            
            
            if(rawLength > len){
                int aryLength = (rawLength / len) + (rawLength % len != 0 ? 1 : 0);
                ary = new String[aryLength];

                for(int i=0; i<aryLength; i++){
                    minus_byte_num = 0;
                    offset = len;
                    if(index + offset > rawBytes.length){
                        offset = rawBytes.length - index;
                    }
                    for(int j=0; j<offset; j++){                        
                        if(((int)rawBytes[index + j] & 0x80) != 0){
                            minus_byte_num ++;
                        }
                    }                    
                    if(minus_byte_num % 3 != 0){
                        offset -= minus_byte_num % 3;
                    }                    
                    ary[i] = new String(rawBytes, index, offset);                    
                    index += offset ;
                    
                }                
            } else {
                ary = new String[]{raw};
            }                
        } catch(Exception e) {
            System.out.println("parseStringByBytes Exception : " + e);
        }                    
        return ary;
    }
	
	 public static String replace(String original, String find, String replace) {
		if(original==null || find==null || replace==null || original.length()<1 || find.length()<1) return original; 
		int index=-1, fromIndex=0, tempIndex;
		StringBuffer sb=new StringBuffer();
		while((tempIndex=original.indexOf(find, fromIndex))>=0)	{
			index=tempIndex;
			sb.append(original.substring(fromIndex, index)).append(replace);
			fromIndex=index+find.length();
		}
		if(sb.length()<1) return original;
		
		sb.append(original.substring(index+find.length()));
		return sb.toString();
	}
	 
	 public static String replaceInt(String original, String find, String replace) {
			if(original==null || find==null || replace==null || original.length()<1 || find.length()<1) return "0"; 
			int index=-1, fromIndex=0, tempIndex;
			StringBuffer sb=new StringBuffer();
			while((tempIndex=original.indexOf(find, fromIndex))>=0)	{
				index=tempIndex;
				sb.append(original.substring(fromIndex, index)).append(replace);
				fromIndex=index+find.length();
			}
			if(sb.length()<1) return original;
			
			sb.append(original.substring(index+find.length()));
			return sb.toString();
		}
	 /**
		 * 
		 * 정규식을 사용하여 replace 를 수행한다.
		 * Ex) TagKiller Patter : <.*?>
		 * 
		 * @param text 패턴을 적용할 원본 문자열
		 * @param pattern Regular Expression Pattern
		 * @param newStr 대치할 문자열
		 * @param ignoreCase 대소문자 무시 여부
		 * @return 패턴에 맞는 문자열을 newStr 로 대치한 전체 문자열
		 * 
		 */
		public static String replaceByPattern(String text, String pattern, String newStr, boolean ignoreCase) {
			try {
				String retString = text;
				RE reg = null;
				
				reg = (ignoreCase) ? 
					new RE(pattern, RE.MATCH_CASEINDEPENDENT) :
					new RE(pattern);

				if (reg.match(text)) {
					retString = reg.subst(text, newStr);
				}
				return retString;
			} catch (RESyntaxException e) { 
				e.printStackTrace();
				return text;
			}		
		}
		
		/**
		 * 
		 * 정규식을 사용하여 replace 를 수행한다. (대소문자 무시)
		 * 
		 * @param text 패턴을 적용할 원본 문자열
		 * @param pattern Regular Expression Pattern
		 * @param newStr 대치할 문자열
		 * @return 패턴에 맞는 문자열을 newStr 로 대치한 전체 문자열
		 * 
		 */
		public static String replaceByPattern(String text, String pattern, String newStr) {
			return replaceByPattern(text, pattern, newStr, true);
		}
		
		public static String nullToString(String str, String replaceStr) {
			return (str == null || "".equals(str))? replaceStr:str;
		}
		
		 public static String kor2Eng(String korean) {
		        String english = null;

		        if (korean == null ) {
		            return null;
		        }

		        try {
		            english = new String(korean.getBytes(KOR_CHARSET), ENG_CHARSET);
		        } catch (UnsupportedEncodingException e) {
		            english = new String(korean);
		        }

		        return english;
		    }

}
