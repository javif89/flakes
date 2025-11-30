<script setup lang="ts">
const auth = useAuth();
</script>

<template>
  <div class="container mx-auto px-4 py-16">
    <h1 class="text-center text-xl" v-if="auth.check()">Welcome, {{ auth.user()?.name }}</h1>
    <h1 class="text-center text-xl" v-else>Signed out atm</h1>
  </div>
</template>
