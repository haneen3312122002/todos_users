# Firestore Schema – Freelance Platform

This document describes the Firestore data model for the freelance platform.  
It is meant to be a **reference** for developers when implementing entities, datasources, use cases, and UI.

---

## Overview

Main top-level collections:

- `users`
- `jobs`
- `proposals`
- `contracts`
- `chats`

Main subcollections:

- `users/{uid}/portfolio`
- `users/{uid}/reviews`
- `users/{uid}/savedJobs`
- `users/{uid}/savedFreelancers`
- `chats/{chatId}/messages`

---

## 1. Collection: `users`

**Path**

```text
users/{uid}
FIRESTORE SCHEMA – FREELANCE PLATFORM
=====================================

COLLECTION: users
Path: users/{uid}
Fields:
- uid: string
- name: string
- email: string
- role: string                // "client" | "freelancer" | "admin"
- bio: string (optional)
- skills: array<string>
- rating: number (optional)
- avatarUrl: string (optional)
- isBlocked: bool (default: false)
- createdAt: Timestamp
- updatedAt: Timestamp (optional)


SUBCOLLECTION: users/{uid}/portfolio
Path: users/{uid}/portfolio/{projectId}
Fields:
- title: string
- description: string
- imageUrl: string (optional)
- projectLink: string (optional)
- technologies: array<string>
- createdAt: Timestamp
- updatedAt: Timestamp (optional)


SUBCOLLECTION: users/{uid}/reviews
Path: users/{uid}/reviews/{reviewId}
Fields:
- reviewerId: string
- contractId: string
- rating: number
- comment: string (optional)
- createdAt: Timestamp


SUBCOLLECTION: users/{uid}/savedJobs
Path: users/{uid}/savedJobs/{jobId}
Fields:
- jobId: string
- savedAt: Timestamp


SUBCOLLECTION: users/{uid}/savedFreelancers
Path: users/{uid}/savedFreelancers/{freelancerId}
Fields:
- freelancerId: string
- savedAt: Timestamp


COLLECTION: jobs
Path: jobs/{jobId}
Fields:
- clientId: string
- title: string
- description: string
- budget: number
- currency: string (optional)
- category: string
- requiredSkills: array<string>
- isOpen: bool
- proposalsCount: number
- deadline: Timestamp (optional)
- createdAt: Timestamp
- updatedAt: Timestamp (optional)


COLLECTION: proposals
Path: proposals/{proposalId}
Fields:
- jobId: string
- clientId: string
- freelancerId: string
- coverLetter: string
- proposedAmount: number
- estimatedDuration: string (optional)
- isAccepted: bool
- createdAt: Timestamp
- updatedAt: Timestamp (optional)


COLLECTION: contracts
Path: contracts/{contractId}
Fields:
- jobId: string
- proposalId: string
- clientId: string
- freelancerId: string
- amount: number
- currency: string (optional)
- status: string               // "pending" | "inProgress" | "completed" | "cancelled"
- notes: string (optional)
- createdAt: Timestamp
- updatedAt: Timestamp (optional)
- startDate: Timestamp (optional)
- endDate: Timestamp (optional)


COLLECTION: chats
Path: chats/{chatId}
Fields:
- members: array<string>       // [clientId, freelancerId]
- lastMessage: string (optional)
- lastMessageAt: Timestamp (optional)
- relatedContractId: string (optional)
- createdAt: Timestamp


SUBCOLLECTION: chats/{chatId}/messages
Path: chats/{chatId}/messages/{messageId}
Fields:
- senderId: string
- text: string (optional)
- attachmentUrl: string (optional)
- messageType: string          // "text" | "image" | "file"
- createdAt: Timestamp
- isRead: bool (default: false)


OPTIONAL COLLECTION: admin_stats
Path: admin_stats/global
Fields:
- totalUsers: number
- totalClients: number
- totalFreelancers: number
- totalJobs: number
- totalContracts: number
- lastUpdatedAt: Timestamp

