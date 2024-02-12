import 'package:flutter/material.dart';

class NotifyLisnerScreen extends StatelessWidget {
  NotifyLisnerScreen({super.key});

  ValueNotifier<int> con = ValueNotifier<int>(0);
  ValueNotifier<bool> toggle = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    print("Build Context");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Stateless Widget",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: ValueListenableBuilder(
                  valueListenable: con,
                  builder: (context, value, child) {
                    return Text(con.value.toString());
                  })),
          ValueListenableBuilder(
              valueListenable: toggle,
              builder: (context, value, child) {
                return TextFormField(
                  obscureText: toggle.value,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            toggle.value = !toggle.value;
                          },
                          child: Icon(toggle.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)),
                      hintText: "Password"),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          con.value++;
          print(con.value.toString());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
