
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';

import 'Colors.dart';

class headingText extends StatelessWidget {
  headingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:white,fontFamily:"railBold",
        fontSize:14.sp,letterSpacing:1),);
  }


}
class headingText1 extends StatelessWidget {
  headingText1({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:ColorConstants.DarkBlueColor,fontFamily:"railBold",
        fontSize:14.sp,letterSpacing:1),);
  }


}

class headingTextwhite extends StatelessWidget {
  headingTextwhite({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:white,fontFamily:"railBold",
        fontSize:12.sp,letterSpacing:1),);
  }


}

class headingTextwithsmallwhite extends StatelessWidget {
  headingTextwithsmallwhite({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w400,color:white,fontFamily:"railBold",
        fontSize:12.sp,letterSpacing:1),);
  }


}

class headingTextwithminiwhite extends StatelessWidget {
  headingTextwithminiwhite({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w400,color:white,fontFamily:"railBold",
        fontSize:10.sp,letterSpacing:1),);
  }


}
class headingTextwithsmallwhitebold extends StatelessWidget {
  headingTextwithsmallwhitebold({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.bold,color:white,fontFamily:"railBold",
        fontSize:12.sp,letterSpacing:1),);
  }


}

class headingTextwithsmalldark extends StatelessWidget {
  headingTextwithsmalldark({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w400,color:ColorConstants.DarkBlueColor,fontFamily:"railBold",
        fontSize:12.sp,letterSpacing:1),);
  }


}


class headingTextwithsmallwhite2 extends StatelessWidget {
  headingTextwithsmallwhite2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:white,fontFamily:"railBold",
        fontSize:10.sp,letterSpacing:1),);
  }


}

class headingTextDarkblue extends StatelessWidget {
  headingTextDarkblue({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:ColorConstants.white,fontFamily:"railBold",
        fontSize:14.sp,letterSpacing:1),);
  }


}

class headingTextDarkblueWithSmall extends StatelessWidget {
  headingTextDarkblueWithSmall({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:ColorConstants.white,fontFamily:"railBold",
        fontSize:12.sp,letterSpacing:1),);
  }


}

class headingTextDarkblueWithextrasmall extends StatelessWidget {
  headingTextDarkblueWithextrasmall({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:ColorConstants.DarkBlueColor,fontFamily:"railBold",
        fontSize:10.sp,letterSpacing:1),);
  }


}


class DialogFieldText extends StatelessWidget {
  DialogFieldText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railBold",
      fontSize:12.sp,),maxLines: 3,);
  }


}
class DialogField2Text extends StatelessWidget {
  DialogField2Text({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railLight",
      fontSize:10.sp,));
  }


}
class FieldText extends StatelessWidget {
  FieldText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black,fontFamily:"railLight",
        fontSize:10.sp,),overflow:TextOverflow.ellipsis,);
  }


}
class FieldTextHint extends StatelessWidget {
  FieldTextHint({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railLight",
      fontSize:10.sp,),overflow:TextOverflow.ellipsis,);
  }


}
class headingTextOne extends StatelessWidget {
  headingTextOne({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w600,color:white,fontFamily:"railLight",
        fontSize:17.sp,letterSpacing:1),);
  }


}
class headingTextthree extends StatelessWidget {
  headingTextthree({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:white,fontFamily:"railLight",
        fontSize:20.sp,letterSpacing:1),);
  }


}
class headingTextTwo extends StatelessWidget {
  headingTextTwo({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:white,fontFamily:"railLight",
        fontSize:15.sp,letterSpacing:1),);
  }


}
class headingTextThree extends StatelessWidget {
  headingTextThree({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:white,fontFamily:"railLight",
        fontSize:12.sp,letterSpacing:1),maxLines: 2,overflow:TextOverflow.ellipsis,);
  }


}
class superolusheadingText extends StatelessWidget {
  superolusheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:white,fontFamily:"railLight",
        fontSize:18.sp,letterSpacing:1),textAlign: TextAlign.center,);
  }


}
class superheadingText extends StatelessWidget {
  superheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,fontFamily:"railLight",
        fontSize:13.sp),);
  }


}
class subheadingText extends StatelessWidget {
  subheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:ColorConstants.deppp,fontSize:11.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),);
  }


}

class subheadingTextDialog extends StatelessWidget {
  subheadingTextDialog({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:ColorConstants.white,fontSize:11.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),);
  }


}

class subheadingText1 extends StatelessWidget {
  subheadingText1({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:ColorConstants.white,fontSize:11.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),);
  }


}

class subheadingText2 extends StatelessWidget {
  subheadingText2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:ColorConstants.DarkBlueColor,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),);
  }


}

class subheadingTextBOLD extends StatelessWidget {
  subheadingTextBOLD({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11.sp,fontFamily:"railBold"),);
  }


}

class subheadingTextBOLD3 extends StatelessWidget {
  subheadingTextBOLD3({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:13.sp,fontFamily:"railBold"),);
  }


}

















class subheadingTextBOLD2 extends StatelessWidget {
  subheadingTextBOLD2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        color: Colors.white, fontSize: 15.sp, fontFamily: "railBold"),);
  }
}
class boxtextBold extends StatelessWidget {
  boxtextBold({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:10.sp,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldH2 extends StatelessWidget {
  boxtextBoldH2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:13.sp,fontWeight:FontWeight.w500,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldH1 extends StatelessWidget {
  boxtextBoldH1({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:13.sp,fontWeight:FontWeight.w500,fontFamily:"railLight"),textAlign:TextAlign.center,);
  }


}
class boxtextSmall extends StatelessWidget {
  boxtextSmall({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:8.sp,fontFamily:"railLight"),textAlign:TextAlign.center,);
  }


}
class boxtextMediumBold extends StatelessWidget {
  boxtextMediumBold({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:9.sp,fontFamily:"railBold"),textAlign:TextAlign.justify,maxLines: 2,overflow:TextOverflow.ellipsis,);
  }


}
class boxtextMedium extends StatelessWidget {
  boxtextMedium({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:9.sp,fontFamily:"railLight"),textAlign:TextAlign.justify,maxLines: 2,overflow:TextOverflow.ellipsis);
  }


}
class boxtextBoldUnderline extends StatelessWidget {
  boxtextBoldUnderline({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11.sp,fontWeight:FontWeight.w500,decoration:TextDecoration.underline,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldStart extends StatelessWidget {
  boxtextBoldStart({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:9.sp,fontWeight:FontWeight.w500,fontFamily:"railBold"),textAlign:TextAlign.start,);
  }


}
class boxtextBoldStart2 extends StatelessWidget {
  boxtextBoldStart2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11.sp,fontWeight:FontWeight.w500,),textAlign:TextAlign.start,);
  }


}
class boxtext extends StatelessWidget {
  boxtext({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:10.sp,),textAlign:TextAlign.center,);
  }


}
class boxtextsumary extends StatelessWidget {
  boxtextsumary({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:10.sp,),textAlign:TextAlign.justify,);
  }


}
class boxtextBoldunderline extends StatelessWidget {
  boxtextBoldunderline({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w500,),
        textAlign: TextAlign.center);
  }
}
  class boxtextBoldStart3 extends StatelessWidget {
  boxtextBoldStart3({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
  return Text(title,style:TextStyle(color:Colors.white,fontSize:11.sp,fontWeight:FontWeight.w400,),textAlign:TextAlign.start,);
  }


}