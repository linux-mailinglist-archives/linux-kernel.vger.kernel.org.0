Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67503A66A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfICKgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 06:36:19 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:35616 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728747AbfICKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:36:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 562C2C0416;
        Tue,  3 Sep 2019 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567506960; bh=wcWwratgm8ehYW75XaHQWAIMPGVfnICMKiObM27MCu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GniHgZu+adDcfTGlIjdjxgpPuaMK3KYAHngpYsl8jlO+u2gWCty2+hLXDbsv5j1fs
         qFZ5QPKuDJy5vGhQVlHqDcCmleIOkYf4zeEWtA0PWyutbUt0E4k/yOxa9Tu9itLS3n
         HMx40mPjd84uM+rHlgDeKoj+cJ6avEUoouCB0HafmRJyxobd8Mu1XSDMeP78Uxl49h
         SZvAZHsaDZ9OfMohgLXOW4pQWoFUpK7JJTmu9tzZWQjDg4o61ZHsMqw5x6571uBAGp
         MR/HJUoLNRTAltgR0/1WTYtp/KFEqg3UlxXGGsMrRqstY5GPhg7ivV8lfQKgefkvjA
         3GoaWeBRxqorQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 212D3A006A;
        Tue,  3 Sep 2019 10:35:57 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E55A93C0E4;
        Tue,  3 Sep 2019 12:35:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 5/5] i3c: master: dw: reattach device on first available location of address table
Date:   Tue,  3 Sep 2019 12:35:54 +0200
Message-Id: <594bce70368177256376fc2f592736db78cf40db.1567437955.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For today the reattach function only update the device address on the
controller.

Update the location to the first available too, will optimize the
enumeration process avoiding additional checks to keep the available
positions on address table consecutive.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Change in v2:
  - Add Boris rb-tag

 drivers/i3c/master/dw-i3c-master.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97..62261ac 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -898,6 +898,22 @@ static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+
+	if (data->index > pos && pos > 0) {
+		writel(0,
+		       master->regs +
+		       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+		master->addrs[data->index] = 0;
+		master->free_pos |= BIT(data->index);
+
+		data->index = pos;
+		master->addrs[pos] = dev->info.dyn_addr;
+		master->free_pos &= ~BIT(pos);
+	}
 
 	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(dev->info.dyn_addr),
 	       master->regs +
-- 
2.7.4

