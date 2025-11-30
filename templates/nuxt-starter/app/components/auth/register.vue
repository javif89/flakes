<template>
    <UAuthForm
    :schema="schema"
    title="Register"
    description="Sign up for an account!"
    icon="i-lucide-user-plus"
    :fields="fields"
    :loading="loading"
    @submit="onRegisterSubmit"
    />
</template>

<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent, AuthFormField } from '@nuxt/ui'
import { authClient } from '~/lib/auth-client'

const toast = useToast();
const router = useRouter();
const session = authClient.useSession();

const loading = ref(false)

const fields: AuthFormField[] = [
  {
    name: 'name',
    type: 'text',
    label: 'Name',
    placeholder: 'Enter your name',
    required: false
  },
  {
    name: 'email',
    type: 'email',
    label: 'Email',
    placeholder: 'Enter your email',
    required: true
  },
  {
    name: 'password',
    label: 'Password',
    type: 'password',
    placeholder: 'Enter your password',
    required: true
  }
]

const schema = z.object({
  name: z.string(),
  email: z.string('Invalid email'),
  password: z.string().min(8, 'Must be at least 8 characters')
})

type RegisterSchema = z.output<typeof schema>

async function onRegisterSubmit(payload: FormSubmitEvent<RegisterSchema>) {
  loading.value = true

  const {data, error} = await authClient.signUp.email({
    email: payload.data.email,
    password: payload.data.password,
    name: payload.data.name
  }, {
    onRequest: (ctx) => {
        loading.value = true
    },
    onSuccess: (ctx) => {
        toast.add({
            title: 'Success',
            description: 'Your account has been created!',
            color: 'success',
            duration: 3000
        });
    },
    onError: (ctx) => {
        toast.add({
            title: 'Error',
            description: ctx.error.message || 'Failed to register',
            color: 'error',
            duration: 5000
        });
    }
  });
}
</script>
