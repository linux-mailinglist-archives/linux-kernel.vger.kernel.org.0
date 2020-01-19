Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2056414204D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASV7e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jan 2020 16:59:34 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:45134 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:59:34 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jan 2020 16:59:32 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A65051815EA9E;
        Sun, 19 Jan 2020 22:52:47 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BYE0OVrVUX1P; Sun, 19 Jan 2020 22:52:46 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jXPPM9A4qDEB; Sun, 19 Jan 2020 22:52:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans()
Date:   Sun, 19 Jan 2020 22:52:33 +0100
Message-Id: <20200119215233.7292-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orphans are allowed to point to deleted inodes.
So -ENOENT is not a fatal error.

Reported-by: Кочетков Максим <fido_max@inbox.ru>
Reported-and-tested-by: "Christian Berger" <Christian.Berger@de.bosch.com>
Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when killing orphans.")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/orphan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 54d6db61106f..2645917360b9 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -688,14 +688,14 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 
 			ino_key_init(c, &key1, inum);
 			err = ubifs_tnc_lookup(c, &key1, ino);
-			if (err)
+			if (err && err != -ENOENT)
 				goto out_free;
 
 			/*
 			 * Check whether an inode can really get deleted.
 			 * linkat() with O_TMPFILE allows rebirth of an inode.
 			 */
-			if (ino->nlink == 0) {
+			if (err == 0 && ino->nlink == 0) {
 				dbg_rcvry("deleting orphaned inode %lu",
 					  (unsigned long)inum);
 
-- 
2.16.4

