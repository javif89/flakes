<template>
    <UAuthForm
    :schema="schema"
    title="Login"
    :fields="fields"
    :loading="loading"
    @submit="onSubmit"
    />
</template>

<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent, AuthFormField } from '@nuxt/ui'
import { authClient } from '~/lib/auth-client'

const toast = useToast();
const loading = ref(false)

const fields: AuthFormField[] = [
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
  email: z.string('Invalid email'),
  password: z.string().min(8, 'Must be at least 8 characters')
})

type Schema = z.output<typeof schema>

async function onSubmit(payload: FormSubmitEvent<Schema>) {
  loading.value = true

  const {data, error} = await authClient.signIn.email({
    email: payload.data.email,
    password: payload.data.password,
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
            description: ctx.error.message || 'Failed to sign in',
            color: 'error',
            duration: 5000
        });
    }
  });
  loading.value = false
}
</script>
