<script setup lang="ts">
import { authClient } from "~/lib/auth-client"

definePageMeta({
  middleware: ['auth']
})

const { data: session } = await authClient.useSession(useFetch)
</script>

<template>
  <div class="container mx-auto px-4 py-8">
    <u-card>
      <template #header>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">
          Dashboard
        </h1>
      </template>

      <div class="space-y-4">
        <div>
          <h2 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">
            Protected Page
          </h2>
          <p class="text-gray-600 dark:text-gray-400">
            This page is only accessible to authenticated users. If you can see this, authentication is working correctly!
          </p>
        </div>

        <div v-if="session" class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
          <h3 class="text-sm font-semibold text-gray-900 dark:text-white mb-2">
            User Information
          </h3>
          <div class="space-y-1 text-sm">
            <p class="text-gray-600 dark:text-gray-400">
              <span class="font-medium">Name:</span> {{ session.user?.name }}
            </p>
            <p class="text-gray-600 dark:text-gray-400">
              <span class="font-medium">Email:</span> {{ session.user?.email }}
            </p>
            <p class="text-gray-600 dark:text-gray-400">
              <span class="font-medium">User ID:</span> {{ session.user?.id }}
            </p>
          </div>
        </div>
      </div>
    </u-card>
  </div>
</template>
