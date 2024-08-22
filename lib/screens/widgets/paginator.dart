import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries/controllers/api/country_controller.dart';
import 'package:countries/screens/widgets/circle_drop.dart';
import 'package:countries/theme/color_theme.dart';
import 'package:countries/theme/text_theme.dart';

class Paginator extends StatefulWidget {
  const Paginator({super.key});

  @override
  State<Paginator> createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  final CountryController cntry = Get.find();
  bool isVisible = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => cntry.previousPage(),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.slid.dark50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.slid.light,
                        ),
                        Text(
                          'Previous',
                          style: Theme.of(context).textTheme.normal16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: GestureDetector(
                  onTap: () => cntry.nextPage(),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.slid.dark50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: Theme.of(context).textTheme.normal16,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColor.slid.light,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isVisible) {
                  _removeOverlay();
                } else {
                  _showDropdownMenu(context);
                }
                isVisible = !isVisible;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColor.slid.light,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(
                () => Text(
                  cntry.itemsPerPage.value.toString(),
                  style: Theme.of(context).textTheme.normal18.copyWith(
                        color: AppColor.slid.dark,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 64,
        left: MediaQuery.of(context).size.width / 2 - 67,
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleDrop(
                onTap: () {
                  cntry.setItemsPerPage(10);
                  _removeOverlay();
                },
                text: '10',
              ),
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: CircleDrop(
                  onTap: () {
                    cntry.setItemsPerPage(15);
                    _removeOverlay();
                  },
                  text: '15',
                ),
              ),
              const SizedBox(width: 8),
              CircleDrop(
                onTap: () {
                  cntry.setItemsPerPage(20);
                  _removeOverlay();
                },
                text: '20',
              ),
            ],
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    setState(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}
