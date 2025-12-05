# Create SocialHook Project Structure for RN 0.76.0
# Run this from your project root directory (D:\ShookUI\SocialHook)

Write-Host "🚀 Creating SocialHook Project Structure for RN 0.76.0..." -ForegroundColor Green

# Define project root
$projectRoot = Get-Location
$srcPath = Join-Path $projectRoot "src"

# Create main directories
$directories = @(
    "src",
    "src/assets",
    "src/assets/images",
    "src/assets/fonts",
    "src/assets/icons",
    
    "src/core",
    "src/core/components",
    "src/core/navigation",
    "src/core/store",
    "src/core/services",
    "src/core/hooks",
    "src/core/utils",
    "src/core/constants",
    "src/core/theme",
    
    "src/features",
    "src/features/auth",
    "src/features/auth/components",
    "src/features/auth/screens",
    "src/features/auth/services",
    "src/features/auth/slices",
    "src/features/auth/types",
    "src/features/auth/hooks",
    
    "src/features/groups",
    "src/features/groups/components",
    "src/features/groups/screens",
    "src/features/groups/services",
    "src/features/groups/slices",
    
    "src/features/wallet",
    "src/features/wallet/components",
    "src/features/wallet/screens",
    "src/features/wallet/services",
    "src/features/wallet/slices",
    
    "src/features/profile",
    "src/features/profile/components",
    "src/features/profile/screens",
    "src/features/profile/services",
    "src/features/profile/slices"
)

# Create directories
foreach ($dir in $directories) {
    $fullPath = Join-Path $projectRoot $dir
    if (!(Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        Write-Host "📁 Created: $dir" -ForegroundColor Cyan
    }
}

# Function to create file with content
function Create-File {
    param($Path, $Content)
    $fullPath = Join-Path $projectRoot $Path
    if (!(Test-Path $fullPath)) {
        $Content | Out-File -FilePath $fullPath -Encoding UTF8
        Write-Host "📄 Created: $Path" -ForegroundColor Green
    }
}

# 1. Root Configuration Files

Create-File -Path "tailwind.config.js" -Content @'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{js,jsx,ts,tsx}',
    './App.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#6200ee',
        primaryDark: '#3700b3',
        secondary: '#03dac4',
        accent: '#ff4081',
        background: '#f6f6f6',
        surface: '#ffffff',
        error: '#B00020',
        success: '#4CAF50',
        warning: '#FF9800',
        'debate-active': '#4CAF50',
        'debate-ended': '#9E9E9E',
        'text-primary': '#000000',
        'text-secondary': '#666666',
        'border-light': '#e0e0e0',
      },
      fontFamily: {
        sans: ['Roboto', 'system-ui'],
      },
    },
  },
  plugins: [],
};
'@

Create-File -Path "metro.config.js" -Content @'
const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');

