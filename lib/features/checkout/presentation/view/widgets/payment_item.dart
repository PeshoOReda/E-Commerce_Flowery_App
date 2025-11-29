import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../view_model/checkout_cubit.dart';
import '../../view_model/checkout_state.dart';

class PaymentItem extends StatelessWidget {
  final String title;
  final int index;

  const PaymentItem({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CheckoutCubit>();
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      buildWhen: (prev, curr) => prev.paymentState != curr.paymentState,
      builder: (context, state) {
        return InkWell(
          onTap: () => viewModel.selectPayment(index),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray.withAlpha(75),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RadioGroup<int>(
                  groupValue:
                      context.watch<CheckoutCubit>().selectedPaymentIndex,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<CheckoutCubit>().selectPayment(value);
                    }
                  },
                  child: const Column(
                    children: [
                      PaymentItem(title: "Credit Card", index: 0),
                      PaymentItem(title: "Cash on Delivery", index: 1),
                      PaymentItem(title: "PayPal", index: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
