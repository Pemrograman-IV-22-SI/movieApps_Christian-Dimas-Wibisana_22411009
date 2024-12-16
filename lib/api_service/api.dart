String baseUrl = "http://192.168.56.1:3000";

//auth
String register = "$baseUrl/users/register";
String login = "$baseUrl/users/login";

//image
String imageUrl = '$baseUrl/img/movie/';

//genre
String getAllGenre = "$baseUrl/genre/read";
String insertGenre = "$baseUrl/genre/insert";
String hapusGenre = "$baseUrl/genre/delete/";
String editGenre = "$baseUrl/genre/edit/";

//movie
String getAllMovie = "$baseUrl/movie/get-all/";
String hapusMovie = "$baseUrl/movie/delete/";
String inputMovie = "$baseUrl/movie/insert";

//transaction
String insertTransaksi = "$baseUrl/transaction/insert";
String getTransaksi = "$baseUrl/transaction/get-all";
