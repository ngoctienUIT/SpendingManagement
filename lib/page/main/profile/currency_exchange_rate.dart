import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:html/dom.dart' as html_parser;
import 'package:spending_management/constants/function/extension.dart';

import '../../../models/api_service.dart';
import '../../../setting/localization/app_localizations.dart';

class CurrencyExchangeRate extends StatefulWidget {
  const CurrencyExchangeRate({Key? key}) : super(key: key);

  @override
  State<CurrencyExchangeRate> createState() => _CurrencyExchangeRateState();
}

class _CurrencyExchangeRateState extends State<CurrencyExchangeRate> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String selectedValue = "VND";
  Map<String, dynamic> currency = {};
  List<Map<String, dynamic>> listCountry = [];

  @override
  void initState() {
    super.initState();
    _moneyController.text = "1";
    _moneyController.addListener(() => setState(() {}));
    _searchController.addListener(() => setState(() {}));
    APIService.getExchangeRate().then((value) {
      setState(() => currency = value);
    });
    APIService.getCountry().then((value) {
      setState(() => listCountry = value);
    });
  }

  @override
  void dispose() {
    _moneyController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          AppLocalizations.of(context).translate('currency_exchange_rate'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _moneyController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      border: InputBorder.none,
                      hintText: "100.000",
                      counterText: "",
                      hintStyle: const TextStyle(fontSize: 20),
                      contentPadding: const EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      dropdownMaxHeight: 200,
                      hint: Text(
                        'VND',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: currency.entries
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item.key,
                              child: Text(
                                item.key,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).backgroundColor,
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 20),
                maxLength: 15,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)
                      .translate('search_by_country_name_or_currency'),
                  counterText: "",
                  hintStyle: const TextStyle(fontSize: 16),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            listCurrency(),
          ],
        ),
      ),
    );
  }

  bool check(String text) {
    return text.toUpperCase().contains(_searchController.text.toUpperCase());
  }

  Widget listCurrency() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: currency.entries.length,
      itemBuilder: (context, index) {
        var country = listCountry
            .where((element) =>
                element["currencyCode"] ==
                currency.entries.elementAt(index).key)
            .toList();
        return (check(currency.entries.elementAt(index).key) ||
                country.isNotEmpty && check(country[0]["countryName"]))
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (country.isNotEmpty &&
                                  country[0]["symbol"] != "")
                                Text(
                                  html_parser.DocumentFragment.html(
                                          country[0]["symbol"])
                                      .text!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (country.isNotEmpty &&
                                  country[0]["symbol"] != "")
                                const SizedBox(height: 5),
                              Text(
                                currency.entries.elementAt(index).key,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        const VerticalDivider(
                            color: Colors.black, thickness: 1),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${(currency.entries.elementAt(index).value / currency[selectedValue] * int.parse(_moneyController.text.isNotEmpty ? _moneyController.text : "0"))}"
                                    .formatByTNT(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Flexible(
                                child: Text(
                                  "1 $selectedValue ≈ "
                                  "${"${currency.entries.elementAt(index).value / currency[selectedValue]}".formatByTNT()} "
                                  "${currency.entries.elementAt(index).key}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              "https://countryflagsapi.com/png/${country.isNotEmpty ? country[0]["countryName"] : ""}",
                          width: 45,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 30,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 30,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                "N/A",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