/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = {
  transformer: {
    babelTransformerPath: require.resolve('react-native-svg-transformer'),
  },
  resolver: {
    assetExts: getDefaultConfig(__dirname).resolver.assetExts.filter(
      ext => ext !== 'svg',
    ),
    sourceExts: [...getDefaultConfig(__dirname).resolver.sourceExts, 'svg'],
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
'@

Create-File -Path "babel.config.js" -Content @'
module.exports = {
  presets: ['module:@react-native/babel-preset'],
  plugins: [
    [
      'module-resolver',
      {
        root: ['./src'],
        extensions: ['.ios.js', '.android.js', '.js', '.ts', '.tsx', '.json'],
        alias: {
          '@': './src',
          '@features': './src/features',
          '@core': './src/core',
          '@assets': './src/assets',
        },
      },
    ],
    'react-native-reanimated/plugin',
    'tailwindcss-react-native/babel',
  ],
};
'@

# 2. Update Package.json with compatible versions
Write-Host "`n📦 Updating package.json with compatible dependencies..." -ForegroundColor Yellow

$packageJsonPath = Join-Path $projectRoot "package.json"
$packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

# Add dependencies compatible with RN 0.76.0
$packageJson.dependencies | Add-Member -NotePropertyName "@react-native-async-storage/async-storage" -NotePropertyValue "^2.0.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@react-navigation/native" -NotePropertyValue "^6.1.9" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@react-navigation/stack" -NotePropertyValue "^6.3.20" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@react-navigation/bottom-tabs" -NotePropertyValue "^6.5.12" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@reduxjs/toolkit" -NotePropertyValue "^2.2.7" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "axios" -NotePropertyValue "^1.6.2" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "date-fns" -NotePropertyValue "^2.30.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "nativewind" -NotePropertyValue "^2.0.11" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-hook-form" -NotePropertyValue "^7.48.2" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-bootsplash" -NotePropertyValue "^6.3.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-fast-image" -NotePropertyValue "^8.6.3" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-gesture-handler" -NotePropertyValue "^2.15.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-image-picker" -NotePropertyValue "^5.9.1" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-keychain" -NotePropertyValue "^9.1.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-otp-textinput" -NotePropertyValue "^0.0.8" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-paper" -NotePropertyValue "^5.12.5" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-reanimated" -NotePropertyValue "^3.10.1" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-safe-area-context" -NotePropertyValue "^4.9.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-screens" -NotePropertyValue "^3.29.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-toast-message" -NotePropertyValue "^2.1.7" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-vector-icons" -NotePropertyValue "^10.1.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "react-redux" -NotePropertyValue "^9.1.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "redux-persist" -NotePropertyValue "^6.0.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "tailwindcss-react-native" -NotePropertyValue "^1.7.9" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "zod" -NotePropertyValue "^3.22.4" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@hookform/resolvers" -NotePropertyValue "^3.3.2" -Force

# Optional dependencies for later
$packageJson.dependencies | Add-Member -NotePropertyName "react-native-google-mobile-ads" -NotePropertyValue "^13.0.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@react-native-firebase/app" -NotePropertyValue "^20.0.0" -Force
$packageJson.dependencies | Add-Member -NotePropertyName "@react-native-firebase/messaging" -NotePropertyValue "^20.0.0" -Force

# Update dev dependencies
$packageJson.devDependencies | Add-Member -NotePropertyName "react-native-svg-transformer" -NotePropertyValue "^1.3.0" -Force
$packageJson.devDependencies | Add-Member -NotePropertyName "tailwindcss" -NotePropertyValue "^3.4.0" -Force

$packageJson | ConvertTo-Json -Depth 10 | Out-File $packageJsonPath -Encoding UTF8
Write-Host "✅ Updated package.json" -ForegroundColor Green

# 3. Core Files

Create-File -Path "src/core/theme/index.ts" -Content @'
import {DefaultTheme, configureFonts} from 'react-native-paper';
import {Platform} from 'react-native';

const fontConfig = {
  regular: {
    fontFamily: Platform.select({
      ios: 'System',
      android: 'Roboto',
      default: 'sans-serif',
    }),
    fontWeight: '400' as const,
  },
  medium: {
    fontFamily: Platform.select({
      ios: 'System',
      android: 'Roboto-Medium',
      default: 'sans-serif-medium',
    }),
    fontWeight: '500' as const,
  },
  bold: {
    fontFamily: Platform.select({
      ios: 'System',
      android: 'Roboto-Bold',
      default: 'sans-serif-bold',
    }),
    fontWeight: '700' as const,
  },
};

export const theme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    primary: '#6200ee',
    accent: '#03dac4',
    background: '#f6f6f6',
    surface: '#ffffff',
    error: '#B00020',
    text: '#000000',
    disabled: 'rgba(0, 0, 0, 0.26)',
    placeholder: 'rgba(0, 0, 0, 0.54)',
    backdrop: 'rgba(0, 0, 0, 0.5)',
  },
  fonts: configureFonts({config: fontConfig}),
  roundness: 8,
};

export type AppTheme = typeof theme;
'@

Create-File -Path "src/core/constants/index.ts" -Content @'
export const API_BASE_URL = __DEV__
  ? 'http://localhost:8080/api'
  : 'https://api.socialhook.com/api';

export const API_ENDPOINTS = {
  AUTH: {
    SIGNUP: '/auth/signup',
    LOGIN: '/auth/login',
    REFRESH: '/auth/refresh',
    VERIFY_OTP: '/auth/verify-otp',
  },
  USERS: {
    ME: '/users/me',
    UPDATE_PROFILE: '/users/me',
  },
} as const;

export const STORAGE_KEYS = {
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token',
  USER_DATA: 'user_data',
} as const;

export const APP_CONSTANTS = {
  OTP_LENGTH: 6,
  MIN_PASSWORD_LENGTH: 6,
  MAX_PHONE_LENGTH: 15,
} as const;
'@

# 4. Create TypeScript declaration files
Create-File -Path "src/types/images.d.ts" -Content @'
declare module '*.png' {
  const value: any;
  export default value;
}

declare module '*.jpg' {
  const value: any;
  export default value;
}

