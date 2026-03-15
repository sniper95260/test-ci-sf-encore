import js from "@eslint/js";
import tseslint from "typescript-eslint";

export default [
    js.configs.recommended,
    ...tseslint.configs.recommended,
    {
        files: ["assets/**/*.{js,ts}"],
        rules: {
            "no-unused-vars": "off",
            "@typescript-eslint/no-unused-vars": "error",
        },
    },
    {
        ignores: [
            "node_modules/**",
            "public/build/**",
            "var/**",
            "vendor/**",
        ],
    },
];