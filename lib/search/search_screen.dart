

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchOption selectedCategory = SearchOption.album;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
               SliverAppBar(
                floating: true,
                pinned: false,
                centerTitle: false,
                title: Text("Search",style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp
                    ),),
                backgroundColor: Colors.black,
              ),
               SliverPersistentHeader(
                pinned: true,
                delegate: CustomSliverHeaderDelegate(
                child:  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 325.w,
                    height: 65.h,
                    margin: EdgeInsets.only(bottom: 10.h,top: 10.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(5.w)),
                       ),
                    child: SizedBox(
                       width: 270.w,
                       height: 65.w,
                        child:  TextField(
                            decoration: InputDecoration(
                              hintText: 'Artists, albums...',
                              enabledBorder: InputBorder.none, 
                              focusedBorder: InputBorder.none, 
                              icon:   Container(
                                  width: 20.w,
                                  height: 20.w,
                                  margin: EdgeInsets.only(left: 17.w),
                                  child: Image.asset("assets/icons/search2.png",color: Colors.black54,)),
                            ),
                          ),
                    ),
                  ),
                ), 
                minHeight: 60.h,
                maxHeight: 70.h
              )),
              SliverToBoxAdapter(
                child: _buildSelectionChips(['Albums','Artists',])
              )
            ];  
          },
          body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _showResultsOnSearch(context)
            ),
          ),
        ),
    );
  }

  _showResultsOnSearch(BuildContext context){
      switch (selectedCategory){
        case SearchOption.artist:
          return _buildAlbumsResultList(context);
        case SearchOption.album:
          return _buildArtistsResultList(context);
      }
  }

  _buildAlbumsResultList(BuildContext context){
      return Container(color: Colors.amber,);
  }

  _buildArtistsResultList(BuildContext context){
      return Container(color: Colors.red,);
  }

  Widget _buildSelectionChips(List<String> tabTitle) {
  return   Row(
              children: [
                ChoiceChip(
                  label: const Text('Albums'),
                  showCheckmark: false,
                  selected: selectedCategory == SearchOption.album,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      setState(() {
                        selectedCategory = SearchOption.album;
                      });
                    }
                  },
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.h)
                  ),
                  selectedColor: Colors.green,
                  labelStyle: const  TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Artists'),
                  selected: selectedCategory == SearchOption.artist,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      setState(() {
                        selectedCategory = SearchOption.artist;
                      });
                    }
                  },
                  showCheckmark: false,
                  selectedColor: Colors.green,
                    backgroundColor: Colors.black,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.h)
                  ),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
    );
   }
}

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CustomSliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Calculate current height based on the shrink offset
    final currentHeight = (maxExtent - shrinkOffset).clamp(minExtent, maxExtent);

    return SizedBox(
      height: currentHeight,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent;
  }
}


enum SearchOption {
  artist,
  album
}