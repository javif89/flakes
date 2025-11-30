import type { EventHandler, EventHandlerRequest } from 'h3'

export const withAuth = <T extends EventHandlerRequest, D>(
    handler: EventHandler<T, D>,
): EventHandler<T, D> =>
    defineEventHandler<T>(async (req) => {
        try {
            if (req.context.user == null) {
                throw createError({
                    statusCode: 403,
                    statusMessage: "Forbidden: Unauthenticated"
                })
            }

            const response = await handler(req)
            return { response }
        } catch (err) {
            // Error handling
            return { err }
        }
    })
