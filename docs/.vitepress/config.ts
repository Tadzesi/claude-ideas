import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Claude Commands Library',
  description: 'Transform vague ideas into precise, executable prompts with intelligent agent assistance',

  base: '/claude-ideas/',

  themeConfig: {
    logo: '/logo.svg',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Getting Started', link: '/getting-started/' },
      { text: 'Guide', link: '/guide/commands/' },
      { text: 'Reference', link: '/reference/configuration' },
      { text: 'GitHub', link: 'https://github.com/Tadzesi/claude-ideas' }
    ],

    sidebar: {
      '/getting-started/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Overview', link: '/getting-started/' },
            { text: 'Installation', link: '/getting-started/installation' },
            { text: 'Quick Start', link: '/getting-started/quick-start' }
          ]
        }
      ],

      '/guide/': [
        {
          text: 'Commands',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/guide/commands/' },
            { text: '/prompt', link: '/guide/commands/prompt' },
            { text: '/prompt-hybrid', link: '/guide/commands/prompt-hybrid' },
            { text: '/prompt-technical', link: '/guide/commands/prompt-technical' },
            { text: '/prompt-article', link: '/guide/commands/prompt-article' },
            { text: 'Session Management', link: '/guide/commands/session-management' }
          ]
        },
        {
          text: 'Architecture',
          collapsed: false,
          items: [
            { text: 'Library System', link: '/guide/architecture/library-system' },
            { text: 'Hybrid Architecture', link: '/guide/architecture/hybrid-architecture' }
          ]
        },
        {
          text: 'Advanced Features',
          collapsed: false,
          items: [
            { text: 'Agent Caching', link: '/guide/advanced-features/caching' },
            { text: 'Multi-Agent Verification', link: '/guide/advanced-features/multi-agent' },
            { text: 'Learning System', link: '/guide/advanced-features/learning-system' }
          ]
        }
      ],

      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'Configuration', link: '/reference/configuration' },
            { text: 'Best Practices', link: '/reference/best-practices' }
          ]
        }
      ],

      '/migration/': [
        {
          text: 'Migration',
          items: [
            { text: 'v2.0 Migration', link: '/migration/v2-migration' },
            { text: 'Custom Commands', link: '/migration/custom-commands' }
          ]
        }
      ],

      '/testing/': [
        {
          text: 'Testing',
          items: [
            { text: 'Advanced Features', link: '/testing/advanced-features' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Tadzesi/claude-ideas' }
    ],

    search: {
      provider: 'local'
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2024-2025 Claude Commands Library'
    },

    editLink: {
      pattern: 'https://github.com/Tadzesi/claude-ideas/edit/main/docs/:path',
      text: 'Edit this page on GitHub'
    },

    lastUpdated: {
      text: 'Last updated',
      formatOptions: {
        dateStyle: 'medium',
        timeStyle: 'short'
      }
    }
  },

  markdown: {
    lineNumbers: true,
    theme: {
      light: 'github-light',
      dark: 'github-dark'
    }
  },

  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }],
    ['link', { rel: 'alternate icon', href: '/favicon.svg' }],
    ['meta', { name: 'theme-color', content: '#5f67ee' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:locale', content: 'en' }],
    ['meta', { property: 'og:title', content: 'Claude Commands Library' }],
    ['meta', { property: 'og:site_name', content: 'Claude Commands Library' }],
    ['meta', { property: 'og:image', content: 'https://tadzesi.github.io/claude-ideas/logo.svg' }],
    ['meta', { property: 'og:description', content: 'Transform vague ideas into precise, executable prompts' }]
  ]
})
