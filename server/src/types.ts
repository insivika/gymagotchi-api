export {}; // 👈 This ensures the file is treated as a module

declare global {
  namespace Express {
    interface Request {
      user?: any; // Replace 'any' with a more specific type, like `User`
    }
  }
}