declare module '*.jpeg' {
  const value: any;
  export default value;
}

declare module '*.gif' {
  const value: any;
  export default value;
}

declare module '*.svg' {
  import React from 'react';
  import {SvgProps} from 'react-native-svg';
  const content: React.FC<SvgProps>;
  export default content;
}
'@

# 5. Create App.tsx (updated for RN 0.76.0)
Create-File -Path "App.tsx" -Content @'
import React from 'react';
import {SafeAreaProvider} from 'react-native-safe-area-context';
import {TailwindProvider} from 'tailwindcss-react-native';
import {Provider as PaperProvider} from 'react-native-paper';
import {Provider as ReduxProvider} from 'react-redux';
import {PersistGate} from 'redux-persist/integration/react';
import {NavigationContainer} from '@react-navigation/native';
import Toast from 'react-native-toast-message';

import {store, persistor} from '@/core/store';
import {theme} from '@/core/theme';
import RootNavigator from '@/core/navigation/RootNavigator';

function App(): React.JSX.Element {
  return (
    <TailwindProvider>
      <SafeAreaProvider>
        <ReduxProvider store={store}>
          <PersistGate loading={null} persistor={persistor}>
            <PaperProvider theme={theme}>
              <NavigationContainer>
                <RootNavigator />
              </NavigationContainer>
              <Toast />
            </PaperProvider>
          </PersistGate>
        </ReduxProvider>
      </SafeAreaProvider>
    </TailwindProvider>
  );
}

export default App;
'@

# 6. Create index.js for NativeWind
Create-File -Path "index.js" -Content @'
import {AppRegistry} from 'react-native';
import App from './App';
import {name as appName} from './app.json';

// Import gesture handler at the top (required for react-navigation)
import 'react-native-gesture-handler';

AppRegistry.registerComponent(appName, () => App);
'@

# 7. Create minimal auth slice (simplified for RN 0.76 compatibility)
Create-File -Path "src/features/auth/slices/authSlice.ts" -Content @'
import {createSlice, createAsyncThunk, PayloadAction} from '@reduxjs/toolkit';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {STORAGE_KEYS} from '@/core/constants';

export interface User {
  id: string;
  phone_number: string;
  email?: string;
  username: string;
  full_name?: string;
  avatar_url?: string;
  status: 'active' | 'suspended' | 'banned';
  role: 'user' | 'admin';
}

export interface AuthState {
  user: User | null;
  token: string | null;
  refreshToken: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  error: string | null;
}

const initialState: AuthState = {
  user: null,
  token: null,
  refreshToken: null,
  isAuthenticated: false,
  isLoading: true,
  error: null,
};

export const checkAuth = createAsyncThunk('auth/checkAuth', async () => {
  const token = await AsyncStorage.getItem(STORAGE_KEYS.ACCESS_TOKEN);
  const userData = await AsyncStorage.getItem(STORAGE_KEYS.USER_DATA);
  
  if (token && userData) {
    return {
      token,
      user: JSON.parse(userData),
    };
  }
  
  throw new Error('No authentication data found');
});

export const logout = createAsyncThunk('auth/logout', async () => {
  await AsyncStorage.multiRemove([
    STORAGE_KEYS.ACCESS_TOKEN,
    STORAGE_KEYS.REFRESH_TOKEN,
    STORAGE_KEYS.USER_DATA,
  ]);
});

const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {
    clearError: state => {
      state.error = null;
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.isLoading = action.payload;
    },
    setAuthData: (state, action: PayloadAction<{user: User; token: string; refreshToken: string}>) => {
      state.user = action.payload.user;
      state.token = action.payload.token;
      state.refreshToken = action.payload.refreshToken;
      state.isAuthenticated = true;
    },
  },
  extraReducers: builder => {
    builder
      .addCase(checkAuth.pending, state => {
        state.isLoading = true;
      })
      .addCase(checkAuth.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isAuthenticated = true;
        state.token = action.payload.token;
        state.user = action.payload.user;
      })
      .addCase(checkAuth.rejected, state => {
        state.isLoading = false;
        state.isAuthenticated = false;
      })
      .addCase(logout.fulfilled, state => {
        state.user = null;
        state.token = null;
        state.refreshToken = null;
        state.isAuthenticated = false;
        state.error = null;
      });
  },
});

export const {clearError, setLoading, setAuthData} = authSlice.actions;
export default authSlice.reducer;
'@

