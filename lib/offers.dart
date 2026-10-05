import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presention/layout/cubit/cubit.dart';
import 'features/home/presention/layout/cubit/states.dart';

class OffersScreen extends StatefulWidget {
  final dynamic orderId;
  OffersScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    ServiceCubit.get(context).getOffers(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ServiceGetOffersErrorState || state is ServiceAcceptOfferErrorState) {
          String errorMessage = (state is ServiceGetOffersErrorState)
              ? state.error
              : (state as ServiceAcceptOfferErrorState).error;

          return Scaffold(
            body: Center(
              child: Text('Error: $errorMessage'),
            ),
          );
        }

        if (state is ServiceGetOffersLoadingState || state is ServiceAcceptOfferLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        List offers = ServiceCubit.get(context).offers;

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
            iconTheme: IconThemeData(color: Colors.green),
            centerTitle: true,
          ),
          backgroundColor: Colors.white, // Light background for the whole screen
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
                        _buildOfferDetail('Price', offers[index]['price']),
                        const SizedBox(height: 10),
                        _buildOfferDetail('End Date', offers[index]['endData']),
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

  Widget _buildProfileSection(dynamic offer) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            offer['image'] != null && offer['image'] != "null"
                ? offer['image']
                : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
          radius: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            offer['name'],
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

  Widget _buildActionButtons(dynamic offer) {
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
            ServiceCubit.get(context).acceptOffer(
              orderId: widget.orderId,
              offerId: offer['offerId'],
            );
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
            ServiceCubit.get(context).showProfile(offer['employeeId']);
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
