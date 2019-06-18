Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E242D4A9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfFRSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:34:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbfFRSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9jVltIl21FZuPZEOLXycKl4a9yd+tYMkYLMqll/9ksI=; b=EOXCX6BxMA7B
        apNQnpN1fb+5MCytdunf+6VnzPPbNyBkbBEYu6PMeh96kfipAQBlRn2y7xYMIhUbcw79haquTvqcH
        5SF9dIdWw+N3+yV1Ls0K8o4JMv5Kl4MXyHvNHSkmqpNRVcmlW1Ws77ovVqQ1Vbx84joOeQLaWCvBx
        /Fns4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdIus-0005K8-SE; Tue, 18 Jun 2019 18:33:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 19CE7440046; Tue, 18 Jun 2019 19:33:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Jiada Wang <jiada_wang@mentor.com>, jiada_wang@mentor.com,
        kuninori.morimoto.gx@renesas.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        sudipi@jp.adit-jv.com, Suresh Udipi <sudipi@jp.adit-jv.com>,
        tiwai@suse.com
Subject: Applied "ASoC: rsnd: fixup mod ID calculation in rsnd_ctu_probe_" to the asoc tree
In-Reply-To: <20190618051953.13419-1-jiada_wang@mentor.com>
X-Patchwork-Hint: ignore
Message-Id: <20190618183310.19CE7440046@finisterre.sirena.org.uk>
Date:   Tue, 18 Jun 2019 19:33:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: fixup mod ID calculation in rsnd_ctu_probe_

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

From ac28ec07ae1c5c1e18ed6855eb105a328418da88 Mon Sep 17 00:00:00 2001
From: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Date: Tue, 18 Jun 2019 14:19:53 +0900
Subject: [PATCH] ASoC: rsnd: fixup mod ID calculation in rsnd_ctu_probe_

commit c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")
introduces rsnd_ctu_id which calcualates and gives
the main Device id of the CTU by dividing the id by 4.
rsnd_mod_id uses this interface to get the CTU main
Device id. But this commit forgets to revert the main
Device id calcution previously done in rsnd_ctu_probe_
which also divides the id by 4. This path corrects the
same to get the correct main Device id.

The issue is observered when rsnd_ctu_probe_ is done for CTU1

Fixes: c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")

Signed-off-by: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 8cb06dab234e..7647b3d4c0ba 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -108,7 +108,7 @@ static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
 {
-	return rsnd_cmd_attach(io, rsnd_mod_id(mod) / 4);
+	return rsnd_cmd_attach(io, rsnd_mod_id(mod));
 }
 
 static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,
-- 
2.20.1

