enum OpportunityType {
  all("All"),
  art("Art"),
  engineering("Engineering"),
  business("Business"),
  technology("Technology"),
  dataScience("Data Science");

  const OpportunityType(this.type);
  final String type;
}

enum OpportunityTab {
  jobs("Jobs"),
  scholarships("Scholarships");

  const OpportunityTab(this.tab);
  final String tab;

  @override
  String toString() => tab;
}

enum EventTab {
  upcoming("Upcoming"),
  past("Past events");

  const EventTab(this.tab);
  final String tab;

  @override
  String toString() => tab;
}
