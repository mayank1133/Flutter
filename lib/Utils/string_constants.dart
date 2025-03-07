const String NAME = 'Name';
const String AGE = 'Age';
const String EMAIL = 'Email';
const String PHONE = 'Phone';
const String CITY = 'City';
const String LOGIN_TEXT = 'LOGIN';
const String REGISTER_TEXT = 'REGISTER';
const List<String> cities = ["City",
  "Agartala", "Agra", "Ahmedabad", "Aizawl", "Ajmer",
  "Alappuzha", "Amritsar", "Asansol", "Aurangabad",
  "Belagavi", "Bengaluru", "Bhagalpur", "Bhavnagar",
  "Bhilai", "Bhopal", "Bhubaneswar", "Bikaner", "Bilaspur",
  "Bokaro", "Chandigarh", "Chennai", "Churachandpur", "Coimbatore",
  "Cuttack", "Dehradun", "Delhi", "Dhanbad", "Dimapur",
  "Durg", "Durgapur", "Faridabad", "Gangtok", "Gaya",
  "Ghaziabad", "Guwahati", "Gwalior", "Haldwani", "Haridwar",
  "Hubballi", "Hyderabad", "Imphal", "Indore", "Itanagar",
  "Jaipur", "Jalandhar", "Jammu", "Jamshedpur", "Jodhpur",
  "Jorhat", "Karnal", "Karimnagar", "Kochi", "Kohima",
  "Kolkata", "Korba", "Kota", "Kozhikode", "Kullu",
  "Kurnool", "Lucknow", "Ludhiana", "Lunglei", "Madurai",
  "Mangaluru", "Manali", "Margao", "Meerut", "Mysuru",
  "Nagpur", "Nainital", "Namchi", "Nashik", "Nizamabad",
  "Panaji", "Panipat", "Patiala", "Patna", "Pelling",
  "Pondicherry", "Pune", "Puri", "Raipur", "Rajkot",
  "Ranchi", "Rishikesh", "Rourkela", "Salem", "Sambalpur",
  "Shillong", "Shimla", "Siliguri", "Surat", "Tiruchirappalli",
  "Tirupati", "Tura", "Udaipur", "Ujjain", "Vadodara",
  "Varanasi", "Vasco da Gama", "Vijayawada", "Visakhapatnam", "Warangal"
];

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printResultText(String text) {
  print('\x1B[31m$text\x1B[0m');
}
