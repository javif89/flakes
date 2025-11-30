import { auth } from "../auth"

export default defineEventHandler(async (req) => {
    console.log("Running auth middleware")
    const session = await auth.api.getSession({
        headers: req.headers
    });

    req.context.authSession = session;
    req.context.user = session?.user;
})