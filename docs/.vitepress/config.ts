import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Claude Commands Library',
  description: 'Project-aware prompt engineering for Claude Code. Commands know your project - zero repeated context questions.',

  base: '/claude-ideas/',

  themeConfig: {
    logo: '/logo.svg',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Getting Started', link: '/getting-started/' },
      { text: 'Tutorial', link: '/guide/tutorial-best-results' },
      { text: 'Commands', link: '/commands/' },
      { text: 'Architecture', link: '/architecture/' },
      { text: 'Reference', link: '/reference/' },
      { text: 'GitHub', link: 'https://github.com/Tadzesi/claude-ideas' }
    ],

    sidebar: {
      '/getting-started/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Introduction', link: '/getting-started/' },
            { text: 'Installation', link: '/getting-started/installation' },
            { text: 'Quick Start', link: '/getting-started/quick-start' },
            { text: 'Your First Prompt', link: '/getting-started/first-prompt' }
          ]
        }
      ],

      '/commands/': [
        {
          text: 'Commands',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/commands/' },
            { text: '/prompt', link: '/commands/prompt' },
            { text: '/prompt-article-readme', link: '/commands/prompt-article-readme' },
            { text: '/prompt-research', link: '/commands/prompt-research' }
          ]
        }
      ],

      '/architecture/': [
        {
          text: 'Core Concepts',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/architecture/' },
            { text: 'AI Fluency Framework', link: '/architecture/ai-fluency' },
            { text: 'Phase 0 Flow', link: '/architecture/phase-0' },
            { text: 'Library System', link: '/architecture/library-system' },
            { text: 'Skills Format (v4.3)', link: '/architecture/skills-format' }
          ]
        },
        {
          text: 'Research System',
          collapsed: false,
          items: [
            { text: 'Multi-Agent Research', link: '/architecture/multi-agent' },
            { text: 'Agent Caching', link: '/architecture/caching' }
          ]
        }
      ],

      '/guide/': [
        {
          text: 'Tutorials',
          collapsed: false,
          items: [
            { text: 'Getting Best Results', link: '/guide/tutorial-best-results' }
          ]
        },
        {
          text: 'Protocols',
          collapsed: false,
          items: [
            { text: 'Interaction Protocol (v4.8)', link: '/guide/interaction-protocol' }
          ]
        }
      ],

      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'Overview', link: '/reference/' },
            { text: 'Configuration', link: '/reference/configuration' },
            { text: 'Best Practices', link: '/reference/best-practices' },
            { text: 'Troubleshooting', link: '/reference/troubleshooting' },
            { text: 'Changelog', link: '/reference/changelog' }
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
      copyright: 'Copyright © 2024-2026 Claude Commands Library'
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
    ['meta', { property: 'og:description', content: 'Transform ideas into precise, executable prompts' }]
  ]
})
