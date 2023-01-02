extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String removeAdditional() {
    if (toLowerCase().contains('-m') || toLowerCase().contains('-f')) {
      return substring(0, length - 2);
    } else if (toLowerCase().contains('-normal')) {
      return substring(0, length - 7);
    } else if (toLowerCase().contains('-plant')) {
      return substring(0, length - 6);
    } else if (toLowerCase().contains('-z')) {
      return substring(0, length - 2);
    } else if (toLowerCase().contains('-altered')) {
      return substring(0, length - 8);
    } else if (toLowerCase().contains('-land')) {
      return substring(0, length - 5);
    } else if (toLowerCase().contains('-red-striped')) {
      return substring(0, length - 12);
    } else if (toLowerCase().contains('-standard')) {
      return substring(0, length - 9);
    } else if (toLowerCase().contains('-incarnate')) {
      return substring(0, length - 10);
    } else if (toLowerCase().contains('-ordinary')) {
      return substring(0, length - 9);
    } else if (toLowerCase().contains('-aria')) {
      return substring(0, length - 5);
    } else if (toLowerCase().contains('-ma')) {
      return substring(0, length - 3);
    } else if (toLowerCase().contains('-shield')) {
      return substring(0, length - 7);
    } else if (toLowerCase().contains('-average')) {
      return substring(0, length - 8);
    } else if (toLowerCase().contains('-50')) {
      return substring(0, length - 3);
    } else if (toLowerCase().contains('-solo')) {
      return substring(0, length - 5);
    } else if (toLowerCase().contains('-midd')) {
      return substring(0, length - 5);
    } else if (toLowerCase().contains('-null')) {
      return substring(0, length - 5);
    } else if (toLowerCase().contains('-red-meteor')) {
      return substring(0, length - 11);
    } else if (toLowerCase().contains('-disguised')) {
      return substring(0, length - 10);
    } else if (toLowerCase().contains('-amped')) {
      return substring(0, length - 6);
    } else if (toLowerCase().contains('-full-bel')) {
      return substring(0, length - 9);
    } else if (toLowerCase().contains('-single-strike')) {
      return substring(0, length - 14);
    }
    return this;
  }

  String fixId() {
    if (length == 1) {
      return '#00$this';
    } else if (length == 2) {
      return '#0$this';
    } else {
      return '#$this';
    }
  }

  String fixStats() {
    if (toLowerCase().contains('hp')) {
      return 'HP';
    } else if (toLowerCase().contains('special-attack')) {
      return 'SATK';
    } else if (toLowerCase().contains('special-defense')) {
      return 'SDEF';
    } else if (toLowerCase().contains('attack')) {
      return 'ATK';
    } else if (toLowerCase().contains('defense')) {
      return 'DEF';
    } else if (toLowerCase().contains('speed')) {
      return 'SPD';
    } else {
      return '';
    }
  }
}
