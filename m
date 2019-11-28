Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4A10CFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 23:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfK1WiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 17:38:24 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43739 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1WiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:38:24 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0C8B222EDB;
        Thu, 28 Nov 2019 23:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574980701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y4b1ub2wBoYW7RKVV+BH5we4lCb9ywzmaPsTxmMyDsk=;
        b=NJL1lyR+dokvXhronO4ODUDIpDTJnoHq9SNH4vy7IYHQChy3MqCdy/OvuzrlxeOkZ3Qg6y
        5cO7IEiUJmDgAMv7oLF5Rs5ylkckd0ssFX3HvDSA6O6Tl88Fcxq6LZY0CXobj6GT3+x+tN
        qIlcpI5FRiExHQnBT6Da8KJ4Tly/dzA=
From:   Michael Walle <michael@walle.cc>
To:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
Date:   Thu, 28 Nov 2019 23:38:02 +0100
Message-Id: <20191128223802.18228-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 0C8B222EDB
X-Spamd-Result: default: False [6.40 / 15.00];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.593];
         FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
IRQF_SHARED to be able to use these SAIs simultaneously.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b517e4bc1b87..8c3ea7300972 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -958,7 +958,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
+	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, IRQF_SHARED,
+			       np->name, sai);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
 		return ret;
-- 
2.20.1

