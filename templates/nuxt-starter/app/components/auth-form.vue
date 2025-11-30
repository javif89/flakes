<template>
  <UTabs :items="tabs" v-model="activeTab">
    <template #login>
      <UAuthForm
        :schema="loginSchema"
        title="Login"
        description="Enter your credentials to access your account."
        icon="i-lucide-user"
        :fields="loginFields"
        :loading="loading"
        @submit="onLoginSubmit"
      />
    </template>
    <template #register>
      <UAuthForm
        :schema="registerSchema"
        title="Register"
        description="Sign up for an account!"
        icon="i-lucide-user-plus"
        :fields="registerFields"
        :loading="loading"
        @submit="onRegisterSubmit"
      />
    </template>
  </UTabs>
</template>

<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent, AuthFormField } from '@nuxt/ui'

const toast = useToast()
const router = useRouter()
// const { login, register } = useAuth()

const loading = ref(false)
const activeTab = ref(0)

const tabs = [
  {
    label: 'Login',
    slot: 'login',
  },
  {
    label: 'Register',
    slot: 'register',
  }
]

const loginFields: AuthFormField[] = [
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
  },
  {
    name: 'remember',
    label: 'Remember me',
    type: 'checkbox'
  }
]

const registerFields: AuthFormField[] = [
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

// Separate schemas for login and register
const loginSchema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Must be at least 8 characters'),
  remember: z.boolean().optional()
})

const registerSchema = z.object({
  name: z.string().optional(),
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Must be at least 8 characters')
})

type LoginSchema = z.output<typeof loginSchema>
type RegisterSchema = z.output<typeof registerSchema>

async function onLoginSubmit(payload: FormSubmitEvent<LoginSchema>) {
  loading.value = true

  try {
    await login(payload.data.email, payload.data.password)

    toast.add({
      title: 'Success',
      description: 'You have been logged in!',
      color: 'green',
      duration: 3000
    })

    closeAuthModal()
    router.push('/')
  } catch (error: any) {
    toast.add({
      title: 'Error',
      description: error.message || 'Failed to login',
      color: 'red',
      duration: 5000
    })
  } finally {
    loading.value = false
  }
}

async function onRegisterSubmit(payload: FormSubmitEvent<RegisterSchema>) {
  loading.value = true

  try {
    await register(payload.data.email, payload.data.password, payload.data.name)

    toast.add({
      title: 'Success',
      description: 'Your account has been created!',
      color: 'green',
      duration: 3000
    })

    closeAuthModal()
    router.push('/')
  } catch (error: any) {
    toast.add({
      title: 'Error',
      description: error.message || 'Failed to register',
      color: 'red',
      duration: 5000
    })
  } finally {
    loading.value = false
  }
}
</script>
