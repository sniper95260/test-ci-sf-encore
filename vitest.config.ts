import { defineConfig } from "vitest/config";

export default defineConfig({
    test: {
        include: ["assets/scripts/tests/**/*.spec.ts"],
        exclude: [
            "node_modules",
            "public",
            "var",
            "vendor"
        ]
    }
});