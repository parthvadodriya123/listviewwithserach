import 'package:flutter/material.dart';
import 'package:listviewwithserach/models.dart';
import 'package:listviewwithserach/repostrory/data.dart';
import 'package:get/get.dart';

class ListViewSearching extends StatefulWidget {
  const ListViewSearching({Key? key}) : super(key: key);

  @override
  State<ListViewSearching> createState() => _ListViewSearchingState();
}

class _ListViewSearchingState extends State<ListViewSearching> {
  Repository repository = Repository();
  Map<String, bool> serching = {
    "Name": false,
    "SurName": false,
    "CompanyName": false,
    "PhoneNo": false
  };
  var noData = "No Data Found".obs;
  List list = [];
  List<ProfileData> profileData = [];
  TextEditingController search = TextEditingController();
  List nameStr = [];

  @override
  void initState() {
    print(repository.data.length);
    super.initState();
    list = serching.values.toList();
    nameStr = serching.keys.toList();
    profileData.addAll(repository.data);
  }

  //SimpleDialog,Dialog,AlertDialog

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Filter"),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: list[index],
                          onChanged: (value) {
                            list[index] = value!;
                            setState(() {});
                          },
                          title: Text(serching.keys.toList()[index]));
                    },
                    itemCount: list.length,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: search,
                  onChanged: (value) {
                    if (search.text.isEmpty || search.text == null) {
                      repository.data.clear();
                      repository.data.addAll(profileData);
                    } else if (noData.value == "No Data Found") {
                      dataFetch();
                    } else {
                      dataFetch();
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      hintText: "Search Hear",
                      suffixIcon: IconButton(
                          onPressed: () {
                            _showAlertDialog();
                          },
                          icon: const Icon(Icons.filter_alt_sharp))),
                ),
              ),
              repository.data.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                        Text(noData.value.toString()),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: repository.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${nameStr[0] + ": " + repository.data[index].name}"),
                                Text(
                                    "${nameStr[1] + ": " + repository.data[index].surName}"),
                                Text(
                                    "${nameStr[2] + ": " + repository.data[index].companyName}"),
                                Text(
                                    "${nameStr[3] + ": " + repository.data[index].phoneNo}")
                              ],
                            ),
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }

  void dataFetch() {
    repository.data = profileData;
    int length = list.where((element) => element == true).toList().length;
    List nameKeys = [];


    for (int i = 0; i < serching.length; i++) {
      if (list[i] == true) {
        nameKeys.add(serching.keys.toList()[i]);
      }
    }

    if (length == 1) {
      repository.data = repository.data.where((element) {
        List name = [
          element.name,
          element.surName,
          element.companyName,
          element.phoneNo
        ];
        for (int i = 0; i < list.length; i++) {
          if (list[i] == true) {
            return name[i].contains(search.text);
          }
        }
        return true;
      }).toList();
    }
    else if (length == 2) {
      repository.data = repository.data.where((element) {
        List name = [
          element.name,
          element.surName,
          element.companyName,
          element.phoneNo
        ];

        int index1 = nameStr.indexOf(nameKeys[0]);
        int index2 = nameStr.indexOf(nameKeys[1]);
        return name[index1].contains(search.text) ||
            name[index2].contains(search.text);
      }).toList();
    }
    else if (length == 3) {
      repository.data = repository.data.where((element) {
        List name = [
          element.name,
          element.surName,
          element.companyName,
          element.phoneNo
        ];

        int index1 = nameStr.indexOf(nameKeys[0]);
        int index2 = nameStr.indexOf(nameKeys[1]);
        int index3 = nameStr.indexOf(nameKeys[2]);
        return name[index1].contains(search.text) ||
            name[index2].contains(search.text) ||
            name[index3].contains(search.text);
      }).toList();
    }
    else {
      repository.data = repository.data
          .where((element) =>
              element.name!.contains(search.text) ||
              element.surName!.contains(search.text) ||
              element.companyName!.contains(search.text) ||
              element.phoneNo!.contains(search.text))
          .toList();
    }
  }
}
