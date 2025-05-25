import GoogleFit, { Scopes } from 'react-native-google-fit';

const options = {
  scopes: [
    Scopes.FITNESS_ACTIVITY_READ,
    Scopes.FITNESS_ACTIVITY_WRITE,
  ],
};

GoogleFit.authorize(options)
  .then(authResult => {
    if (authResult.success) {
      console.log("✅ Google Fit authorized");
    } else {
      console.log("❌ Google Fit authorization failed", authResult.message);
    }
  });