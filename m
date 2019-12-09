Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFD116E33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 14:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLINyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 08:54:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47258 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfLINyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:54:00 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C4F51A0789;
        Mon,  9 Dec 2019 14:53:59 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 101611A0781;
        Mon,  9 Dec 2019 14:53:59 +0100 (CET)
Received: from fsr-ub1864-103.ro-buh02.nxp.com (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B375C20564;
        Mon,  9 Dec 2019 14:53:58 +0100 (CET)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: simple-card: Don't create separate link when platform is present
Date:   Mon,  9 Dec 2019 15:53:53 +0200
Message-Id: <20191209135353.17427-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal sound case all DAIs are detected as CPU-Codec.
simple_dai_link_of supports the presence of a platform but it counts
it as a CPU DAI resulting in the creation of an extra link.

Adding a platform property to a link description like:

simple-audio-card,dai-link {
	cpu {
		sound-dai = <&sai1>;
	};
	plat {
		sound-dai = <&dsp>;
	};
	codec {
		sound-dai = <&wm8960>;
	}

will result in the creation of two links:
	* sai1 <-> wm8960
	* dsp  <-> wm8960

which is obviously not what we want. We just want one single link
with:
	* sai1 <-> wm8960 (and platform set to dsp).

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/generic/simple-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 10b82bf043d1..55e9f8800b3e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -371,6 +371,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 	do {
 		struct asoc_simple_data adata;
 		struct device_node *codec;
+		struct device_node *plat;
 		struct device_node *np;
 		int num = of_get_child_count(node);
 
@@ -381,6 +382,9 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 			ret = -ENODEV;
 			goto error;
 		}
+		/* get platform */
+		plat = of_get_child_by_name(node, is_top ?
+					    PREFIX "plat" : "plat");
 
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
@@ -389,6 +393,8 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 		/* loop for all CPU/Codec node */
 		for_each_child_of_node(node, np) {
+			if (plat == np)
+				continue;
 			/*
 			 * It is DPCM
 			 * if it has many CPUs,
-- 
2.17.1

