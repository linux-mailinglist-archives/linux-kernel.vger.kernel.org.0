Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981FFE6EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbfJ1JNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:13:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54496 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387596AbfJ1JNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:13:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50C351A0706;
        Mon, 28 Oct 2019 10:13:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 021761A0715;
        Mon, 28 Oct 2019 10:13:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7DCF2402E2;
        Mon, 28 Oct 2019 17:13:40 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] ASoC: fsl_asrc: refine the setting of internal clock divider
Date:   Mon, 28 Oct 2019 17:10:29 +0800
Message-Id: <23c634e4bf58afce5b3ae67f5f42e8d1cae2639a.1572252307.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output divider should align with the output sample
rate, if use ideal sample rate, there will be a lot of overload,
which would cause underrun.

The maximum divider of asrc clock is 1024, but there is no
judgement for this limitation in driver, which may cause the divider
setting not correct.

For non-ideal ratio mode, the clock rate should divide the sample
rate with no remainder, and the quotient should be less than 1024.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Change in v3
- refine comments

Change in v2
- remove p2p/m2m word
- use use_ideal_rate

 sound/soc/fsl/fsl_asrc.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0bf91a6f54b9..a3cfceea7d2f 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -259,8 +259,15 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
  * It configures those ASRC registers according to a configuration instance
  * of struct asrc_config which includes in/output sample rate, width, channel
  * and clock settings.
+ *
+ * Note:
+ * The ideal ratio configuration can work with a flexible clock rate setting.
+ * Using IDEAL_RATIO_RATE gives a faster converting speed but overloads ASRC.
+ * For a regular audio playback, the clock rate should not be slower than an
+ * clock rate aligning with the output sample rate; For a use case requiring
+ * faster conversion, set use_ideal_rate to have the faster speed.
  */
-static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
+static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 {
 	struct asrc_config *config = pair->config;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
@@ -268,7 +275,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	enum asrc_word_width input_word_width;
 	enum asrc_word_width output_word_width;
 	u32 inrate, outrate, indiv, outdiv;
-	u32 clk_index[2], div[2];
+	u32 clk_index[2], div[2], rem[2];
+	u64 clk_rate;
 	int in, out, channels;
 	int pre_proc, post_proc;
 	struct clk *clk;
@@ -351,27 +359,42 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	/* We only have output clock for ideal ratio mode */
 	clk = asrc_priv->asrck_clk[clk_index[ideal ? OUT : IN]];
 
-	div[IN] = clk_get_rate(clk) / inrate;
-	if (div[IN] == 0) {
+	clk_rate = clk_get_rate(clk);
+	rem[IN] = do_div(clk_rate, inrate);
+	div[IN] = (u32)clk_rate;
+
+	/*
+	 * The divider range is [1, 1024], defined by the hardware. For non-
+	 * ideal ratio configuration, clock rate has to be strictly aligned
+	 * with the sample rate. For ideal ratio configuration, clock rates
+	 * only result in different converting speeds. So remainder does not
+	 * matter, as long as we keep the divider within its valid range.
+	 */
+	if (div[IN] == 0 || (!ideal && (div[IN] > 1024 || rem[IN] != 0))) {
 		pair_err("failed to support input sample rate %dHz by asrck_%x\n",
 				inrate, clk_index[ideal ? OUT : IN]);
 		return -EINVAL;
 	}
 
+	div[IN] = min_t(u32, 1024, div[IN]);
+
 	clk = asrc_priv->asrck_clk[clk_index[OUT]];
-
-	/* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
-	if (ideal)
-		div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
+	clk_rate = clk_get_rate(clk);
+	if (ideal && use_ideal_rate)
+		rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
 	else
-		div[OUT] = clk_get_rate(clk) / outrate;
+		rem[OUT] = do_div(clk_rate, outrate);
+	div[OUT] = clk_rate;
 
-	if (div[OUT] == 0) {
+	/* Output divider has the same limitation as the input one */
+	if (div[OUT] == 0 || (!ideal && (div[OUT] > 1024 || rem[OUT] != 0))) {
 		pair_err("failed to support output sample rate %dHz by asrck_%x\n",
 				outrate, clk_index[OUT]);
 		return -EINVAL;
 	}
 
+	div[OUT] = min_t(u32, 1024, div[OUT]);
+
 	/* Set the channel number */
 	channels = config->channel_num;
 
@@ -560,7 +583,7 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 		config.output_sample_rate = rate;
 	}
 
-	ret = fsl_asrc_config_pair(pair);
+	ret = fsl_asrc_config_pair(pair, false);
 	if (ret) {
 		dev_err(dai->dev, "fail to config asrc pair\n");
 		return ret;
-- 
2.21.0

