Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775BF33215
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 16:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfFCOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 10:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfFCOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:25:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9C6276D9;
        Mon,  3 Jun 2019 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559571929;
        bh=+QIzxGsUhsEKFyL0nxTNvsmWYp4/6as/1NSx0KwKtRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qt9tpqH8wWIrAtw957J/FmI0t+O5nivCFBeQS6FjFK/uFeVdPPzzuhhaC8kqKjT2U
         K1Cg3UTV0bBA1o9IaLIoIHzJwDIZO+tNvGQgnq1AzpSoX5Dnkh1/svgHv6naOcJkVk
         9xrRPkFS5XM+p48ob2rhQcyfFn7zh84HoSlKIv+0=
Date:   Mon, 3 Jun 2019 16:25:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH v2] block: aoe: no need to check return value of
 debugfs_create functions
Message-ID: <20190603142526.GA17169@kroah.com>
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Ed L. Cashin" <ed.cashin@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: fix uninitialized entry issue found by Omar Sandoval

 drivers/block/aoe/aoeblk.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index e2c6aae2d636..bd19f8af950b 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -196,7 +196,6 @@ static const struct file_operations aoe_debugfs_fops = {
 static void
 aoedisk_add_debugfs(struct aoedev *d)
 {
-	struct dentry *entry;
 	char *p;
 
 	if (aoe_debugfs_dir == NULL)
@@ -207,15 +206,8 @@ aoedisk_add_debugfs(struct aoedev *d)
 	else
 		p++;
 	BUG_ON(*p == '\0');
-	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
-				    &aoe_debugfs_fops);
-	if (IS_ERR_OR_NULL(entry)) {
-		pr_info("aoe: cannot create debugfs file for %s\n",
-			d->gd->disk_name);
-		return;
-	}
-	BUG_ON(d->debugfs);
-	d->debugfs = entry;
+	d->debugfs = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
+					 &aoe_debugfs_fops);
 }
 void
 aoedisk_rm_debugfs(struct aoedev *d)
@@ -472,10 +464,6 @@ aoeblk_init(void)
 	if (buf_pool_cache == NULL)
 		return -ENOMEM;
 	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
-	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
-		pr_info("aoe: cannot create debugfs directory\n");
-		aoe_debugfs_dir = NULL;
-	}
 	return 0;
 }
 
-- 
2.21.0

