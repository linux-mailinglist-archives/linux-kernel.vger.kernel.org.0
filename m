Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2383595CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfHTLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 07:02:40 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:19464 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTLCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:02:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46CSWz127Gz4S;
        Tue, 20 Aug 2019 13:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566298864; bh=7co5wnQ3/O79mxKwCpqnJqCBL6XFasVx/wy1++EocGA=;
        h=Date:From:Subject:To:Cc:From;
        b=Eb4rZOLBebZL0QH5VZLSOw4ImkiN+9qwGzwI4RBTmySuHQgJ3KlfXCVRyJCI3Pdbh
         ZdcELjBEZ8sRWIRoj+7Pkgqsga0KpVurAEoUUmt2QlMwD1yakiPbZ1ejdok5QKNInu
         OClzLQRYyawEklF+OQ5u2xhcu8UcgaDY7sFjOVa8/RpWFbqhFACKmLivcuOqexv+Hy
         lT4xMqBYTnE7nFL3IA8KvKIOOtlAlsmzcDKb3/ueuK/+GZrQu/skpTkFEPDbQR+RgB
         KmNlc4x4Dzsf5ayyF1dNdDr+So1k7rN2s6Xvu2dHL2WpnNtH8Bviw7yl1zGHnC5dmH
         M3j6Os4kwVAaA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Tue, 20 Aug 2019 13:02:35 +0200
Message-Id: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566298834.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/2] ASoC: wm8904: fix typo in DAPM kcontrol name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Enrico Weigelt <info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for typo in "Capture Inverting Mux"es' name.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 v2: no changes
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 5ebdd1d9afde..525e4ef654a1 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -866,7 +866,7 @@ static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
 			    lin_text);
 
 static const struct snd_kcontrol_new lin_inv_mux =
-	SOC_DAPM_ENUM("Left Capture Inveting Mux", lin_inv_enum);
+	SOC_DAPM_ENUM("Left Capture Inverting Mux", lin_inv_enum);
 
 static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
@@ -882,7 +882,7 @@ static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
 			    rin_text);
 
 static const struct snd_kcontrol_new rin_inv_mux =
-	SOC_DAPM_ENUM("Right Capture Inveting Mux", rin_inv_enum);
+	SOC_DAPM_ENUM("Right Capture Inverting Mux", rin_inv_enum);
 
 static const char *aif_text[] = {
 	"Left", "Right"
-- 
2.20.1

