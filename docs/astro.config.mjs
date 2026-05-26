import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://dots-hyprland.vercel.app',
  integrations: [
    starlight({
      title: 'dots-hyprland',
      description: 'Documentation for omsenjalia/dots-hyprland — a fork of end-4/dots-hyprland (illogical-impulse)',
      favicon: '/favicon.svg',
      logo: {
        src: './src/assets/logo.svg',
        replacesTitle: false,
      },
      social: [
        { icon: 'github', label: 'GitHub', href: 'https://github.com/omsenjalia/dots-hyprland' },
      ],
      editLink: {
        baseUrl: 'https://github.com/omsenjalia/dots-hyprland/edit/main/docs/',
      },
      customCss: ['./src/styles/custom.css'],
      sidebar: [
        {
          label: 'User Guide',
          autogenerate: { directory: 'guide' },
        },
        {
          label: 'Custom Additions',
          autogenerate: { directory: 'custom' },
        },
        {
          label: 'AI Agent Guide',
          items: [
            { label: 'Overview', link: '/ai-agents/00-overview/' },
            { label: 'Architecture', link: '/ai-agents/01-architecture/' },
            { label: 'Workflow', link: '/ai-agents/02-workflow/' },
            { label: 'Updating Docs', link: '/ai-agents/03-update-docs/' },
            {
              label: 'Changelog',
              autogenerate: { directory: 'ai-agents/changelog' },
              collapsed: true,
            },
            {
              label: 'Weekly Summaries',
              autogenerate: { directory: 'ai-agents/weekly-summaries' },
              collapsed: true,
            },
          ],
        },
      ],
      defaultLocale: 'root',
      locales: { root: { label: 'English', lang: 'en' } },
      lastUpdated: true,
    }),
  ],
});
