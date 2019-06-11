Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4B3D5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392027AbfFKSpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 14:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392016AbfFKSpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:45:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C329217F4;
        Tue, 11 Jun 2019 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278706;
        bh=lrKAmFdOU8h66+U4Es5y8xQzLQ2sUZtxRlrzObRJ7II=;
        h=Date:From:To:Cc:Subject:From;
        b=UdhhQ3VThGcK+CWp9Hko77z9NA+RloZzgfoAngP0NZl8Y90fNLCCkHKwQ+YvJ89DO
         UZdyCZp1eCnOEKP4XhdEp6ViopxjX+1L0VenIOHT5qISe7gFE3eq2Fyf3wXNHI5cgh
         mO29/+x3pkKY6HBJ52aEYRjknA9Ls7EN3hIH1wpU=
Date:   Tue, 11 Jun 2019 20:45:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ti-st: no need to check return value of debugfs_create
 functions
Message-ID: <20190611184503.GA3212@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ti-st/st_kim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index e7cfdbd1f66d..93821c11bff9 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -761,10 +761,6 @@ static int kim_probe(struct platform_device *pdev)
 	pr_info("sysfs entries created\n");
 
 	kim_debugfs_dir = debugfs_create_dir("ti-st", NULL);
-	if (!kim_debugfs_dir) {
-		pr_err(" debugfs entries creation failed ");
-		return 0;
-	}
 
 	debugfs_create_file("version", S_IRUGO, kim_debugfs_dir,
 				kim_gdata, &version_fops);
-- 
2.22.0

