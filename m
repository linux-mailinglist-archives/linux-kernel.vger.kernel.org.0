Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A634A79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfFDOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:30:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52916 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfFDOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559658628; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viJUkG4rMZjmr4ujhcAN08ahuisy1yD+ApHwFnkhEr8=;
        b=gyHWCuCWqmd/onBzcGjlDALLWXoBVHEuV/qyP33BPSkEJSFaJMQmtPrN6lIiE+e5mq1V5o
        fAow2rJl84OeSge1x9MtvHtfMtG6XD0UUAgmMCVeCZZSMfOzVi5bneyqm2qhnBx8dGk4HM
        V5CUD2ZlVdO9oLeh7LW7ZegOUKX1uX8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [RE-RESEND PATCH v3 3/4] memory: jz4780-nemc: Reduce size of const array
Date:   Tue,  4 Jun 2019 16:30:17 +0200
Message-Id: <20190604143018.11644-3-paul@crapouillou.net>
In-Reply-To: <20190604143018.11644-1-paul@crapouillou.net>
References: <20190604143018.11644-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum value found in that array is 15, there's no need to store
these values as uint32_t, a uint8_t is enough.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Remove casts to uint32_t
    
    v3: No change

 drivers/memory/jz4780-nemc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index bcf06adefc96..66b8b43eaeff 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	 * Conversion of tBP and tAW cycle counts to values supported by the
 	 * hardware (round up to the next supported value).
 	 */
-	static const uint32_t convert_tBP_tAW[] = {
+	static const u8 convert_tBP_tAW[] = {
 		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 
 		/* 11 - 12 -> 12 cycles */
-- 
2.21.0.593.g511ec345e18

