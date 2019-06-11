Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB03D58B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfFKScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 14:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfFKScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:32:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FA220644;
        Tue, 11 Jun 2019 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560277936;
        bh=2S8M8v4FB5RHddbCWKRYJB64xPBafiD5zeA1G+leo08=;
        h=Date:From:To:Cc:Subject:From;
        b=tGgboCs+zpxFBvOUK/Iba/yzvcMm/Jo6BSXEXddMryyKE9UX/V6XObXXipRI2U/Z5
         BTJ1RwsyfDFcYPHPZahEL9+WjvYA9lNqYaqOGAInLzzqj+lQpl8hGg5AAkWYk7Uw1E
         SuMnvThZm/1sXy1CkesltR3i8VSG8J1EjKfEJ/Ag=
Date:   Tue, 11 Jun 2019 20:32:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <20190611183213.GA31645@kroah.com>
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

Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/lkdtm/core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 1972dad966f5..bae3b3763f3e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -429,22 +429,13 @@ static int __init lkdtm_module_init(void)
 
 	/* Register debugfs interface */
 	lkdtm_debugfs_root = debugfs_create_dir("provoke-crash", NULL);
-	if (!lkdtm_debugfs_root) {
-		pr_err("creating root dir failed\n");
-		return -ENODEV;
-	}
 
 	/* Install debugfs trigger files. */
 	for (i = 0; i < ARRAY_SIZE(crashpoints); i++) {
 		struct crashpoint *cur = &crashpoints[i];
-		struct dentry *de;
 
-		de = debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root,
-					 cur, &cur->fops);
-		if (de == NULL) {
-			pr_err("could not create crashpoint %s\n", cur->name);
-			goto out_err;
-		}
+		debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root, cur,
+				    &cur->fops);
 	}
 
 	/* Install crashpoint if one was selected. */
-- 
2.22.0

