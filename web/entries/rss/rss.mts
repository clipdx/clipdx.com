import { load } from "js-toml";
import { readFile } from "node:fs/promises";
import { join } from "node:path";

const resourceToml = String(
  await readFile(join(import.meta.dirname, "./resources.toml")),
);
const { resources, wishlist } = load(resourceToml) as any;
export { resources, wishlist };
