import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubits/otp_cubit/otp_cubit.dart';


class OtpFields extends StatefulWidget {
  const OtpFields({super.key});

  @override
  State<OtpFields> createState() => _OtpFieldsState(); // إنشاء الحالة
}

class _OtpFieldsState extends State<OtpFields> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController()); // إنشاء 6 Controllers

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode()); // إنشاء 6 FocusNodes

  void _onChanged(int index) {
    String code = controllers.map((c) => c.text).join(); // دمج كل الأرقام المدخلة
    context.read<OtpCubit>().codeChanged(code); // إرسال الكود إلى Cubit

    if (controllers[index].text.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]); // الانتقال للخانة التالية تلقائيًا
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() => _onChanged(i)); // مستمع للتغير في كل خانة
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose(); // تدمير Controllers عند الانتهاء
    }
    for (var f in focusNodes) {
      f.dispose(); // تدمير FocusNodes عند الانتهاء
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // توزيع متساوٍ بين الحقول
      children: List.generate(6, (index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.10, // عرض نسبي لكل خانة
          child: TextField(
            controller: controllers[index], // ربط Controller بالخانة
            focusNode: focusNodes[index], // ربط FocusNode بالخانة
            textAlign: TextAlign.center, // توسيط الرقم داخل الخانة
            keyboardType: TextInputType.number, // نوع الإدخال أرقام فقط
            maxLength: 1, // رقم واحد فقط في كل خانة
            decoration: const InputDecoration(
              counterText: "", // إخفاء عداد الأحرف
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 1, 14, 26)),
              ),
            ),
          ),
        );
      }),
    );
  }
}