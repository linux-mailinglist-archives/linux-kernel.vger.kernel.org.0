Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017A918449B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 06:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMKQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:16:49 -0400
Received: from localhost.localdomain (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBA920749;
        Fri, 13 Mar 2020 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584094608;
        bh=j4zj+tBODJfYrfNonkpjegi5R1FYwks2k4pA7ueinyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKLzt/bKYotYoNlmQ0Db3R4WVR6kNanqiNqLbRGrXL9eXJL45c3RfwMIkk8gWxkMZ
         Pgqz1RzwVb/3VZSxWokqjvuUktS+5a//QMrr6QfO/JwEUVs/btuwfpEQNZFxpHNCxC
         e6FrF6nOi0AsN+13zBgm4jtOu9HSjLKbsrwLMe98=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/9] ALSA: compress: Add wma decoder params
Date:   Fri, 13 Mar 2020 15:46:20 +0530
Message-Id: <20200313101627.1561365-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313101627.1561365-1-vkoul@kernel.org>
References: <20200313101627.1561365-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some WMA decoders like WMAv10 etc need some additional encoder option
parameters, so add these as WMA decoder params.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_params.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index a47d9df0fd7b..bf6f7155e775 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -329,6 +329,13 @@ struct snd_dec_flac {
 	__u16 reserved;
 } __attribute__((packed, aligned(4)));
 
+struct snd_dec_wma {
+	__u32 encoder_option;
+	__u32 adv_encoder_option;
+	__u32 adv_encoder_option2;
+	__u32 reserved;
+} __attribute__((packed, aligned(4)));
+
 union snd_codec_options {
 	struct snd_enc_wma wma;
 	struct snd_enc_vorbis vorbis;
@@ -336,6 +343,7 @@ union snd_codec_options {
 	struct snd_enc_flac flac;
 	struct snd_enc_generic generic;
 	struct snd_dec_flac flac_d;
+	struct snd_dec_wma wma_d;
 } __attribute__((packed, aligned(4)));
 
 /** struct snd_codec_desc - description of codec capabilities
-- 
2.24.1

