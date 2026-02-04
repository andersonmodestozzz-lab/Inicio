#!/usr/bin/env bash
set -euo pipefail

# Agenda o desligamento do PC para as 23:00 (horário local).
# Se já passou das 23:00, agenda para o próximo dia.

agora_epoch=$(date +%s)

alvo_hoje_epoch=$(date -d "today 23:00" +%s)
if [ "$agora_epoch" -ge "$alvo_hoje_epoch" ]; then
  alvo_epoch=$(date -d "tomorrow 23:00" +%s)
else
  alvo_epoch=$alvo_hoje_epoch
fi

delta=$((alvo_epoch - agora_epoch))

printf 'Desligamento agendado para %s (em %s segundos).\n' "$(date -d "@${alvo_epoch}")" "$delta"

sleep "$delta"

# Pode ser necessário executar com sudo.
shutdown -h now
