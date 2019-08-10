Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4288B44
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfHJMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 08:16:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38790 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565439385; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObqmLnyvR7akU/D+s02O+7y4dD+NKGIoJ1VwRGXpEuI=;
        b=JJlAnzhvB88pNb+TMjglYE/GF6uPYL6yfOB9TnBfYv54FNN9yt4WS137spYa5ryEJx3lTg
        3lOka2WUVjHIcfMetWO8jsfD5mgI+cn4PL44+7QCTICzpyblW8cL7DkPt/YiVXjjiiCU0m
        Wq8rDvbpAuTNmCD2+j46tgenerfDg4Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] mmc: jz4740: Drop dependency on arch header
Date:   Sat, 10 Aug 2019 14:16:08 +0200
Message-Id: <20190810121608.24145-2-paul@crapouillou.net>
In-Reply-To: <20190810121608.24145-1-paul@crapouillou.net>
References: <20190810121608.24145-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to set the 'slave_id' anymore - that field is never read
by the DMA driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 59f81e8afcce..7ff2034d739a 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -25,8 +25,6 @@
 
 #include <asm/cacheflush.h>
 
-#include <asm/mach-jz4740/dma.h>
-
 #define JZ_REG_MMC_STRPCL	0x00
 #define JZ_REG_MMC_STATUS	0x04
 #define JZ_REG_MMC_CLKRT	0x08
@@ -292,11 +290,9 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
 	if (data->flags & MMC_DATA_WRITE) {
 		conf.direction = DMA_MEM_TO_DEV;
 		conf.dst_addr = host->mem_res->start + JZ_REG_MMC_TXFIFO;
-		conf.slave_id = JZ4740_DMA_TYPE_MMC_TRANSMIT;
 	} else {
 		conf.direction = DMA_DEV_TO_MEM;
 		conf.src_addr = host->mem_res->start + JZ_REG_MMC_RXFIFO;
-		conf.slave_id = JZ4740_DMA_TYPE_MMC_RECEIVE;
 	}
 
 	sg_count = jz4740_mmc_prepare_dma_data(host, data, COOKIE_MAPPED);
-- 
2.21.0.593.g511ec345e18

