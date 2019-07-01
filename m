Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD42AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409416AbfFLPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409404AbfFLPfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:35:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CFD8215EA;
        Wed, 12 Jun 2019 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353715;
        bh=MBmMqwaKq7lLowYzqNPWrTYCHId7s+yQGyoFIryVQRU=;
        h=Date:From:To:Cc:Subject:From;
        b=aEQNoMNNfwaugXOvI+uPAxPoc0cde2LjmZBSzwj4wN4Q0iw5eGz4ScL98T1Npu5tl
         uh4n5Yerlodca0LH+0fGXte5ECb5JQswpr0NBWVnityCGp0mXQgK2aa9RBDys78S8s
         nXqtUBz10JftxZYqS7+Ri2jk0sNseNYbNofhtGZw=
Date:   Wed, 12 Jun 2019 17:35:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhong Jiang <zhongjiang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: debugobjects: no need to check return value of
 debugfs_create functions
Message-ID: <20190612153513.GA21082@kroah.com>
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

Cc: Qian Cai <cai@gmx.us>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/debugobjects.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 55437fd5128b..2ac42286cd08 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -850,26 +850,16 @@ static const struct file_operations debug_stats_fops = {
 
 static int __init debug_objects_init_debugfs(void)
 {
-	struct dentry *dbgdir, *dbgstats;
+	struct dentry *dbgdir;
 
 	if (!debug_objects_enabled)
 		return 0;
 
 	dbgdir = debugfs_create_dir("debug_objects", NULL);
-	if (!dbgdir)
-		return -ENOMEM;
 
-	dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
-				       &debug_stats_fops);
-	if (!dbgstats)
-		goto err;
+	debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);
 
 	return 0;
-
-err:
-	debugfs_remove(dbgdir);
-
-	return -ENOMEM;
 }
 __initcall(debug_objects_init_debugfs);
 
-- 
2.22.0

