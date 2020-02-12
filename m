Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1324B159EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBLBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:53:00 -0500
Received: from mail.serbinski.com ([162.218.126.2]:50420 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBLBw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:52:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 112FBD006FC;
        Wed, 12 Feb 2020 01:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Njpaccfg81vZ; Tue, 11 Feb 2020 20:52:47 -0500 (EST)
Received: from anet (23-233-80-73.cpe.pppoe.ca [23.233.80.73])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.serbinski.com (Postfix) with ESMTPSA id 89284D00700;
        Tue, 11 Feb 2020 20:52:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 89284D00700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581472355;
        bh=zpX7VwNVHYJZseNqv9ndVo3xelvBQGCv0zntmNzh0+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxFMUps/Yr/m0AUxJGNvGTx0MhCa00t5EL9mKvx6UbayG9AmjNUErLMNjMs1mR3DZ
         nsfcSSNHu5rwlOXNzCM5jdNK6msSWheBfsSTM2/DIdw2nR4Ut0taZNG1GywY+w1psz
         zrnveFXJKVomZl4FXoGRlk769wZR0guOWZQMbvoU=
From:   Adam Serbinski <adam@serbinski.com>
To:     Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Adam Serbinski <adam@serbinski.com>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] ASoC: qdsp6: q6routing: add pcm port routing
Date:   Tue, 11 Feb 2020 20:52:20 -0500
Message-Id: <20200212015222.8229-5-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212015222.8229-1-adam@serbinski.com>
References: <20200212015222.8229-1-adam@serbinski.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to PCM_PORT mixers required to
select path between ASM stream and AFE ports.

Signed-off-by: Adam Serbinski <adam@serbinski.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: Andy Gross <agross@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Patrick Lai <plai@codeaurora.org>
CC: Banajit Goswami <bgoswami@codeaurora.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-msm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 sound/soc/qcom/qdsp6/q6routing.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 20724102e85a..3a81d2161707 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -67,6 +67,10 @@
 	{ mix_name, "SEC_MI2S_TX", "SEC_MI2S_TX" },	\
 	{ mix_name, "QUAT_MI2S_TX", "QUAT_MI2S_TX" },	\
 	{ mix_name, "TERT_MI2S_TX", "TERT_MI2S_TX" },		\
+	{ mix_name, "PRI_PCM_TX", "PRI_PCM_TX" },		\
+	{ mix_name, "SEC_PCM_TX", "SEC_PCM_TX" },		\
+	{ mix_name, "TERT_PCM_TX", "TERT_PCM_TX" },		\
+	{ mix_name, "QUAT_PCM_TX", "QUAT_PCM_TX" },		\
 	{ mix_name, "SLIMBUS_0_TX", "SLIMBUS_0_TX" },		\
 	{ mix_name, "SLIMBUS_1_TX", "SLIMBUS_1_TX" },		\
 	{ mix_name, "SLIMBUS_2_TX", "SLIMBUS_2_TX" },		\
@@ -128,6 +132,18 @@
 	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("PRI_PCM_TX", PRIMARY_PCM_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SEC_PCM_TX", SECONDARY_PCM_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TERT_PCM_TX", TERTIARY_PCM_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("QUAT_PCM_TX", QUATERNARY_PCM_TX,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
 	SOC_SINGLE_EXT("SLIMBUS_0_TX", SLIMBUS_0_TX,			\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
@@ -468,6 +484,18 @@ static const struct snd_kcontrol_new quaternary_mi2s_rx_mixer_controls[] = {
 static const struct snd_kcontrol_new tertiary_mi2s_rx_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(TERTIARY_MI2S_RX) };
 
+static const struct snd_kcontrol_new primary_pcm_rx_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(PRIMARY_PCM_RX) };
+
+static const struct snd_kcontrol_new secondary_pcm_rx_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(SECONDARY_PCM_RX) };
+
+static const struct snd_kcontrol_new tertiary_pcm_rx_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(TERTIARY_PCM_RX) };
+
+static const struct snd_kcontrol_new quaternary_pcm_rx_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(QUATERNARY_PCM_RX) };
+
 static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(SLIMBUS_0_RX) };
 
@@ -695,6 +723,18 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("TERT_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   tertiary_mi2s_rx_mixer_controls,
 			   ARRAY_SIZE(tertiary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("PRI_PCM_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   primary_pcm_rx_mixer_controls,
+			   ARRAY_SIZE(primary_pcm_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SEC_PCM_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   secondary_pcm_rx_mixer_controls,
+			   ARRAY_SIZE(secondary_pcm_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("TERT_PCM_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   tertiary_pcm_rx_mixer_controls,
+			   ARRAY_SIZE(tertiary_pcm_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("QUAT_PCM_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   quaternary_pcm_rx_mixer_controls,
+			   ARRAY_SIZE(quaternary_pcm_rx_mixer_controls)),
 	SND_SOC_DAPM_MIXER("PRIMARY_TDM_RX_0 Audio Mixer", SND_SOC_NOPM, 0, 0,
 				pri_tdm_rx_0_mixer_controls,
 				ARRAY_SIZE(pri_tdm_rx_0_mixer_controls)),
@@ -853,6 +893,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	Q6ROUTING_RX_DAPM_ROUTE("TERT_MI2S_RX Audio Mixer", "TERT_MI2S_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SEC_MI2S_RX Audio Mixer", "SEC_MI2S_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("PRI_MI2S_RX Audio Mixer", "PRI_MI2S_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("PRI_PCM_RX Audio Mixer", "PRI_PCM_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("SEC_PCM_RX Audio Mixer", "SEC_PCM_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("TERT_PCM_RX Audio Mixer", "TERT_PCM_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("QUAT_PCM_RX Audio Mixer", "QUAT_PCM_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("PRIMARY_TDM_RX_0 Audio Mixer",
 				"PRIMARY_TDM_RX_0"),
 	Q6ROUTING_RX_DAPM_ROUTE("PRIMARY_TDM_RX_1 Audio Mixer",
-- 
2.21.1