# 8. Create store files
Create-File -Path "src/core/store/index.ts" -Content @'
import {configureStore} from '@reduxjs/toolkit';
import {
  persistStore,
  persistReducer,
  FLUSH,
  REHYDRATE,
  PAUSE,
  PERSIST,
  PURGE,
  REGISTER,
} from 'redux-persist';
import AsyncStorage from '@react-native-async-storage/async-storage';
import rootReducer from './rootReducer';

const persistConfig = {
  key: 'root',
  storage: AsyncStorage,
  whitelist: ['auth'],
  version: 1,
};

const persistedReducer = persistReducer(persistConfig, rootReducer);

export const store = configureStore({
  reducer: persistedReducer,
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: [FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER],
      },
    }),
});

export const persistor = persistStore(store);

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
'@

Create-File -Path "src/core/store/rootReducer.ts" -Content @'
import {combineReducers} from '@reduxjs/toolkit';
import authSlice from '@/features/auth/slices/authSlice';

const rootReducer = combineReducers({
  auth: authSlice,
});

export default rootReducer;
'@

# 9. Create basic screens (simplified for now)
Create-File -Path "src/features/auth/screens/SplashScreen.tsx" -Content @'
import React, {useEffect} from 'react';
import {View, StatusBar, Image} from 'react-native';
import {useDispatch} from 'react-redux';
import {checkAuth} from '../slices/authSlice';
import {ActivityIndicator} from 'react-native-paper';

const SplashScreen = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    const initializeApp = async () => {
      try {
        await dispatch(checkAuth()).unwrap();
      } catch (error) {
        console.log('Auth check failed:', error);
      }
    };

    initializeApp();
  }, [dispatch]);

  return (
    <View className="flex-1 bg-primary justify-center items-center">
      <StatusBar barStyle="light-content" backgroundColor="#6200ee" />
      <Image
        source={require('@/assets/images/logo.png')}
        className="w-48 h-24 mb-10"
        resizeMode="contain"
      />
      <ActivityIndicator size="large" color="#fff" />
    </View>
  );
};

export default SplashScreen;
'@

Create-File -Path "src/features/auth/screens/LoginScreen.tsx" -Content @'
import React from 'react';
import {View, Text, TouchableOpacity} from 'react-native';
import {NativeStackScreenProps} from '@react-navigation/native-stack';
import {AuthStackParamList} from '@/core/navigation/AuthNavigator';
import {Button} from 'react-native-paper';

type Props = NativeStackScreenProps<AuthStackParamList, 'Login'>;

const LoginScreen = ({navigation}: Props) => {
  return (
    <View className="flex-1 bg-background justify-center p-6">
      <Text className="text-3xl font-bold text-center text-primary mb-10">
        SocialHook
      </Text>
      
      <View className="space-y-4">
        <Button
          mode="contained"
          onPress={() => {}}
          className="py-2">
          Login with Phone
        </Button>
        
        <Button
          mode="outlined"
          onPress={() => navigation.navigate('Signup')}
          className="py-2">
          Create Account
        </Button>
      </View>
      
      <TouchableOpacity 
        className="mt-8 items-center"
        onPress={() => {}}>
        <Text className="text-primary">Skip for now</Text>
      </TouchableOpacity>
    </View>
  );
};

export default LoginScreen;
'@

# 10. Create navigation files
Create-File -Path "src/core/navigation/RootNavigator.tsx" -Content @'
import React from 'react';
import {createStackNavigator} from '@react-navigation/stack';
import {useSelector} from 'react-redux';
import {RootState} from '@/core/store';
import {View, ActivityIndicator} from 'react-native';

import AuthNavigator from './AuthNavigator';
import AppNavigator from './AppNavigator';

const Stack = createStackNavigator();

const RootNavigator = () => {
  const {isAuthenticated, isLoading} = useSelector(
    (state: RootState) => state.auth,
  );

  if (isLoading) {
    return (
      <View className="flex-1 justify-center items-center bg-background">
        <ActivityIndicator size="large" color="#6200ee" />
      </View>
    );
  }

  return (
    <Stack.Navigator screenOptions={{headerShown: false}}>
      {!isAuthenticated ? (
        <Stack.Screen name="Auth" component={AuthNavigator} />
      ) : (
        <Stack.Screen name="App" component={AppNavigator} />
      )}
    </Stack.Navigator>
  );
};

export default RootNavigator;
'@

Create-File -Path "src/core/navigation/AuthNavigator.tsx" -Content @'
import React from 'react';
import {createStackNavigator} from '@react-navigation/stack';

