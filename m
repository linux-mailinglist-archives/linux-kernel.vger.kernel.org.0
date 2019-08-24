Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B09F9C015
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfHXU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 16:27:06 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:5968 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbfHXU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8sF1j5szcY;
        Sat, 24 Aug 2019 22:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678321; bh=GwOHzkGm8clrvcWeJl2STu4OSTCx3WLNVMtfiTxNuU0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=i9L0Zee55MalxIEpKvOUzzET/ECH4QJvMh9/INDvMqLDNQCRyHC0e79/AGq6lF3xM
         oe9LpME1uZtJ51Ks/ywYRTemHFZiLnNeTgoDOojYvKMM9OjxnD+D+jZ7a+yp9yOQXS
         cDegMH5mHN0ZYq/FIYb1gJ76n2vQ5wz2HbdO29mXq9h4cKijGWtF6GsjsOPj9t/smm
         JS0MeW9j42p44Yz57L2ML+8QtJNDqbXwkanUX6jN/EnO/3NpA5PZXM1wJAIlDJ3eyd
         sz5vtClDHhE2cA1BqGW33Nf2H5QXzeoZ92s6630CzPDmXZKbVuu0HCcxvPgpBkEWU8
         k8KUMWSdVO9jw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:56 +0200
Message-Id: <5f1fd1b8f646c5ced1d838c381b6973e5abccd53.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/6] misc: atmel-ssc: get LRCLK pin selection from DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh-dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store LRCLK pin selection for use by ASoC DAI driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
  v2: split from ASoC implementation

---
 drivers/misc/atmel-ssc.c  | 9 +++++++++
 include/linux/atmel-ssc.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index ab4144ea1f11..1322e29bc37a 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -210,6 +210,15 @@ static int ssc_probe(struct platform_device *pdev)
 		struct device_node *np = pdev->dev.of_node;
 		ssc->clk_from_rk_pin =
 			of_property_read_bool(np, "atmel,clk-from-rk-pin");
+		ssc->lrclk_from_tf_pin =
+			of_property_read_bool(np, "atmel,lrclk-from-tf-pin");
+		ssc->lrclk_from_rf_pin =
+			of_property_read_bool(np, "atmel,lrclk-from-rf-pin");
+
+		if (ssc->lrclk_from_tf_pin && ssc->lrclk_from_rf_pin) {
+			dev_err(&pdev->dev, "both LRCLK from RK/TK options found in DT node");
+			return -EINVAL;
+		}
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 6091d2abc1eb..fbe1c2ffaa81 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -21,6 +21,8 @@ struct ssc_device {
 	int			user;
 	int			irq;
 	bool			clk_from_rk_pin;
+	bool			lrclk_from_tf_pin;
+	bool			lrclk_from_rf_pin;
 	bool			sound_dai;
 };
 
-- 
2.20.1

