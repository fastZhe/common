
import java.io.*;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.PriorityQueue;
import java.util.Random;

public class GenerateTestData {
    public static void main(String[] args) throws UnsupportedEncodingException, ParseException {
        int lines=3;
        String file="./test.txt";
        try {
            if(args.length>1){
                file=args[0];
            }
            BufferedWriter bf=new BufferedWriter(new FileWriter(new File(file)));
            if(args.length==2){
                lines=Integer.parseInt(args[1]);
            }
            for(int i=0;i<lines;i++){
                if(i==0){
                    bf.write(generateLine(i+1));
                    continue;
                }
                bf.newLine();
                //bf.write("\r\n");
                bf.write(generateLine(i+1));
            }
            bf.flush();
            bf.close();




        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static String generateLine(int index) throws ParseException {
        NumberFormat Nformat=NumberFormat.getInstance();
        // 设置小数位数。
        Nformat.setMaximumFractionDigits(2);
        // 执行格式化转换。
        SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Random r=new Random();
        StringBuffer a=new StringBuffer();
        for(int i=1;i<=100;i++){
            if (i==1){
                a.append(index);
                continue;
            }
            a.append(",");
            if(i<=10){
                a.append(r.nextInt(10000));
                continue;
            }
            if(i<=30){
                a.append(sf.format(randomDate("2011-10-11","2017-11-10")));
                continue;
            }
            if(i<=40){
                a.append(r.nextInt(10000)+Nformat.format(r.nextDouble()));
                continue;
            }
            a.append(getRandomString(18));
        }

        return a.toString();
    }



    public static String getRandomString(int length){
        String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random=new Random();
        StringBuffer sb=new StringBuffer();
        for(int i=0;i<length;i++){
            int number=random.nextInt(62);
            sb.append(str.charAt(number));
        }
        return sb.toString();
    }


    private static Date randomDate(String beginDate,String endDate){
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date start = format.parse(beginDate);
            Date end = format.parse(endDate);

            if(start.getTime() >= end.getTime()){
                return null;
            }

            long date = random(start.getTime(),end.getTime());

            return new Date(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static long random(long begin,long end){
        long rtn = begin + (long)(Math.random() * (end - begin));
        if(rtn == begin || rtn == end){
            return random(begin,end);
        }
        return rtn;
    }

}
