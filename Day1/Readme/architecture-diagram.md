# Exercise 1: Snowflake Architecture Diagram

## 🎯 Objective
Draw and describe Snowflake's unique three-layer architecture, highlighting the separation of compute, storage, and cloud services.

## 📋 Instructions
1. Create a visual representation (hand-drawn or digital) of Snowflake's architecture
2. Label each layer and its components
3. Describe the function of each layer
4. Explain how the layers interact

## 🏗️ Snowflake Architecture Layers

### Layer 1: Database Storage
```
┌─────────────────────────────────────────┐
│            DATABASE STORAGE             │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │ Micro-  │ │ Micro-  │ │ Micro-  │   │
│  │partition│ │partition│ │partition│   │
│  └─────────┘ └─────────┘ └─────────┘   │
│         Compressed & Encrypted          │
└─────────────────────────────────────────┘
```

**Your Description:**
- Function: _________________________________
- Key Features: _____________________________
- Benefits: _________________________________

### Layer 2: Query Processing (Compute)
```
┌─────────────────────────────────────────┐
│          VIRTUAL WAREHOUSES             │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │   VW1   │ │   VW2   │ │   VW3   │   │
│  │ (Small) │ │(Medium) │ │(Large)  │   │
│  └─────────┘ └─────────┘ └─────────┘   │
│     Independent Compute Clusters        │
└─────────────────────────────────────────┘
```

**Your Description:**
- Function: _________________________________
- Scaling: __________________________________
- Isolation: ________________________________

### Layer 3: Cloud Services
```
┌─────────────────────────────────────────┐
│            CLOUD SERVICES               │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐    │
│ │  Auth   │ │Metadata │ │ Query   │    │
│ │Security │ │ Mgmt    │ │Optimizer│    │
│ └─────────┘ └─────────┘ └─────────┘    │
└─────────────────────────────────────────┘
```

**Your Description:**
- Function: _________________________________
- Components: _______________________________
- Always-on: ________________________________

## 🔄 Architecture Interaction

**Describe how the layers work together:**

1. **Query Submission:**
   - _____________________________________________

2. **Query Processing:**
   - _____________________________________________

3. **Data Access:**
   - _____________________________________________

4. **Result Return:**
   - _____________________________________________

## ✅ Key Benefits of This Architecture

- [ ] **Separation of Compute and Storage:** ________________
- [ ] **Independent Scaling:** ___________________________
- [ ] **Multi-tenancy:** ________________________________
- [ ] **Elasticity:** ___________________________________
- [ ] **Performance:** ___________________________________

## 🎨 Your Architecture Diagram

**Attach or describe your visual diagram here:**

[Space for your diagram - can be hand-drawn photo, digital diagram, or detailed text description]

---

## 📝 Reflection Questions

1. How does Snowflake's architecture differ from traditional databases?
   - _________________________________________________

2. What advantages does the separation of compute and storage provide?
   - _________________________________________________

3. Why is the cloud services layer always available?
   - _________________________________________________

**Completion Date:** _______________
**Time Spent:** _______________ 