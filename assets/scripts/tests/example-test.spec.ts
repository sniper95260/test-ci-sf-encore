import { describe, it, expect } from "vitest";
import { add } from "../example-test";

describe("example-test", () => {

    it("adds two numbers correctly", () => {
        expect(add(2, 3)).toBe(5);
    });

});