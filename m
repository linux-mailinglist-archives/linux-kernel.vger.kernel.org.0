Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9D112E17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLDPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:14:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36900 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:14:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 287A42011F5;
        Wed,  4 Dec 2019 16:14:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C4F62011ED;
        Wed,  4 Dec 2019 16:14:09 +0100 (CET)
Received: from fsr-ub1864-103.ro-buh02.nxp.com (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 89D92205C5;
        Wed,  4 Dec 2019 16:14:08 +0100 (CET)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: soc-core: Set dpcm_playback / dpcm_capture
Date:   Wed,  4 Dec 2019 17:13:33 +0200
Message-Id: <20191204151333.26625-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting a normal link to a DPCM link we need
to set dpcm_playback / dpcm_capture otherwise playback/capture
streams will not be created resulting in errors like this:

[   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream

Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine driver FE DAI link config")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 977a7bfad519..f89cf9d0860c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1872,6 +1872,8 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
+			dai_link->dpcm_playback = 1;
+			dai_link->dpcm_capture = 1;
 
 			/* override any BE fixups */
 			dai_link->be_hw_params_fixup =
-- 
2.17.1

