Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4471D143535
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 02:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAUBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 20:33:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUBd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:33:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF10D2200792A4E24220;
        Tue, 21 Jan 2020 09:33:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 09:33:18 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] ata: pata_macio: fix comparing pointer to 0
Date:   Tue, 21 Jan 2020 09:28:27 +0800
Message-ID: <20200121012827.1036-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

./drivers/ata/pata_macio.c:982:31-32:
	WARNING comparing pointer to 0, suggest !E

Compare pointer-typed values to NULL rather than 0.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 1bfd015..e47a282 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -979,7 +979,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
 	priv->aapl_bus_id =  bidp ? *bidp : 0;
 
 	/* Fixup missing Apple bus ID in case of media-bay */
-	if (priv->mediabay && bidp == 0)
+	if (priv->mediabay && !bidp)
 		priv->aapl_bus_id = 1;
 }
 
-- 
2.7.4

