<script setup lang="ts">
import type { DropdownMenuItem } from '@nuxt/ui';
const items = ref<DropdownMenuItem[]>([
    [
        {
            label: 'Profile',
            icon: 'i-lucide-user',
        },
        {
            label: 'Settings',
            icon: 'i-lucide-cog',
        },
    ],
    [
        {
            label: 'Logout',
            icon: 'i-lucide-log-out',
            onSelect() {
                console.log("yohoooo");
                useAuth().signOut();
                useToast().add({
                    title: 'Success',
                    description: 'You have been signed out',
                    color: 'info'
                });
            }
        }
    ]
])
</script>

<template>
    <u-dropdown-menu :items="items">
        <u-button icon="i-lucide-user" color="neutral" variant="outline" :label="useAuth().user()?.name"></u-button>
    </u-dropdown-menu>
</template>
