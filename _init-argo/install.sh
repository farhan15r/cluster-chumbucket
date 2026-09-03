#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KUBE_CONTEXT="cluster01.chumbucket"
NAMESPACE="argocd"
RELEASE_NAME="argocd"
CHART_REPO="https://argoproj.github.io/argo-helm"
CHART_NAME="argo-cd"
CHART_VERSION="10.7.0"

helm install "$RELEASE_NAME" "$CHART_NAME" \
  --repo "$CHART_REPO" \
  --version "$CHART_VERSION" \
  --kube-context "$KUBE_CONTEXT" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  -f "$SCRIPT_DIR/values.yaml"
