// import 'package:student_id_generator_admin/controllers/MenuController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 236, 236, 236),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 / 2),
              child: Text("Angelina Jolie"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Color.fromARGB(255, 236, 236, 236),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16.0 * 0.75),
            margin: EdgeInsets.symmetric(horizontal: 16.0 / 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 236, 236, 236),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
