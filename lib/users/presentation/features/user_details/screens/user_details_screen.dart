import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/widgets/app_card.dart';
import 'package:notes_tasks/core/widgets/app_list_tile.dart';
import 'package:notes_tasks/core/widgets/app_scafold.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/features/user_details/screens/user_section_details_view.dart';
import 'package:notes_tasks/users/presentation/features/user_details/viewmodels/get_user_address_viewmodel.dart';
import 'package:notes_tasks/users/presentation/features/user_details/viewmodels/get_user_bank_viewmodel.dart';
import 'package:notes_tasks/users/presentation/features/user_details/viewmodels/get_user_company_viewmodel.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(getUserAddressViewModelProvider.notifier)
          .getUserAddress(widget.userId);
      ref
          .read(getUserBankViewModelProvider.notifier)
          .getUserBank(widget.userId);
      ref
          .read(getUserCompanyViewModelProvider.notifier)
          .getUserCompany(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: ' User Details',
      scrollable: true,
      usePadding: false,
      body: Column(
        children: [
          const SizedBox(height: 12),

          AppCard(
            child: AppListTile(
              leading: const Icon(Icons.home_outlined),
              title: ' Address Info',
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserSectionDetailsView<AddressEntity>(
                      title: ' Address Details',
                      provider: getUserAddressViewModelProvider,
                      mapper: (data) => {
                        'Country': data.country,
                        'City': data.city,
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          AppCard(
            child: AppListTile(
              leading: const Icon(Icons.credit_card_outlined),
              title: ' Bank Info',
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserSectionDetailsView<BankEntity>(
                      title: ' Bank Details',
                      provider: getUserBankViewModelProvider,
                      mapper: (data) => {
                        'Card Type': data.cardType,
                        'Card Number': data.cardNumber,
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          AppCard(
            child: AppListTile(
              leading: const Icon(Icons.business_outlined),
              title: ' Company Info',
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserSectionDetailsView<CompanyEntity>(
                      title: ' Company Details',
                      provider: getUserCompanyViewModelProvider,
                      mapper: (data) => {
                        'Company Name': data.name,
                        'Title': data.title,
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
