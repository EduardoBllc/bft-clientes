enum BirthdayOption {
  month('deste mês:', 'este mês'),
  week('desta semana:', 'esta semana'),
  day('de hoje:', 'hoje');

  const BirthdayOption(this.text, this.emptyText);

  final String text;
  final String emptyText;
}
