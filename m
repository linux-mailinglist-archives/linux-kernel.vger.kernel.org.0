Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4D1929A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCYN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 09:29:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54793 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:29:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jH65q-00012o-5r; Wed, 25 Mar 2020 13:29:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mchp-i2s-mcc: make signed 1 bit bitfields unsigned
Date:   Wed, 25 Mar 2020 13:29:13 +0000
Message-Id: <20200325132913.110115-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The signed 1 bit bitfields should be unsigned, so make them unsigned.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index befc2a3a05b0..3cb63886195f 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -239,10 +239,10 @@ struct mchp_i2s_mcc_dev {
 	unsigned int				frame_length;
 	int					tdm_slots;
 	int					channels;
-	int					gclk_use:1;
-	int					gclk_running:1;
-	int					tx_rdy:1;
-	int					rx_rdy:1;
+	unsigned int				gclk_use:1;
+	unsigned int				gclk_running:1;
+	unsigned int				tx_rdy:1;
+	unsigned int				rx_rdy:1;
 };
 
 static irqreturn_t mchp_i2s_mcc_interrupt(int irq, void *dev_id)
-- 
2.25.1

