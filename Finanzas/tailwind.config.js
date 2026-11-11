/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        nv: {
          primary: "#0B132B",
          accent: "#00FF87",
          bg: "#FFFFFF",
          text: "#0B132B",
          muted: "#6B7280",
          border: "#E5E7EB",
        },
      },
    },
  },
  plugins: [],
};
