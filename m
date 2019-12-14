Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D311F4EA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLNWfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:35:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47642 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576362907; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=D8vcvAXh5n4Ipif6aaOi/DGeJKxBOvkvdh2wheOB+JI=;
        b=pxfJyM/sjHPouXV1XzvvqPmfTYqZI4FDkQ1OTxSXW4DRzNRYzd+hf5lpI8qTRbHlXx+ro1
        JHYysaf6ckh5rPur+PU8aFkEHLsq2S9emG4WKpBvf3CXvu8ekBAWf1ty02IFJVbUa1gNZ/
        q398Ik1pKvXTBBvg42rsuwyEOtt+l34=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] clk: ingenic/jz4770: Exit with error if CGU init failed
Date:   Sat, 14 Dec 2019 23:35:00 +0100
Message-Id: <20191214223500.100093-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit jz4770_cgu_init() if the 'cgu' pointer we get is NULL, since the
pointer is passed as argument to functions later on.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/clk/ingenic/jz4770-cgu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 956dd653a43d..c051ecba5cf8 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -432,8 +432,10 @@ static void __init jz4770_cgu_init(struct device_node *np)
 
 	cgu = ingenic_cgu_new(jz4770_cgu_clocks,
 			      ARRAY_SIZE(jz4770_cgu_clocks), np);
-	if (!cgu)
+	if (!cgu) {
 		pr_err("%s: failed to initialise CGU\n", __func__);
+		return;
+	}
 
 	retval = ingenic_cgu_register_clocks(cgu);
 	if (retval)
-- 
2.24.0

