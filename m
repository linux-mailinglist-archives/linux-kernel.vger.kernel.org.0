Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F179BAE35F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 07:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393183AbfIJF6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 01:58:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIJF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 01:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NRdpxTk5dBi589Hkb7sXIEJREVoI+vHLv2qPfUGAUUQ=; b=DQg+zG9Bq5bxNhip1wlL6Pw4L
        YkHitVcPmSOBldQ732v/YVE1hwu6TqLmcJs8NEAXFeokGuZqOXzwKU59ufyKcm3/4LONW+EDuMCVs
        vyae5bWgI/tvFkrnC5sZxLtqIlEKUSHoXAf4qVmhcOBdKYDrP1nblHTl8TsNnuXWqsB1ltTFRdDEW
        j9J4atvWL4gAtC3gQ8IdOeHYf2/FaWUeocIk7QPi06g0hjX2y9iknSpauLFcvUB8S6tW+KQhm6+EN
        7AkA1DParvjyan1/5dbiE+llMhEHhtJwWd0VUNKgU1RnvmjM6qkv5eYhGzCLTsvuhcDqv4fvBF1l+
        9CgbVOE5w==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZAh-0001UZ-B4; Tue, 10 Sep 2019 05:58:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/fdt: don't ignore errors from of_setup_earlycon
Date:   Tue, 10 Sep 2019 07:58:33 +0200
Message-Id: <20190910055833.28324-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_setup_earlycon we should keep on iterating earlycon options
instead of breaking out of the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/of/fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cdf14b9aaab..2f6bd03d8e27 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -946,8 +946,8 @@ int __init early_init_dt_scan_chosen_stdout(void)
 		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
 
-		of_setup_earlycon(match, offset, options);
-		return 0;
+		if (of_setup_earlycon(match, offset, options) == 0)
+			return 0;
 	}
 	return -ENODEV;
 }
-- 
2.20.1

