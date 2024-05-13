mixin MonthTake{
  String whichMonth(int month) {
    return switch (month) {
      1 => "Yan",
      2 => "Fev",
      3 => "Mar",
      4 => "Apr",
      5 => "May",
      6 => "Iyn",
      7 => "Iyl",
      8 => "Avg",
      9 => "Sen",
      10 => "Okt",
      11 => "Noy",
      12 => "Dek",
      _ => "",
    };
  }
}