import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/tools/app_themes.dart';

// ignore: must_be_immutable
class ShopFilterScreen extends StatefulWidget {
  ShopFilterScreen({super.key, this.categoriesLst = const [], this.filtersLst = const []});

  List<ProductCategoryModel> categoriesLst;
  List<Map<String, dynamic>> filtersLst;

  @override
  State<ShopFilterScreen> createState() => _ShopFilterScreenState();
}

class _ShopFilterScreenState extends State<ShopFilterScreen> {
  AppTexts appTexts = AppTexts();
  AppDimension appDimension = AppDimension();
  List<String> optionSelectName = [];
  List<String> categoriesNameId = [];
  bool allSelect = false;
  bool filtersVisible = false;
  int filterIndex = 0;

  checkContent() {
    if (Get.arguments["categoriesName"] == null) {
      setState(() {
        filtersVisible = true;
        for (int i = 0; i < widget.filtersLst.length; i++) {
          setState(() {
            widget.filtersLst[i]["select"] = false;
          });
        }
        filterIndex = widget.filtersLst.lastIndexOf(Get.arguments["filterSave"][0]);
        widget.filtersLst[filterIndex]["select"] = true;
        setState(() {
          optionSelectName.add(widget.filtersLst[filterIndex]["name"]);
        });
      });
    } else {
      setState(() => filtersVisible = false);
      checkSelectCategories();
    }
  }

  checkSelectCategories() {
    if (Get.arguments["categoriesName"].contains(appTexts.allCategories)) {
      setState(() {
        allSelect = true;
        optionSelectName = [appTexts.allCategories];
        categoriesNameId.clear();
      });
      for (int i = 0; i < widget.categoriesLst.length; i++) {
        ProductCategoryModel productCategoryModel = widget.categoriesLst[i];
        if (productCategoryModel.getSelect!) {
          setState(() {
            productCategoryModel.setSelect = false;
          });
        }
      }
    } else {
      for (int i = 0; i < widget.categoriesLst.length; i++) {
        ProductCategoryModel productCategoryModel = widget.categoriesLst[i];
        if (productCategoryModel.getSelect!) {
          setState(() {
            categoriesNameId.add(productCategoryModel.id.toString());
            optionSelectName.add(productCategoryModel.name.toString());
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkContent();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: appBar(),
          body: filtersVisible ? filtersContent() : categoriesContent(),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: optionSelectName.isEmpty
                      ? null
                      : () {
                          if (filtersVisible) {
                            Get.back(result: filterIndex);
                          } else {
                            Get.back(
                              result: {
                                "categoriesName": optionSelectName,
                                "categoriesId": categoriesNameId,
                              },
                            );
                          }
                        },
                  child: Text("انتخاب", style: Theme.of(context).textTheme.buttonText1),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("بستن", style: Theme.of(context).textTheme.buttonText1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  categoriesContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CheckboxMenuButton(
            value: allSelect,
            onChanged: (v) {
              setState(() {
                allSelect = v!;
              });
              if (v!) {
                setState(() {
                  optionSelectName = [appTexts.allCategories];
                  categoriesNameId.clear();
                });
                for (int i = 0; i < widget.categoriesLst.length; i++) {
                  ProductCategoryModel productCategoryModel = widget.categoriesLst[i];
                  if (productCategoryModel.getSelect!) {
                    setState(() {
                      productCategoryModel.setSelect = false;
                    });
                  }
                }
              } else {
                setState(() {
                  optionSelectName.clear();
                });
              }
              if (kDebugMode) {
                print("id >>>> $categoriesNameId");
                print("name >>>> $optionSelectName");
              }
            },
            child: Text(
              appTexts.allCategories,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 70,
            ),
            itemCount: widget.categoriesLst.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              ProductCategoryModel productCategoryModel = widget.categoriesLst[index];
              return CheckboxMenuButton(
                value: allSelect ? allSelect : productCategoryModel.getSelect!,
                onChanged: allSelect
                    ? null
                    : (v) {
                        setState(() {
                          productCategoryModel.setSelect = v!;
                        });

                        if (v!) {
                          setState(() {
                            categoriesNameId.add(productCategoryModel.id.toString());
                            optionSelectName.add(productCategoryModel.name.toString());
                          });
                          if (optionSelectName.length == widget.categoriesLst.length) {
                            setState(() {
                              allSelect = true;
                              optionSelectName = [appTexts.allCategories];
                              categoriesNameId.clear();
                            });
                            for (int i = 0; i < widget.categoriesLst.length; i++) {
                              ProductCategoryModel productCategoryModel = widget.categoriesLst[i];
                              if (productCategoryModel.getSelect!) {
                                setState(() {
                                  productCategoryModel.setSelect = false;
                                });
                              }
                            }
                          }
                        } else {
                          setState(() {
                            categoriesNameId
                                .removeAt(categoriesNameId.indexOf(productCategoryModel.id.toString()));
                            optionSelectName
                                .removeAt(optionSelectName.indexOf(productCategoryModel.name.toString()));
                          });
                        }
                        if (kDebugMode) {
                          print("id >>>> $categoriesNameId");
                          print("name >>>> $optionSelectName");
                        }
                      },
                child: Text(
                  productCategoryModel.name!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  filtersContent() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 70,
      ),
      itemCount: widget.filtersLst.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxMenuButton(
          value: widget.filtersLst[index]["select"],
          onChanged: (v) {
            for (int i = 0; i < widget.filtersLst.length; i++) {
              setState(() {
                widget.filtersLst[i]["select"] = false;
              });
            }
            setState(() {
              widget.filtersLst[index]["select"] = v;
            });

            if (v!) {
              setState(() {
                optionSelectName.clear();
                optionSelectName.add(widget.filtersLst[index]["name"]);
                filterIndex = index;
              });
            } else {
              optionSelectName.clear();
            }
          },
          child: Text(
            widget.filtersLst[index]["name"],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }

  appBar() {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        color: ColorStyle.blueFav,
        child: SafeArea(
          child: optionSelectName.isEmpty
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "لطفا گزینه‌ای را انتخاب کنید",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : Center(
                  child: ListView.builder(
                    itemCount: optionSelectName.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(width)),
                        ),
                        child: AutoSizeText(
                          optionSelectName[index],
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          minFontSize: appDimension.textNormal,
                          maxFontSize: appDimension.textNormal,
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
