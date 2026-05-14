import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/network/network_cubit.dart';

class NetworkWrapper extends StatefulWidget {
  const NetworkWrapper({super.key});

  @override
  State<NetworkWrapper> createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper> with SingleTickerProviderStateMixin {
  bool _isDialogShowing = false;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _showOfflineDialog(BuildContext context) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            final double offset = sin(_shakeController.value * pi * 4) * 8;
            return Transform.translate(
              offset: Offset(offset, 0),
              child: child,
            );
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.zero, 
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Không có kết nối Internet",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Không thể sử dụng APP, hãy kết nối Internet và thử lại",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 24),
                
                Divider(height: 1, thickness: 0.5, color: Colors.black),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      final state = context.read<NetworkCubit>().state;
                      if (state is NetworkConnected) {
                        _isDialogShowing = false;
                        Navigator.of(dialogContext).pop();
                      } else {
                        // Nảy popup nếu chưa có mạng
                        _shakeController.forward(from: 0.0);
                      }
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          _showOfflineDialog(context);
        } else if (state is NetworkConnected && _isDialogShowing) {
          //TODO : Để làm sau
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}