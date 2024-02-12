import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  const HorizontalScroll({super.key});
  
  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Scrool Bar"),centerTitle: true,),
      body: Container(
        alignment: Alignment.topLeft,
        child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                   image: DecorationImage(
                     image: NetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?w=740&t=st=1706546954~exp=1706547554~hmac=365340ce88191cdbb0fff7c0eeff717b513aec02c886a740f93994873e0eba89'),
                     fit: BoxFit.cover,
                   ),
                ),
              ),

              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-photo/artist-white_1368-3546.jpg?w=740&t=st=1706547859~exp=1706548459~hmac=346477a13332327c77ce0bc1105f8d3594c7bff0411d89cbaebde7ac9b2cd7c2'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-psd/smiling-man_1154-473.jpg?size=626&ext=jpg&ga=GA1.1.1322302817.1699425350&semt=ais'),
                  fit: BoxFit.cover
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?w=740&t=st=1706546954~exp=1706547554~hmac=365340ce88191cdbb0fff7c0eeff717b513aec02c886a740f93994873e0eba89'),

                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?w=740&t=st=1706546954~exp=1706547554~hmac=365340ce88191cdbb0fff7c0eeff717b513aec02c886a740f93994873e0eba89'),
                  ),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?w=740&t=st=1706546954~exp=1706547554~hmac=365340ce88191cdbb0fff7c0eeff717b513aec02c886a740f93994873e0eba89'),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3,color: Colors.purple),
                  image: DecorationImage(
                    image: NetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?w=740&t=st=1706546954~exp=1706547554~hmac=365340ce88191cdbb0fff7c0eeff717b513aec02c886a740f93994873e0eba89'),
                  ),
                ),
              ),
              // ... other CircleAvatar widgets
            ],
          ),
        ),
      ),
    );


  }
}
