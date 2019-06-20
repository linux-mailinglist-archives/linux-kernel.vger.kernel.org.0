Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9937F4CB98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfFTKLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 06:11:40 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2499 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:11:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d0b5bc4b63-aacf5; Thu, 20 Jun 2019 18:11:17 +0800 (CST)
X-RM-TRANSID: 2ee55d0b5bc4b63-aacf5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35d0b5bc4b72-284b9;
        Thu, 20 Jun 2019 18:11:17 +0800 (CST)
X-RM-TRANSID: 2ee35d0b5bc4b72-284b9
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     rubini@gnudd.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] FMC: fix 'passing zero to PTR_ERR()' warning
Date:   Thu, 20 Jun 2019 18:10:21 +0800
Message-Id: <1561025421-19655-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
drivers/fmc/fmc-debug.c:155
	fmc_debug_init() warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fmc/fmc-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 1734c7c..dd33951 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -152,7 +152,7 @@ int fmc_debug_init(struct fmc_device *fmc)
 	fmc->dbg_dir = debugfs_create_dir(dev_name(&fmc->dev), NULL);
 	if (IS_ERR_OR_NULL(fmc->dbg_dir)) {
 		pr_err("FMC: Cannot create debugfs\n");
-		return PTR_ERR(fmc->dbg_dir);
+		return PTR_ERR_OR_ZERO(fmc->dbg_dir);
 	}
 
 	fmc->dbg_sdb_dump = debugfs_create_file(FMC_DBG_SDB_DUMP, 0444,
-- 
1.9.1



