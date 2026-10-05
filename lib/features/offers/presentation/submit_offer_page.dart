import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/domain/offers_use_cases.dart';
import 'package:shattably/features/offers/presentation/offers_cubits.dart';

class SetOfferPage extends StatefulWidget {
  final String orderId;
  final String clientId;

  const SetOfferPage(
      {super.key, required this.orderId, required this.clientId});

  @override
  State<SetOfferPage> createState() => _SetOfferPageState();
}

class _SetOfferPageState extends State<SetOfferPage> {
  late final SubmitOfferCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = SubmitOfferCubit(SubmitOffer(context.read<OffersRepository>()));
  }

  @override
  void dispose() {
    _cubit.close();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  final _priceController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmitOfferCubit, LoadState<String>>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.status == LoadStatus.success) {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);
          navigator.pop();
          navigator.pop();
          messenger.showSnackBar(
              const SnackBar(content: Text('Offer sent successfully')));
        } else if (state.failure != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure!.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.green),
            title: const Text(
              'انشئ عرضك',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Icon(
                  Icons.attach_money_rounded,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: _priceController,
                  style: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'Tajawal',
                  ),
                  decoration: InputDecoration(
                    labelText: 'السعر',
                    labelStyle: const TextStyle(
                      color: Colors
                          .green, // Optional: Change the label text color to deep orange
                      fontFamily: 'Tajawal',
                    ),
                    prefixIcon: const Icon(
                      Icons.money,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: _dateController,
                  style: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'Tajawal',
                  ),
                  decoration: InputDecoration(
                    labelText: 'تاريخ النهاية',
                    labelStyle: const TextStyle(
                      color: Colors
                          .green, // Optional: Change the label text color to deep orange
                      fontFamily: 'Tajawal',
                    ),
                    prefixIcon: const Icon(
                      Icons.date_range,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: state.status == LoadStatus.loading
                      ? null
                      : () => _cubit.submit(OfferDraft(
                          orderId: widget.orderId,
                          price: _priceController.text,
                          endDate: _dateController.text)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'ارسال العرض',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
