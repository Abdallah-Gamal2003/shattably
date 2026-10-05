import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/domain/orders_use_cases.dart';
import 'package:shattably/features/orders/presentation/orders_cubits.dart';
import 'package:shattably/features/orders/presentation/order_view_data.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

import 'package:shattably/components/components.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';



class RequestForm extends StatefulWidget {

  const RequestForm(this.job, {super.key});
  final String job;
  @override
  State<RequestForm> createState() => _RequestFormState();
  final String order="";
}

class _RequestFormState extends State<RequestForm> {
  String? deliveryDate;
  String? rentingPeriod;
  DateTime? deliverySelectedDate = DateTime.now();
  DateTime? rentingPeriodSelectedDate;
final cityController =TextEditingController();
final orderController =TextEditingController();
final startController = TextEditingController();
final endController = TextEditingController();
late final CreateRequestCubit _cubit;
@override
void initState() {
  super.initState();
  _cubit = CreateRequestCubit(CreateServiceRequest(context.read<OrdersRepository>()));
}
@override
void dispose() {
  for (final controller in [cityController,orderController,startController,endController]) { controller.dispose(); }
  _cubit.close();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CreateRequestCubit, LoadState<String>>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.status == LoadStatus.success) {
          context.read<CustomerOrdersCubit>().load();
          final messenger = ScaffoldMessenger.of(context);
          Navigator.pop(context);
          messenger.showSnackBar(const SnackBar(content: Text('تم ارسال الطلب بنجاح')));
        } else if (state.failure != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure!.message)));
        }
      },
      builder: (context, state) { return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تسجيل الطلب',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column
          (children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: orderController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "اكتب طلبك",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
              ),
            ),
          ),

          const SizedBox(height: 15,) ,


          Padding(
            padding: const EdgeInsets.all(17),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedDate: DateTime.now(),
              rangeSelectionColor: Colors.green,
              rangeTextStyle: const TextStyle(color: Colors.green),

              toggleDaySelection: true,
              todayHighlightColor: Colors.green,
              endRangeSelectionColor: Colors.green,
              startRangeSelectionColor: Colors.green,
              selectionColor: Colors.green,

              monthCellStyle: const DateRangePickerMonthCellStyle(
                textStyle: TextStyle(color: Colors.green), // Set text color to white for date numbers
              ),

              headerStyle: const DateRangePickerHeaderStyle(
                textStyle: TextStyle(color: Colors.white), // Set text color to white for day headers
              ),


              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  deliverySelectedDate = args.value.startDate;
                  rentingPeriodSelectedDate = args.value.endDate;
                  deliveryDate = deliverySelectedDate?.toIso8601String().split('T').first;
                  startController.text = deliveryDate ?? '';
                  rentingPeriod = rentingPeriodSelectedDate?.toIso8601String().split('T').first;
                  endController.text = rentingPeriod ?? '';

                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: startController,
              readOnly: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "بدايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17 , right: 17),
            child: TextField(
              controller: endController,
              readOnly: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "نهايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
              ),

            ),
          ),
          AppTextField(
          textEditingController: cityController,
          title: "",
          hintTextStyle: const TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          titleTextStyle: const TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          hint: "المحافظة",
          isCitySelected: true,
          dataList: [
            SelectedListItem(name: "القاهرة"),
            SelectedListItem(name: "الجيزة"),
            SelectedListItem(name: "الاسكندرية"),
            SelectedListItem(name: "اسيوط"),
            SelectedListItem(name: "دمياط"),
            SelectedListItem(name: "الجميع")
          ],
        ),ElevatedButton(

              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Set background color
              ),
              onPressed: state.status == LoadStatus.loading ? null : () {
                _cubit.submit(ServiceRequestDraft(description: orderController.text,
                  city: cityController.text, category: ServiceCategory(widget.job),
                  startDate: deliverySelectedDate, endDate: rentingPeriodSelectedDate));
        }, child: const Text("ارسال طلب" , style: TextStyle(color: Colors.white , fontFamily: 'Tajawal' , fontSize: 20),))],),
      )
    );
      },
    );
  }
}