import SplashScreen from '@/features/auth/screens/SplashScreen';
import LoginScreen from '@/features/auth/screens/LoginScreen';
import SignupScreen from '@/features/auth/screens/SignupScreen';
import OTPVerificationScreen from '@/features/auth/screens/OTPVerificationScreen';

export type AuthStackParamList = {
  Splash: undefined;
  Login: undefined;
  Signup: undefined;
  OTPVerification: {phoneNumber: string; userId?: string};
};

const Stack = createStackNavigator<AuthStackParamList>();

const AuthNavigator = () => {
  return (
    <Stack.Navigator
      initialRouteName="Splash"
      screenOptions={{
        headerShown: false,
        cardStyle: {backgroundColor: '#fff'},
      }}>
      <Stack.Screen name="Splash" component={SplashScreen} />
      <Stack.Screen name="Login" component={LoginScreen} />
      <Stack.Screen name="Signup" component={SignupScreen} />
      <Stack.Screen name="OTPVerification" component={OTPVerificationScreen} />
    </Stack.Navigator>
  );
};

export default AuthNavigator;
'@

Create-File -Path "src/core/navigation/AppNavigator.tsx" -Content @'
import React from 'react';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {View, Text} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const HomeScreen = () => (
  <View className="flex-1 justify-center items-center">
    <Text>Home Screen</Text>
  </View>
);

const GroupsScreen = () => (
  <View className="flex-1 justify-center items-center">
    <Text>My Groups</Text>
  </View>
);

const WalletScreen = () => (
  <View className="flex-1 justify-center items-center">
    <Text>Wallet</Text>
  </View>
);

const ProfileScreen = () => (
  <View className="flex-1 justify-center items-center">
    <Text>Profile</Text>
  </View>
);

const Tab = createBottomTabNavigator();

const AppNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={({route}) => ({
        tabBarIcon: ({focused, color, size}) => {
          let iconName;

          switch (route.name) {
            case 'Home':
              iconName = focused ? 'home' : 'home-outline';
              break;
            case 'Groups':
              iconName = focused ? 'account-group' : 'account-group-outline';
              break;
            case 'Wallet':
              iconName = focused ? 'wallet' : 'wallet-outline';
              break;
            case 'Profile':
              iconName = focused ? 'account' : 'account-outline';
              break;
            default:
              iconName = 'help';
          }

          return <Icon name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#6200ee',
        tabBarInactiveTintColor: '#666',
        headerShown: false,
      })}>
      <Tab.Screen name="Home" component={HomeScreen} />
      <Tab.Screen name="Groups" component={GroupsScreen} />
      <Tab.Screen name="Wallet" component={WalletScreen} />
      <Tab.Screen name="Profile" component={ProfileScreen} />
    </Tab.Navigator>
  );
};

export default AppNavigator;
'@

# Create placeholder files
Create-File -Path "src/features/auth/screens/SignupScreen.tsx" -Content @'
import React from 'react';
import {View, Text} from 'react-native';

const SignupScreen = () => {
  return (
    <View className="flex-1 justify-center items-center">
      <Text>Signup Screen</Text>
    </View>
  );
};

export default SignupScreen;
'@

Create-File -Path "src/features/auth/screens/OTPVerificationScreen.tsx" -Content @'
import React from 'react';
import {View, Text} from 'react-native';

const OTPVerificationScreen = () => {
  return (
    <View className="flex-1 justify-center items-center">
      <Text>OTP Verification Screen</Text>
    </View>
  );
};

export default OTPVerificationScreen;
'@

Write-Host "`n✅ Project structure created successfully!" -ForegroundColor Green
Write-Host "`n📦 Next steps:" -ForegroundColor Yellow
Write-Host "1. Run: npm install" -ForegroundColor Cyan
Write-Host "2. Add your logo to: src/assets/images/logo.png" -ForegroundColor Cyan
Write-Host "   (create a placeholder if needed)" -ForegroundColor Gray
Write-Host "3. Install pods for iOS (if needed):" -ForegroundColor Cyan
Write-Host "   cd ios && pod install && cd .." -ForegroundColor Cyan
Write-Host "4. Run the app:" -ForegroundColor Cyan
Write-Host "   npx react-native run-android" -ForegroundColor Cyan
Write-Host "   OR" -ForegroundColor Cyan
Write-Host "   npx react-native run-ios" -ForegroundColor Cyan
Write-Host "`n⚠️  Note: This is a simplified setup for RN 0.76.0" -ForegroundColor Magenta
Write-Host "   Full auth screens will be implemented after dependencies are installed." -ForegroundColor Magenta