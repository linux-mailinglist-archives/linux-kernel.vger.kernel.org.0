Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA1A52DE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfIBJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:34:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33634 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfIBJep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:34:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4ijL-0006Rq-1A; Mon, 02 Sep 2019 09:34:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] ocfs2: remove deadcode on variable tmp_oh check
Date:   Mon,  2 Sep 2019 10:34:34 +0100
Message-Id: <20190902093434.27739-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

At the end of ocfs2_inode_lock_tracker tmp_oh is true because an
earlier check on tmp_oh being false returns out of the function.
Since tmp_oh is true, the function will always return 1 so remove
the redundant check and return of 0.

Also update description in comment, return -EINVAL and not -1.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Fix typo of function name in description.
    Update description in comment as noted by Joseph Qi

---
 fs/ocfs2/dlmglue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index ad594fef2ab0..640eee2bb903 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2626,7 +2626,8 @@ void ocfs2_inode_unlock(struct inode *inode,
  *
  * return < 0 on error, return == 0 if there's no lock holder on the stack
  * before this call, return == 1 if this call would be a recursive locking.
- * return == -1 if this lock attempt will cause an upgrade which is forbidden.
+ * return == -EINVAL if this lock attempt will cause an upgrade which is
+ * forbidden.
  *
  * When taking lock levels into account,we face some different situations.
  *
@@ -2712,7 +2713,7 @@ int ocfs2_inode_lock_tracker(struct inode *inode,
 			return status;
 		}
 	}
-	return tmp_oh ? 1 : 0;
+	return 1;
 }
 
 void ocfs2_inode_unlock_tracker(struct inode *inode,
-- 
2.20.1

