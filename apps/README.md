# apps/

Folder ini di-watch oleh `application-central` (lihat `../application-central/application.yaml`,
`source.path: apps` + `directory.recurse: true`). Setiap manifest `Application`
(`kind: Application`, `apiVersion: argoproj.io/v1alpha1`) yang ditaruh di sini —
langsung di root maupun di dalam subfolder — otomatis akan dibuat/disinkronkan oleh ArgoCD.

## Menambah app baru

Buat subfolder per app, isi satu manifest `Application` yang menunjuk ke sumber
manifest sebenarnya (bisa repo/path lain, Helm chart, dst). Contoh:

```
apps/
└── nama-app/
    └── application.yaml
```

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nama-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: <url repo manifest/helm chart nama-app>
    targetRevision: main
    path: <path di dalam repo tsb>
  destination:
    server: https://kubernetes.default.svc
    namespace: <namespace tujuan>
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

Commit + push ke `main` — ArgoCD akan otomatis pickup lewat `application-central`
tanpa perlu `kubectl apply` manual lagi.
