import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:komunoto/controller/firebase_controller.dart';
import 'package:komunoto/custom/button_next.dart';
import 'package:komunoto/custom/button_passed.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String? phoneNumber;
  String? email;
  int? dropdownValue;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseController firebaseController = FirebaseController(context);
    phoneNumber = firebaseController.getPhoneNumberFromLoginData();
    email = firebaseController.getEmailFromLoginData();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    List<String> _dropdownValues = ['One', 'Two', 'Three', 'Four', 'Five'];
    List<String> _filteredItems = _dropdownValues;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('Masukan Data',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 32 * width / 720))),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                   decoration: BoxDecoration(
                     
                      color: const Color(0x1A2B2B2B),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.error,
                          color: const Color(0xB32B2B2B),
                          size: 60 * width / 720,
                        ),
                        SizedBox(
                          width: 20 * width / 720,
                        ),
                        Text(
                          'Isi data agar produk & layanan yang \nditampilkan sesuai kebutuhan mobilmu',
                          style: GoogleFonts.poppins(
                              fontSize: 24 * width / 720,
                              fontWeight: FontWeight.w400),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Nama',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Masukan Nama Lengkap',
                      labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 28 * width / 720),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Nomor HP',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  IntlPhoneField(
                    // focusNode: phoneNode,
                    decoration: InputDecoration(
                      labelText: 'Enter your phone number',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    initialValue:
                        phoneNumber, // Menggunakan nomor telepon dari data login
                    enabled: phoneNumber ==
                        null, // Jika nomor telepon ada, field ini akan menjadi read-only
                    initialCountryCode: 'ID',
                    languageCode: 'en',
                    onChanged: (phone) {
                      print('0${phone.number}');
                    },
                    onSaved: (phone) {
                      phoneNumber = '0${phone!.number}';
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ${country.name}');
                    },
                  ),
                   SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Masukan Email Anda',
                      labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 28 * width / 720),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    initialValue: email,
                     enabled: email ==
                        null, // Jika nomor telepon ada, field ini akan menjadi read-only
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Jenis Kendaraan',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // color of the border
                        width: 1, // width of the border
                      ),
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (int? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            value: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Mobil',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28 * width / 720,
                                  )),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Motor',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28 * width / 720,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 28 * height / 1280,
                  // ),
                  // Text(
                  //   'Merk Kendaraan',
                  //   style: GoogleFonts.poppins(
                  //       fontSize: 28 * width / 720,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 10 * height / 1280,
                  // ),
                  // DropdownSearch<UserModel>(
                  //   popupProps: PopupProps.bottomSheet(),
                  //   dropdownSearchDecoration:
                  //       InputDecoration(labelText: "Name"),
                  //   asyncItems: (String filter) => getData(filter),
                  //   itemAsString: (UserModel u) => u.userAsString(),
                  //   onChanged: (UserModel? data) => print(data),
                  // ),
                  // SizedBox(
                  //   height: 28 * height / 1280,
                  // ),
                  // Text(
                  //   'Tahun Kendaraan',
                  //   style: GoogleFonts.poppins(
                  //       fontSize: 28 * width / 720,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 10 * height / 1280,
                  // ),
                  // DropdownSearch<UserModel>(
                  //   popupProps: PopupProps.bottomSheet(),
                  //   dropdownSearchDecoration:
                  //       InputDecoration(labelText: "Name"),
                  //   asyncItems: (String filter) => getData(filter),
                  //   itemAsString: (UserModel u) => u.userAsString(),
                  //   onChanged: (UserModel? data) => print(data),
                  // ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Nomor Plat Kendaraan',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Masukan Plat Kendaraan',
                      labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 28 * width / 720),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  Text(
                    'Masa Berlaku STNK',
                    style: GoogleFonts.poppins(
                        fontSize: 28 * width / 720,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10 * height / 1280,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 28 * width / 720),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width:1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                           FocusNode()); // to prevent opening default keyboard
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        // format the picked date and set it to the text field
                        // you can use any date format you want
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(picked);
                        // use a text editing controller to update the text field
                        _controller.text = formattedDate;
                      }
                    },
                    controller: _controller, // controller for the text field
                  ),
                  SizedBox(
                    height: 28 * height / 1280,
                  ),
                  ButtonNext(text: 'Simpan', onPressed: () {}),
                  SizedBox(
                    height: 18 * height / 1280,
                  ),
                  ButtonPassed(text: 'Lewati', onPressed: () {})
                ],
              ),
            ),
          ),
        ));
  }
}
