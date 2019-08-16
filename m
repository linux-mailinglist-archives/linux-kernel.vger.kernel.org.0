Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA990376
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHPNyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:54:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfHPNyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:54:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87C58E7345FA12480F5B;
        Fri, 16 Aug 2019 21:54:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 21:53:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <info@metux.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable 'st_quadfs_fs660c32_ops'
Date:   Fri, 16 Aug 2019 21:53:41 +0800
Message-ID: <20190816135341.52248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/st/clkgen-fsyn.c:70:29: warning:
 st_quadfs_fs660c32_ops defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/st/clkgen-fsyn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index ca1ccdb..a156bd0 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -67,7 +67,6 @@ struct clkgen_quadfs_data {
 };
 
 static const struct clk_ops st_quadfs_pll_c32_ops;
-static const struct clk_ops st_quadfs_fs660c32_ops;
 
 static int clk_fs660c32_dig_get_params(unsigned long input,
 		unsigned long output, struct stm_fs *fs);
-- 
2.7.4


