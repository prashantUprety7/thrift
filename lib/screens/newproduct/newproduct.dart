import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';
import 'package:http/http.dart'as http;
class AddProductScreen extends StatefulWidget {
  static const String routeName = '/newproduct';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => AddProductScreen());
  }
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

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
        title: 'Add Product',

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: Color.fromRGBO(67, 65, 61, 1),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () async{

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select an image'),));
                              }




                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'Add Image of your product',
                          style: TextStyle(fontSize: 15),
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        labelText: 'Product Image',
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
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
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
                        labelText: 'Product Price',
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
                        hintText: 'Product Description',
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
                        hintText: 'Select category',
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
                          value: "men's clothing",
                          child: Text("men's clothing"),
                        ),
                        DropdownMenuItem(
                          value: 'electronic',
                          child: Text('electronic'),
                        ),
                        DropdownMenuItem(
                          value: 'Child',
                          child: Text('Child'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _addProduct();
                       }
                      },
                      child: Text('Add Product'),
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
  Future<void> _addProduct() async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      body: {
        'title': _nameController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'image': _imageController.text,
        'category': _selectedCategory ?? '',
        // Add other fields here if needed
      },
    );

    if (response.statusCode == 201) {
      // Product added successfully
      print(response.body);
      Navigator.pop(context);
    } else {
      print(response.statusCode);
      // Error occurred while adding product
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product')),
      );
    }

  }
}