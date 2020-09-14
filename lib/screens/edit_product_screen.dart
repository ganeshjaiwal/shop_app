import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static String routName = "edit-product";
  EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = ProductProvider(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
    isFavorite: false,
  );
  var isInit = false;
  bool isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final String prodId = ModalRoute.of(context).settings.arguments as String;
      if (prodId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(prodId);
      }
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    isInit = false;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  _updateImageUrl() {
    if (_imageUrlController.text.isNotEmpty) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('png'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveProduct() async {
    final isValid = _form.currentState.validate();
    this.setState(() {
      this.isLoading = true;
    });
    if (isValid) {
      _form.currentState.save();
      if (_editedProduct.id == null) {
        try {
          await Provider.of<ProductsProvider>(context, listen: false)
              .addItem(_editedProduct);
        } catch (error) {
          print("In Error");
          await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Error"),
              content: Text("Somthing went wrong!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          );
        }
        // finally {
        //   setState(() {
        //     this.isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }
      } else {
        await Provider.of<ProductsProvider>(context, listen: false)
            .updateItem(_editedProduct);
      }
      setState(() {
        this.isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _editedProduct.id != null ? "Edit Product" : "Add new product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProduct,
          ),
        ],
      ),
      body: this.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _editedProduct.title,
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title should not be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductProvider(
                          id: _editedProduct.id,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.price == 0.0
                          ? ""
                          : _editedProduct.price.toString(),
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Price should not be empty!';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter value greater than 0.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductProvider(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value),
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.description,
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description should not be empty!';
                        }
                        if (value.length < 10) {
                          return 'Should have at least 10 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = ProductProvider(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            right: 8,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text("Enter Url"),
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Image URL"),
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveProduct();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Image URL should not be empty';
                              }
                              if ((!value.startsWith('http') &&
                                      !value.startsWith('https')) ||
                                  (!value.endsWith('.jpg') &&
                                      !value.endsWith('.jpeg') &&
                                      !value.endsWith('png'))) {
                                return 'Please enter valid URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = ProductProvider(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
