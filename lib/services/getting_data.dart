class GettingData {
  List statesUt = [];
  List confirm = [];
  List confirmDelta = [];
  List decease = [];
  List rec = [];
  List recDelta = [];
  List deceDelta = [];

  var confirmed;
  var active;
  var recovered;
  var deceased;
  var updatedTill;
  var confirmedDelta;
  var recoveredDelta;
  var deceasedDelta;

  void updateUI(dynamic data) {
    if (data == null) {
      confirmed = 0;
      active = 0;
      deceased = 0;
      updatedTill = 'nil';
      recovered = 0;
      confirmedDelta = 0;
      recoveredDelta = 0;
      deceasedDelta = 0;
    } else {
      statesUt = [];
      confirm = [];
      confirmDelta = [];
      decease = [];
      rec = [];
      recDelta = [];
      deceDelta = [];

      confirmed = data['statewise'][0]['confirmed'];
      active = data['statewise'][0]['active'];
      deceased = data['statewise'][0]['deaths'];
      updatedTill = data['statewise'][0]['lastupdatedtime'];
      recovered = data['statewise'][0]['recovered'];
      confirmedDelta = data['statewise'][0]['deltaconfirmed'];
      recoveredDelta = data['statewise'][0]['deltarecovered'];
      deceasedDelta = data['statewise'][0]['deltadeaths'];

      for (int i = 1; i < 38; i++) {
        statesUt.add(data['statewise'][i]['state']);
        confirm.add(data['statewise'][i]['confirmed']);
        confirmDelta.add(data['statewise'][i]['deltaconfirmed']);
        decease.add(data['statewise'][i]['deaths']);
        rec.add(data['statewise'][i]['recovered']);
        recDelta.add(data['statewise'][i]['deltarecovered']);
        deceDelta.add(data['statewise'][i]['deltadeaths']);
      }
    }
  }
}
