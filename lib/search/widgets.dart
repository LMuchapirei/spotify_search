import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlbumCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artists;
  final String year;

  const AlbumCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.artists,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.h),
            child: Image.network(
              imageUrl,
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
         Text(
          artists,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            year,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
    );
  }
}

class ArtistCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ArtistCard({super.key, 
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Artist Image
        ClipRRect(
          borderRadius: BorderRadius.circular(80.h),
          child: Image.network(
            imageUrl,
            height: 40.h,
            width:40.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8.h),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}