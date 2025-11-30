<template>
    <div class="max-w-xl mx-auto py-32">
        <auth-login />
    </div>
</template>
<script setup lang="ts">
definePageMeta({
    middleware: ['guest']
})
</script>