Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB86FA46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGVHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 03:24:09 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:52968 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGVHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:24:09 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpSfy-0002G4-5N from Jiada_Wang@mentor.com ; Mon, 22 Jul 2019 00:24:02 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Jul 2019 00:23:58 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <twischer@de.adit-jv.com>, <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] Allow reconfiguration of clock rate
Date:   Mon, 22 Jul 2019 16:24:00 +0900
Message-ID: <20190722072403.11008-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is use case in Gstreamer ALSA sink, in case of changed caps
Gsreatmer reconfigs and it calls snd_pcm_hw_free() before snd_pcm_prepre().
See gstreamer1.0-plugins-base/
gst-libs/gst/audio/gstaudiobasesink.c: gst_audio_base_sink_setcaps():
- gst_audio_ring_buffer_release()
- gst_audio_sink_ring_buffer_release()
- gst_alsasink_unprepare()
- snd_pcm_hw_free()
is called before
- gst_audio_ring_buffer_acquire()
- gst_audio_sink_ring_buffer_acquire()
- gst_alsasink_prepare()
- set_hwparams()
- snd_pcm_hw_params()
- snd_pcm_prepare()

But with current implementation after clock rate is started in .prepare
reconfiguration of clock rate is not allowed, unless the stream is stopped.

This patch set by move stop of clock to .hw_free callback,
to allow reconfiguration of clock rate.

Jiada Wang (1):
  ASoC: rsnd: call .hw_{params,free} in pair for same stream

Timo Wischer (2):
  ASoC: rsnd: Support hw_free() callback at DAI level
  ASoC: rsnd: Allow reconfiguration of clock rate

 sound/soc/sh/rcar/core.c | 22 +++++++++++++--
 sound/soc/sh/rcar/rsnd.h | 36 ++++++++++++++++++++----
 sound/soc/sh/rcar/ssi.c  | 61 +++++++++++++++++++++++++++++-----------
 sound/soc/sh/rcar/ssiu.c |  3 +-
 4 files changed, 96 insertions(+), 26 deletions(-)

-- 
2.19.2

