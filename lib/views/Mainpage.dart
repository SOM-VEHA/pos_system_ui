import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pos_system_ui/color/color.dart';
import 'package:pos_system_ui/controllers/category_local.dart';
import 'package:pos_system_ui/controllers/favorite_local.dart';
import 'package:pos_system_ui/controllers/product_local.dart';
class Mainpage extends StatefulWidget {
  Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final category_local_controller = Get.put(category_local());

  final product_local_controller = Get.put(product_local());

  final farvorite_local_controller = Get.put(farvorite_local());

  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomScrollView(
                  slivers: [
                    //search
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kcontentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                flex: 4,
                                child: TextField(
                                  controller:searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery=value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 1.5,
                                color: Colors.grey,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.tune,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //menu
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Container(
                          height: 50,
                          child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                              category_local_controller.categories.length,
                              itemBuilder: (context, index) {
                                final category =
                                category_local_controller.categories[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      category_local_controller
                                          .onCategorySelected(category.id);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: category_local_controller
                                            .selectedCategoryId.value ==
                                            category.id
                                            ? Colors.redAccent
                                            : kcontentColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              category.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: category_local_controller
                                                    .selectedCategoryId
                                                    .value ==
                                                    category.id
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                    //product
                    SliverPadding(
                      padding: EdgeInsets.only(
                          right: 5, left: 5, top: 10, bottom: 20),
                      sliver: Obx(
                            () {
                          final filteredProducts = product_local_controller
                              .products
                              .where((product) {
                            return product.title
                                .toLowerCase()
                                .contains(searchQuery);
                          }).toList();
                          return SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: filteredProducts.length,
                                  (context, index) {
                                final product = filteredProducts[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kcontentColor,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(8),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                        color: Colors.white),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      child: Image(
                                                        width: 120,
                                                        height: 120,
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          product.image,
                                                          // 'https://t3.ftcdn.net/jpg/02/94/19/40/240_F_294194023_disE35GtlVLDQx4caNDaWewZI8LbxWFQ.jpg'
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        product.title,
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "\$${20}/night",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              size: 18,
                                                              color: Colors
                                                                  .deepOrange,
                                                            ),
                                                            Text('(4.5)')
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  farvorite_local_controller
                                                      .toggleFavorite(product);
                                                },
                                                child: Obx(() {
                                                  final isFavorite =
                                                  farvorite_local_controller
                                                      .isExist(product);
                                                  return Icon(
                                                    isFavorite
                                                        ? Icons.shopping_cart
                                                        : Icons.shopping_cart_outlined,
                                                    color: isFavorite
                                                        ? Colors.red
                                                        : Colors.white,
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.75,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, top: 0, bottom: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 10),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: kcontentColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Current Order'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(farvorite_local_controller.favorites.length.toString()),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.shopping_cart),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomScrollView(
                                slivers: [
                                  Obx((){
                                    if(farvorite_local_controller.favorites.length==0){
                                      return SliverToBoxAdapter(
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context).size.height*0.9,
                                          color: Colors.red,
                                        ),
                                      );
                                    }else{
                                      return SliverList.builder(
                                        itemCount: farvorite_local_controller.favorites.length,
                                        itemBuilder: (context, index) {
                                          final product = farvorite_local_controller.favorites[index];
                                          return Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 5),
                                            child: Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                color: kcontentColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(5.0),
                                                    child: Container(
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                        color: Colors.white,
                                                      ),
                                                      child: Image(
                                                        height: 90,
                                                        image: AssetImage(
                                                            product.image),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8,
                                                              right: 8),
                                                          child: Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(product
                                                                        .title),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        product
                                                                            .description
                                                                            .toString(),
                                                                        maxLines: 1,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        style:
                                                                        TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                          12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "\$ 100",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red),
                                                                    ),
                                                                    Container(
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                          20,
                                                                        ),
                                                                        color: kcontentColor,
                                                                        border:
                                                                        Border
                                                                            .all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade400,
                                                                          width: 2,
                                                                        ),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                              width:
                                                                              10),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                            Icon(
                                                                              Icons.add, size: 20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(width: 10),
                                                                          Text('100'),
                                                                          const SizedBox(width: 10),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                            Icon(
                                                                              Icons
                                                                                  .remove,
                                                                              size:
                                                                              20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width:
                                                                              10),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          child: Align(
                                                            alignment:
                                                            Alignment.topRight,
                                                            child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                              const BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                                  topRight: Radius
                                                                      .circular(8),
                                                                  bottomLeft: Radius
                                                                      .circular(8),
                                                                ),
                                                              ),
                                                              child:
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    farvorite_local_controller.toggleFavorite(product);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          child: MaterialButton(
                            onPressed: () {},
                            color: buttonColor,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Comfirm to Payments',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
