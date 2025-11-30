<template>
    <u-header title="App Starter">
        <template #default>
            <u-navigation-menu v-if="useAuth().check()" :items="items" />
        </template>


        <template #right>
            <u-color-mode-button />
            <template v-if="useAuth().guest()">
                <u-slideover>
                    <u-button label="Log in" color="neutral" variant="subtle" />
                    <template #content>
                        <div class="p-8">
                            <auth-login />
                        </div>
                    </template>
                </u-slideover>
                <u-slideover>
                    <u-button label="Register" color="primary" variant="subtle" />
                    <template #content>
                        <div class="p-8">
                            <auth-register />
                        </div>
                    </template>
                </u-slideover>
            </template>
            <template v-else>
                <auth-user-menu />
            </template>
        </template>
    </u-header>
    <u-main>
        <slot />
    </u-main>
</template>

<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui';

const items: NavigationMenuItem[] = [
    {
        label: 'Dashboard',
        to: '/dashboard'
    }
];
</script>