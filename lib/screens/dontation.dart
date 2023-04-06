import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';

class DonationScreen extends StatefulWidget {
  static const String routeName = '/donation';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => DonationScreen ());
  }
  const  DonationScreen ({Key? key}) : super(key: key);

  @override
  _DonationScreen createState() => _DonationScreen();
}

class _DonationScreen extends State< DonationScreen > {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;


  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Donate ',


      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [


                    SizedBox(width: 20,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your donation can change someone's life",
                            style:GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 17)),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.favorite,color: Colors.red,)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Your address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Additional Information',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Clothes condition',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'New',
                          child: Text('New'),
                        ),
                        DropdownMenuItem(
                          value: "Lnew",
                          child: Text("Looksnew"),
                        ),
                        DropdownMenuItem(
                          value: 'Old/Used',
                          child: Text('Old/Used'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Clothes Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'BagFull',
                          child: Text('BagFull'),
                        ),
                        DropdownMenuItem(
                          value: "Sack",
                          child: Text("Sack"),
                        ),
                        DropdownMenuItem(
                          value: 'SinglePiece',
                          child: Text('SinglePiece'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Add product logic here
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Send Donation Inquiry',style: GoogleFonts.aBeeZee(),),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(67, 65, 61, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}