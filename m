Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35808611F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 11:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfGFPnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:43:02 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45ECA20838;
        Sat,  6 Jul 2019 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562427781;
        bh=+04iMwl0S65cpe+AUJ19IdTwN/SHj80MNd8p9amvXec=;
        h=Date:From:To:Cc:Subject:From;
        b=GwoQrmVWx1LouwCkDHrhhvFh1D9g8eMdIZQ8aI9hS3YpmA+SQPC1ZJpjyt80Wxxsj
         m2oYkNgob6QYVxp8HJqKhbt+jBO2/88U8h60gsomuGdBEGOiknarYgfNn6gY7eb3na
         uIO703UKyFIC3cD6JrVyxGLBHeWa8DERfDguxeQs=
Date:   Sat, 6 Jul 2019 17:42:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] debugfs: make error message a bit more verbose
Message-ID: <20190706154256.GA2683@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a file/directory is already present in debugfs, and it is attempted
to be created again, be more specific about what file/directory is being
created and where it is trying to be created to give a bit more help to
developers to figure out the problem.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7f43c8acfcbf..5836312269e0 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -311,8 +311,13 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	inode_lock(d_inode(parent));
 	dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
+		if (d_is_dir(dentry))
+			pr_err("Directory '%s' with parent '%s' already present!\n",
+			       name, parent->d_name.name);
+		else
+			pr_err("File '%s' in directory '%s' already present!\n",
+			       name, parent->d_name.name);
 		dput(dentry);
-		pr_err("File '%s' already present!\n", name);
 		dentry = ERR_PTR(-EEXIST);
 	}
 
-- 
2.22.0

