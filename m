Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83BC3BB08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfFJReo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 13:34:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfFJReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fevmjU5tOdpDdx3DPX7fS0fYUcE471UMXLZugj2U+0A=; b=Yw4WaYMJ6woV
        D0rw+GApqyBqVxQfImdx/cKdLjgFoGszwaoEXW8RvIaljHqd85xMeF0uIQ722R2FFNPyEGUIMD7a7
        a128iNv6esByzIGdu6jt65rUgh1PpuonY44OB6nJL6CZKKkBUpu76CVLfD6vRo2PZJ4kBuHMYbXwT
        APT1Q=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1haOBp-0006FS-37; Mon, 10 Jun 2019 17:34:37 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5F311440046; Mon, 10 Jun 2019 18:34:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-card: fix null pointer dereference in clean up" to the asoc tree
In-Reply-To: <20190610125344.18221-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190610173436.5F311440046@finisterre.sirena.org.uk>
Date:   Mon, 10 Jun 2019 18:34:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-card: fix null pointer dereference in clean up

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 960f428ca0a04a59e74639571126245a3efc4bcf Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 10 Jun 2019 14:53:44 +0200
Subject: [PATCH] ASoC: meson: axg-card: fix null pointer dereference in clean
 up

When using modern dai_link style, we must first make sure the
struct snd_soc_dai_link_component exists before accessing its members.

In case of early probe deferral, some of the '.cpus' or '.codecs' may not
have been allocated yet. Check this before calling of_node_put() on the
structure member.

Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index fb03258d00ae..70bb0cbad233 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -115,9 +115,11 @@ static void axg_card_clean_references(struct axg_card *priv)
 
 	if (card->dai_link) {
 		for_each_card_prelinks(card, i, link) {
-			of_node_put(link->cpus->of_node);
+			if (link->cpus)
+				of_node_put(link->cpus->of_node);
 			for_each_link_codecs(link, j, codec)
-				of_node_put(codec->of_node);
+				if (codec)
+					of_node_put(codec->of_node);
 		}
 	}
 
-- 
2.20.1

