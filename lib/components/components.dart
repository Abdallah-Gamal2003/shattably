import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';


import '../core/utils/styles/icon_broken.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  required FormFieldValidator<String>? validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  GestureTapCallback? onTap,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  bool autoFocus = false,
}) =>
    TextFormField(
      autofocus: autoFocus,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: onChange,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(

        labelText: label,
        labelStyle: TextStyle(fontFamily: "Tajawal",color: Colors.green),
        prefixIcon: Icon(
          prefix,color: Colors.green,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.black,
  double radius = 3.0,
  bool isUpperCase = true,
  // anonymous function
  required Function function,
  required String text,
}) =>
    Container(

      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        }, //() he not put it
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultDialogButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 3.0,
  bool isUpperCase = true,
  // anonymous function
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
        height: 30.0,
      child: MaterialButton(
        onPressed: () {
          function();
        }, //() he not put it
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultDetailsScreenButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 3.0,
  bool isUpperCase = true,
  // anonymous function
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        }, //() he not put it
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function!();
      },
      child: Text(text.toUpperCase()),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
// Widget AwesomDialog({required String desc,required String title})=>
//     AwesomeDialog(
// context: context,
// dialogType: DialogType.error,
// animType: AnimType.rightSlide,
// title: Text(title),
// desc: Text(desc),
// ).show();

Widget AlertDialg({
  required String text,
  required String title,
  required String titleForNav,
  required Function function,
}) =>
    AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(text),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            function();
          },
          child: Text(
            titleForNav,
          ),
        ),
      ],
    );


Widget defaultFormFieldDetails({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  required String label,
  required IconData prefix,
  GestureTapCallback? onTap,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged:onChange,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 2.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

IconButton IconButtonHomeScreen(BuildContext context) {
  return IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
      color: Colors.black,
    ),
  );
}
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final dynamic? hintTextStyle;
  final dynamic? titleTextStyle;
  final bool isCitySelected;
  final List<SelectedListItem>? DataList;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    this.hintTextStyle,
    this.titleTextStyle,
    required this.isCitySelected,
    this.DataList,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}
class _AppTextFieldState extends State<AppTextField> {
  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle:  Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.DataList ?? [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              widget.textEditingController.text=item.name;
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
            FocusScope.of(context).unfocus();
            onTextFieldTap();
          }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding:
            const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: widget.textEditingController.text == "" ? widget.hint:widget.textEditingController.text,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}