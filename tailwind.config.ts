import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "gradient-conic":
          "conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))",
          "bg_img": "url('https://www.google.com/url?sa=i&url=https%3A%2F%2Fkor.pngtree.com%2Ffreebackground%2Fstudents-and-readers-gathered-in-a-library-enjoying-peaceful-space-dedicated-to-learning-study_15963740.html&psig=AOvVaw01YwsQ20nTKpRq8ijLvpzq&ust=1734488599114000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOjCjNzfrYoDFQAAAAAdAAAAABAJ",

      },
    },
  },
  plugins: [],
};
export default config;
