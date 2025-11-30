import { auth } from "~~/server/auth"

export default defineEventHandler((ev) => {
    return auth.handler(toWebRequest(ev));
});
