// String BASE_URL = "http://94.100.26.115:1337/api/";
/// API URLS
String BASE_URL = "https://noticeapi.techoverltd.com/api/";

String AUTH_LOGIN = "auth/local";
String CATEGORIES = "categories";
String NOTICES = "detailed-notices?populate=%2A";
String GET_CATEGORIZED_NOTICES =
    "detailed-notices?populate=category&filters%5Bcategory%5D=";

String PREFERRED_DETAILED_NOTICE =
    "https://noticeapi.techoverltd.com/v1/api/preferred-detailed-notice";

String DEGREE_LENGTH =
    "degree-lengths?pagination%5BpageSize%5D=1000&populate=%2A";

String USER_PREFERENCE = "user-preferences";

String TUTOR_LIST = "tutor-lists";


// All Notice : 1
// Exam Notice : 2
// Special Notice : 3
// Leave Notice : 4
// Result Notice: 6


/// duration_years 
/// duration_semesters
/// degree -> degree_name
/// faculty -> faculty_name
/// subject -> subject_name
/// 

/// STRUCTURE 

//data [
  //attributes{
/// duration_years,  duration_semesters
/// degree -> data -> attributes -> degree_name
/// faculty -> data -> attributes -> faculty_name
/// subject -> data -> attributes -> subject_name
/// 
/// }
/// ]



