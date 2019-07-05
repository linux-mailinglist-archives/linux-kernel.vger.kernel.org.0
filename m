Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0CB60104
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfGEG3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 02:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfGEG3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:29:13 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5809A21852;
        Fri,  5 Jul 2019 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562308152;
        bh=rtqDsA1dt41jmY4HH8dyLkub/U82sQVRFe+2M0a+nCg=;
        h=From:To:Cc:Subject:Date:From;
        b=TCMhTSfTG6e8HjcjQ/khzcsPcnDqritHcZ6OLjp9322MVS1Z7TRWENemxx7rQcdBf
         zuUSYXaA35XA/Y6p7t5ICwKKLNWBzM1njkLJ3b+rJiKLpqwQdQ1JE7BM1KSjicYuUK
         Bf6cGP5MRnee4uZaaImcS3ge3cKgNAci8zDG9Utg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow all the users to pin a file
Date:   Thu,  4 Jul 2019 23:29:10 -0700
Message-Id: <20190705062910.39163-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows users to pin files.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b164f48e0f31..f8d46df8fa9e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2964,9 +2964,6 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
 
-- 
2.19.0.605.g01d371f741-goog

