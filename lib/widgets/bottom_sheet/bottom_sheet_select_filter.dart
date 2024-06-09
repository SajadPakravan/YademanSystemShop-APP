import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

bool all = true;

selectFilter({required BuildContext context, required List<ProductCategoryModel> categoriesLst, required List<int> id, required Function() onPressed}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.red,
    showDragHandle: true,
    enableDrag: true,
    isScrollControlled: true,
    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    option(
                      title: 'همه دسته‌ها',
                      value: all,
                      onChanged: (bool? v) {
                        setState(() => all = v!);
                        if (!all) {
                          setState(() => id.clear());
                          for (var category in categoriesLst) {
                            category.setSelect = false;
                          }
                        }
                      },
                    ),
                    Wrap(
                      children: List.generate(
                        categoriesLst.length,
                        (index) {
                          return ChangeNotifierProvider.value(
                            value: categoriesLst[index],
                            child: Consumer<ProductCategoryModel>(
                              builder: (context, category, child) {
                                return option(
                                  title: category.name!,
                                  value: all ? true : category.getSelect!,
                                  onChanged: all
                                      ? null
                                      : (bool? v) {
                                          category.setSelect = v!;
                                          if (v) setState(() => id.add(category.id!));
                                          if (!v) setState(() => id.remove(category.id));
                                        },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: ElevatedButton(
              onPressed: !all && id.isEmpty
                  ? null
                  : () {
                      if (all) setState(() => id.clear());
                      onPressed();
                      Navigator.pop(context);
                    },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return Colors.grey;
                    return ColorStyle.blueFav;
                  },
                ),
              ),
              child: const TextBodyMediumView('انتخاب', color: Colors.white),
            ),
          );
        },
      );
    },
  );
}

option({required String title, required bool value, required void Function(bool?)? onChanged}) {
  return ListTile(title: TextBodyMediumView(title), leading: Checkbox(value: value, onChanged: onChanged));
}
