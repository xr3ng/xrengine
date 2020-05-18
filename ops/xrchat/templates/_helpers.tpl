{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
# {{- define "xrengine.name" -}}
# {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
# {{- end -}}

{{- define "xrengine.client.name" -}}
{{- default .Chart.Name .Values.client.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrengine.server.name" -}}
{{- default .Chart.Name .Values.server.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrengine.spoke.name" -}}
{{- default .Chart.Name .Values.spoke.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrengine.gsg.name" -}}
{{- default .Chart.Name .Values.gsg.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrengine.gs.name" -}}
{{- default .Chart.Name .Values.gs.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "xrengine.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{- define "xrengine.client.fullname" -}}
{{- if .Values.client.fullnameOverride -}}
{{- .Values.client.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.client.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "xrengine.server.fullname" -}}
{{- if .Values.server.fullnameOverride -}}
{{- .Values.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "xrengine.spoke.fullname" -}}
{{- if .Values.spoke.fullnameOverride -}}
{{- .Values.spoke.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.spoke.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "xrengine.gs.fullname" -}}
{{- if .Values.gs.fullnameOverride -}}
{{- .Values.gs.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.gs.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "xrengine.gsg.fullname" -}}
{{- if .Values.gsg.fullnameOverride -}}
{{- .Values.gsg.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.gsg.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "xrengine.client.host" -}}
{{- printf "%s.%s.%s" "dashboard" .Release.Name .Values.domain -}}
{{- end -}}


{{- define "xrengine.server.host" -}}
{{- printf "%s.%s.%s" "api" .Release.Name .Values.domain -}}
{{- end -}}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "xrengine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "xrengine.client.labels" -}}
helm.sh/chart: {{ include "xrengine.chart" . }}
{{ include "xrengine.client.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrengine.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrengine.client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: client
{{- end -}}


{{/*
Common labels
*/}}
{{- define "xrengine.server.labels" -}}
helm.sh/chart: {{ include "xrengine.chart" . }}
{{ include "xrengine.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrengine.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrengine.server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: server
{{- end -}}



{{/*
Common labels
*/}}
{{- define "xrengine.spoke.labels" -}}
helm.sh/chart: {{ include "xrengine.chart" . }}
{{ include "xrengine.spoke.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrengine.spoke.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrengine.spoke.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: spoke
{{- end -}}


{{/*
Common labels
*/}}
{{- define "xrengine.gs.labels" -}}
helm.sh/chart: {{ include "xrengine.chart" . }}
{{ include "xrengine.gs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrengine.gs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrengine.gs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: gs
{{- end -}}


{{/*
Common labels
*/}}
{{- define "xrengine.gsg.labels" -}}
helm.sh/chart: {{ include "xrengine.chart" . }}
{{ include "xrengine.gsg.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrengine.gsg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrengine.gsg.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: gsg
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "xrengine.client.serviceAccountName" -}}
{{- if .Values.client.serviceAccount.create -}}
    {{ default (include "xrengine.client.fullname" .) .Values.client.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.client.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "xrengine.server.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create -}}
    {{ default (include "xrengine.server.fullname" .) .Values.server.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.server.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "xrengine.spoke.serviceAccountName" -}}
{{- if .Values.spoke.serviceAccount.create -}}
    {{ default (include "xrengine.spoke.fullname" .) .Values.spoke.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.spoke.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "xrengine.gs.serviceAccountName" -}}
{{- if .Values.gs.serviceAccount.create -}}
    {{ default (include "xrengine.gs.fullname" .) .Values.gs.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.gs.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "xrengine.gsg.serviceAccountName" -}}
{{- if .Values.gs.serviceAccount.create -}}
    {{ default (include "xrengine.gsg.fullname" .) .Values.gsg.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.gsg.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "xrengine.mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
Set maria host
*/}}
{{- define "xrengine.mariadb.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- template "xrengine.mariadb.fullname" . -}}
{{- else -}}
{{- .Values.mariadb.externalHost | quote -}}
{{- end -}}
{{- end -}}
