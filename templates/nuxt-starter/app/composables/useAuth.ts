import { authClient } from "~/lib/auth-client"

interface User {
  readonly id: string;
  readonly createdAt: Date;
  readonly updatedAt: Date;
  readonly email: string;
  readonly emailVerified: boolean;
  readonly name: string;
  readonly image?: string | null | undefined;
}

export const useAuth = () => {
  const session = authClient.useSession();

  const check = (): boolean => session.value.data !== null;
  const guest = (): boolean => !check();
  const user = (): User | null => session.value.data?.user ?? null;
  const signOut = () => authClient.signOut();

  return {
    check,
    guest,
    user,
    signOut
  }
}
