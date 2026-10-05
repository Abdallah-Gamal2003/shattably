import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/domain/offers_use_cases.dart';
import 'package:shattably/features/offers/presentation/offers_cubits.dart';
import 'package:shattably/features/orders/presentation/orders_cubits.dart';
import 'package:shattably/features/profile/presentation/worker_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatefulWidget {
  final String orderId;
  const OffersScreen({super.key, required this.orderId});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late final OrderOffersCubit _cubit;
  @override
  void initState() {
    super.initState();
    final repository = context.read<OffersRepository>();
    _cubit =
        OrderOffersCubit(GetOrderOffers(repository), AcceptOffer(repository))
          ..load(widget.orderId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderOffersCubit, OrderOffersState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.acceptance != null) {
          context.read<CustomerOrdersCubit>().load();
          final messenger = ScaffoldMessenger.of(context);
          Navigator.pop(context);
          messenger.showSnackBar(
              const SnackBar(content: Text('Offer accepted successfully')));
        } else if (state.failure != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure!.message)));
        }
      },
      builder: (context, state) {
        if (state.loading)
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        final offers = state.offers;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Offers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                fontSize: 25,
                color: Colors.green,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.green),
            centerTitle: true,
          ),
          backgroundColor:
              Colors.white, // Light background for the whole screen
          body: ListView.builder(
            itemCount: offers.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileSection(offers[index]),
                        const SizedBox(height: 15),
                        _buildOfferDetail('Price', offers[index].price),
                        const SizedBox(height: 10),
                        _buildOfferDetail('End Date', offers[index].endDate),
                        const SizedBox(height: 20),
                        _buildActionButtons(offers[index]),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(Offer offer) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            offer.workerImage.isNotEmpty && offer.workerImage != "null"
                ? offer.workerImage
                : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
          radius: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            offer.workerName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.black87,
            ),
          ),
        ),
        const Icon(Icons.verified, color: Colors.green, size: 18),
      ],
    );
  }

  Widget _buildOfferDetail(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Tajawal',
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Offer offer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            _cubit.accept(widget.orderId, offer.id);
          },
          child: const Text(
            'Accept',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: const BorderSide(color: Colors.deepOrange, width: 2),
          ),
          onPressed: () {
            openProfile(context, offer.workerId);
          },
          child: const Text(
            'Show Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.deepOrange,
            ),
          ),
        ),
      ],
    );
  }
}
