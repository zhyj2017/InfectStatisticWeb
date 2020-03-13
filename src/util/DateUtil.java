package util;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.regex.Pattern;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class DateUtil {
	public static int getNum(String param) {
		Pattern pattern = Pattern.compile("\\d+");
		java.util.regex.Matcher matcher = pattern.matcher(param);
		while (matcher.find()) {
			return Integer.parseInt(matcher.group(0));
		}
		return -1;
	}
	public static String getYesterday(String param) throws java.text.ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        Date date=null;
        try {
            date = sdf.parse(param);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        calendar.setTime(date);
        int day=calendar.get(Calendar.DATE);
        //此处修改为+1则是获取后一天
        calendar.set(Calendar.DATE,day-1);
 
        String lastDay = sdf.format(calendar.getTime());
        return lastDay;
	}
	
	public static String getNxetday(String param) throws java.text.ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        Date date=null;
        try {
            date = sdf.parse(param);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        calendar.setTime(date);
        int day=calendar.get(Calendar.DATE);
        //此处修改为-1则是获取前一天
        calendar.set(Calendar.DATE,day+1);
 
        String lastDay = sdf.format(calendar.getTime());
        return lastDay;
	}
	
}
