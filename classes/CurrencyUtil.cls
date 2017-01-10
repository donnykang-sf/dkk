public class CurrencyUtil {
    // 中文金额单位数组
    static List<String> straChineseUnit = new List<String>{'分', '角', '元', '拾', '佰', '仟', '万', '拾', '佰', '仟', '亿', '拾', '佰', '仟'};
    //中文数字字符数组(大写)
    static List<String> straChineseNumber = new List<String>{'零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'};
    //中文数字字符数组(小写)
    static List<String> straChineseNumberSimple = new List<String>{'〇', '一', '二', '三', '四', '五', '六', '七', '八', '九'};

    /**
    * Description   将数字金额转换为中文金额
    * @param        <p>amount 转换前的数字金额</P>
    * @return       String
    * 调用： toChineseCurrency("101.89")="壹佰零壹圆捌角玖分"
    *       toChineseCurrency("100.89")="壹佰零捌角玖分"
    *       toChineseCurrency("100")="壹佰圆整"
    */

    public static String toChineseCurrency(Decimal dAmount){
        // 将decimal转换为Double
        Double amount = dAmount.longValue();

        String strChineseCurrency = '';
        //零数位标记
        Boolean bZero = true;
        //中文金额单位下标
        Integer ChineseUnitIndex = 0;

        try {
            if (amount == 0) return '零元整';

            //是否为负数
            Boolean negativeNumber = amount < 0;
            //Amount * 100 后取整
            String doubMoneyNumber = String.valueOf(Math.abs(Math.roundToLong(amount * 100)));
            System.debug(doubMoneyNumber);

            while (doubMoneyNumber.length() > 0){
                //整的处理
                if (ChineseUnitIndex == 2 && strChineseCurrency.length() == 0)
                    strChineseCurrency = strChineseCurrency + '整';

                String lastNumber = doubMoneyNumber.substring(doubMoneyNumber.length()-1);
                //非零数位的处理
                if (lastNumber != '0' ) {
                    strChineseCurrency = straChineseNumber[Integer.valueOf(lastNumber)] + straChineseUnit[ChineseUnitIndex] + strChineseCurrency;
                    bZero = false;
                }
                //零数位的处理
                else {
                    //元的处理(个位)
                    if (ChineseUnitIndex == 2 ) {
                        //段中有数字
                        if (doubMoneyNumber.length() > 0) {
                            strChineseCurrency = straChineseUnit[ChineseUnitIndex] + strChineseCurrency;
                            bZero = true;
                        }
                    }
                    //万、亿数位的处理
                    else if (ChineseUnitIndex == 6 || ChineseUnitIndex == 10) {
                        //段中有数字
                        if (doubMoneyNumber.length() > 1)
                            strChineseCurrency = straChineseUnit[ChineseUnitIndex] + strChineseCurrency;
                    }
                    //前一数位非零的处理
                    if (!bZero)
                        strChineseCurrency = straChineseNumber[0] + strChineseCurrency;

                    bZero = true;
                }

                doubMoneyNumber = doubMoneyNumber.substring(0, doubMoneyNumber.length()-1);
                ChineseUnitIndex ++;
            }

            //负数的处理
            if (negativeNumber)
                strChineseCurrency = '负' + strChineseCurrency;

            strChineseCurrency = strChineseCurrency.replace('零万', '万');
            strChineseCurrency = strChineseCurrency.replace('零亿', '亿');

        } catch (Exception ex){
            return '中文金额错误';
        }

        return strChineseCurrency;
    }

}