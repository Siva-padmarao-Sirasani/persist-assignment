import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persist/widgets/BlinkingDot.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController=TextEditingController();
  File? _profileImage;
  List<File> _additionalImages = [];
  int _bottomNavIndex = 0;
  var pageController=PageController();
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addAdditionalImage() async {
    await _showImagePickerDialog();
    if (_profileImage != null) {
      setState(() {
        _additionalImages.add(_profileImage!);
        _profileImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff625bff),
      //   title: const Center(
      //     child: Text(
      //       "Persist Ventures",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ///   My Closest
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0,top: 16),
            child: ListView(
              children: [
                const Text("My closest", style: TextStyle(fontSize: 16.0)),
                /// This all data about photos we click add new button ask new image
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: _showImagePickerDialog,
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Color(0xff282466)),
                          ),
                          child: _profileImage != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Color(0xff282466),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          child: IconButton(
                            onPressed: _addAdditionalImage,
                            icon: const Icon(Icons.add),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text("Add New"),
                      ],
                    ),
                  ],
                ),
                // Display additional images
                if (_additionalImages.isNotEmpty)
                  Row(
                    children: _additionalImages
                        .map((image) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 125.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: const Color(0xff282466)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                const SizedBox(height: 5.0,),
                /// Asking Name
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "UserName",
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      /// Cover Image
                      Column(
                        children: [
                          const Text("OPS",style:TextStyle(color:Colors.black,fontSize: 15.0)),
                          const SizedBox(height: 5.0),
                          Container(
                            height: 125.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xff282466)),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: NetworkImage("https://img.freepik.com/free-photo/fashion-clothing-hangers-show_1153-5492.jpg?size=626&ext=jpg&ga=GA1.1.282168876.1704804819&semt=ais"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      /// Bottoms Image
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),

                        child: Column(
                          children: [
                            const Text("Bottoms",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                            Container(
                              height: 125.0,
                              width: 125.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff282466)),
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: NetworkImage("https://media.gettyimages.com/id/1340246383/photo/low-section-of-couple-standing-with-with-dog-on-terrace-holding-his-paws.jpg?s=612x612&w=0&k=20&c=WnnqoYniBEzhWEGEm8zIyDVxQdJpEyyF5ZN4EIcZHfE="),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ///SweatPants
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Text("SweatPants",style:TextStyle(color:Colors.black,fontSize: 15.0)),
                          const SizedBox(height: 5.0),
                          Container(
                            height: 125.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xff282466)),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: NetworkImage("https://www.beyours.in/cdn/shop/files/black-1_ee53d720-8eac-4c22-aaa3-0efc4850e585_400x.jpg?v=1683179875"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      /// Jeans
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),

                        child: Column(
                          children: [
                            const Text("jeans",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                            Container(
                              height: 125.0,
                              width: 125.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff282466)),
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: NetworkImage("https://media.gettyimages.com/id/1255253062/photo/cropped-shot-of-womans-hand-selecting-a-pair-of-trousers-from-the-display-shelf-while.jpg?s=612x612&w=0&k=20&c=VWaVksUM2Vjc0Z8LCl0VkuJEqsO2_lfwJQYbS2vsOJc="),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ///shoes
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Text("Shoes",style:TextStyle(color:Colors.black,fontSize: 15.0)),
                          const SizedBox(height: 5.0),
                          Container(
                            height: 125.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xff282466)),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: NetworkImage("https://st.depositphotos.com/2501253/3129/i/380/depositphotos_31296181-stock-photo-shoes.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ///Jewellery
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),

                        child: Column(
                          children: [
                            const Text("jewellery",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                            Container(
                              height: 125.0,
                              width: 125.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff282466)),
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: NetworkImage("https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRxbAn7QPK5iZSKXWTWMX3KymcvOexk-_sEOUgz6jeDPz0mP2vimcSIsNPkvv1Gsot1hCY9eumqH4ZCW78VexDSpquL5OvVrKlpL0dcYfl01QEKH9bQOoul"),
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /// Groups -> this is groups here i mention create group and exisisting data
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0,top: 16),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text("Groups", style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0,),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xff282466))
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: (){

                            },
                            icon: const Icon(Icons.search),
                        ),
                        const SizedBox(width: 10.0,),
                        const Text("Search"),//search
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 25.0,bottom: 25.0),
                  child: Divider(height: 5.0,color: Color(0xff282466),),

                ),

                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: const Color(0xff282466))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            child: IconButton(
                              onPressed: (){

                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        const Text("Create Group"),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0,),
                Row(
                  children: [
                    BlinkingDot(),
                    const SizedBox(width: 8.0,),
                    const Text("Existing Group",style: TextStyle(fontSize: 16.0),),
                  ],
                ),
                const SizedBox(height: 12.0,),
                /// Existing Grroups
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            height: 55.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: const Color(0xff282466))
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    child: IconButton(
                                      onPressed: (){

                                      },
                                      icon: const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0,),
                                const Text("KKG"),

                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
          /// Discover
          Padding(
            padding: const EdgeInsets.only(left: 12.0,top: 25.0,bottom: 8.0,right: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Menu and Itoms
                IconButton(
                    onPressed: (){
                      _showPopupMenu(context);
                    },
                    icon: const Icon(Icons.menu),
                ),
                const SizedBox(height: 12.0,),
                const Text("Filters",style: TextStyle(fontSize: 16.0),),
                const SizedBox(height: 12.0,),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  height: 100.0,
                  width: 150.0,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff282466)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  ///Filters
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Colors",),
                      Text("Categorys",),
                      Text("Season",),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    height: 100.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xff282466)),
                      image: const DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-photo/fashion-clothing-hangers-show_1153-5492.jpg?size=626&ext=jpg&ga=GA1.1.282168876.1704804819&semt=ais"),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Icon(Icons.download_outlined,color: Colors.yellowAccent,size: 25.0,),
                          ],
                        ),
                      ],
                    ),
                  ),

                ),
                Container(
                  height: 100.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xff282466)),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 35.0),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.yellow,
                              child: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Padding(
                            padding: EdgeInsets.only(top:30.0),
                            child: Text("Username"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      /// Bottom App Bar Common to all pages Remaining Saved and Chat
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: const Color(0xff282466),
        elevation: 0,
        splashColor: const Color(0xff94c706),

        icons: const [
          Icons.person_2_outlined,
          CupertinoIcons.group,
          Icons.home,
          Icons.save_alt_outlined,
          Icons.chat,
          // Add one more icon to make the count even
        ],
        inactiveColor: Colors.white,
        activeColor: const Color(0xff94c706),
        activeIndex: _bottomNavIndex,
        // gapLocation: GapLocation.center,
        gapWidth: 16,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            pageController.jumpToPage(index);
          });
        },

      ),

    );
  }
  ///MenuBar Logic
  void _showPopupMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        const PopupMenuItem(
          value: 'suggested',
          child: Text('Suggested'),
        ),
        const PopupMenuItem(
          value: 'followers',
          child: Text('Followers'),
        ),
        const PopupMenuItem(
          value: 'following',
          child: Text('Following'),
        ),
      ],
    );

    if (result != null) {
      // Handle menu item selection
      debugPrint('Selected: $result');
    }
  }

}
