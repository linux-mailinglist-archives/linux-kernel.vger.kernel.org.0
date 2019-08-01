Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA87DC41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfHANKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:10:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731637AbfHANKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4qLtngAUhWvMnevBCxBv/fEsOgw3HSy6g6y7VvFe9/M=; b=Q5jVLcLmFtbi
        NOQtN8ynuRsOoNuVlWGVOvJjbk65tLp4obfBX9m/IH5XZF2L7A3Iz/LtnuPc4VWQa4Iixv96gPK/a
        bD+HJaJ92pFR9zI3BcQ8c4gkrd3SKCeqwMhPRtU2B86t1j3/rUww1rOSKpaOOu60wJIdwd+J2qc3M
        jENmY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAqu-0004iq-Mg; Thu, 01 Aug 2019 13:10:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 31DD02742D42; Thu,  1 Aug 2019 14:10:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec2codec: fill some of the runtime stream parameters" to the asoc tree
In-Reply-To: <20190725165949.29699-7-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190801131040.31DD02742D42@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:40 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codec2codec: fill some of the runtime stream parameters

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 9de98628c895d15427138073986eab1e3ce39cb4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 25 Jul 2019 18:59:49 +0200
Subject: [PATCH] ASoC: codec2codec: fill some of the runtime stream parameters

Set the information provided struct snd_soc_pcm_stream in the
struct snd_pcm_runtime of the codec to codec link.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190725165949.29699-7-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1c953a1b46ce..e16838e1bda2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3874,6 +3874,11 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 		dapm_update_dai_unlocked(substream, params, sink);
 	}
 
+	runtime->format = params_format(params);
+	runtime->subformat = params_subformat(params);
+	runtime->channels = params_channels(params);
+	runtime->rate = params_rate(params);
+
 out:
 	if (ret < 0)
 		kfree(runtime);
-- 
2.20.1

