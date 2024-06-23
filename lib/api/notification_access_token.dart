import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async =>
      _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
        // > Click on 'Generate new private key' Btn & Json file will be downloaded

        // Paste Your Generated Json File Content
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "volunteer-3d7d6",
          "private_key_id": "57f54435b9a657a06d06d83522623a540a1e8c2c",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDC22OmGlUPFbdB\nQaMOdf+vJuPeGW75mAUdT9j7xX23vs1wAwCEm+hcnIajl6BQS5aDgkdhcVhOxk+f\nwceg8ogjoCwbzsg8n8nmxvIRRSsjlqndTTni7KhhbP9mq7EI25aoB3zSK4yBW1Vr\nqd/fLvUqy9vRB3Buoye1k2MTI3LGwV3s87FZfncl9NvncVr+WbwE0O8hGCQZaivs\n3RrniqAGdeGQlyXv0N1CRoQdY9I0U+g3PEfyjuvMnSWLUVGiheBoVFL36Nl/tlLA\n3G3yxA+w1qi2+Jtbjuoib0LGuPj/Ro2RR3qO9khwDFFml5cbYGnvj9SkAzr4daA9\nO2+zWwyrAgMBAAECggEAEceKikuTyvURzAgCVJ2gBKoj7OOINIj89SWQfbnm6d75\n3XMWAdjnSkVT+ar/oI6iagHMo+T/iEHgXl+EPg4d2ED9//7jAWPDvJAW4qGGOVCU\nKOeqKlJVXie1Ds1dXBq2iUK++RRVKoZxabSjLeOZ0NuvWnLMfPkxHzMWvVZ6MLf8\n4fueCkxxMRu2L5SwB3cZYiBI8+ebeS+ObY6wwYj9n52h0KPpm8HhR4vibrqtR3xX\nFzusv4fBc6DlK43lxTJp+G2R/Ma9OFA+6nMIc/h7z2WW7DV14QmT14UW5imaua7K\n5XIUKIK3HnLEwV6Xq689G2tmotKX3Cmjgfa11PDUeQKBgQDwbnvYKfUN7+9h2kYR\n9qyNDEDcxlj3h9oBwgWPf24DAc65ieug4nA5rt9fQVqczBOUoT5QPlMVPLpQB6Go\nSUVczZyWtqOwvjlIE9L9BqiJAJ+Myos/IY5hHSQagh8ulEJKwfELR+H22rEKYjMY\nA04tPzlnAIFcKWJfJxGPwGgFIwKBgQDPeXAbFskvUmUIF2ulb+oqnbRWA/0VWHlX\ngYkRB7o9/t6mII2y3AKh7kS30sNG94TR89B19TZ+pf1xOccqNiWHdPp835S+gxRJ\n6bzACw4dSWciz3a16i8EteIIRUOf/qe8oaVEEE8FS45T0ZjjQkWlrpxOl2rzpYyM\n+JYfd16m2QKBgQDp0wkuWN+yBj5Qc+7hWXzGT7xk+aFcWgpy2zZ9L/jVg9SALNmz\nRYTPFHq4MN7mzrHcQlRPxc0XQlAPtNxKxbdnYa+AA29+XAFpT55J5UfStYB1dCWn\n6AKH/8c04IdizV0LR0IdLnNbl6PF7WqzV8OXzX0N5zfnYXgCAgTaQMzo8QKBgQCL\nnPdwcyvc2UA9aq04fZABL3B79WEoLQoydWuL9zw/nbOr7PoNYvmuiAzb+ksIBWXu\ndnhP+Du8i+x5ddztLdShS3mH8FhCvyg2+L/YJ1hPIubxSNRkY/tR2ycIU7vG/XFY\ngRoaLDNQp+BVzRRp0V3WuSJbzI7e+AcVke5LrGMYOQKBgQDKJKqkxNik9JKKovcp\ntzAnUPiLbKZvuMjIkohoQ4NtDsAJo/3bIFbgbOq4NK8TYCbErevuoUQwkoAoAV19\naxswBznvig3adt0O36Ze31QdMvJ2E//1aThLD7OVwSKa9C67tIMKl0trV5whJlim\nklyqDh0/RRZhRNF0EHzOT7kPtA==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-xma86@volunteer-3d7d6.iam.gserviceaccount.com",
          "client_id": "105310159447261887355",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-xma86%40volunteer-3d7d6.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
