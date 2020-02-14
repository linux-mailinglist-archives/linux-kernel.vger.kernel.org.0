Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C515F644
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgBNS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387537AbgBNS66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:58:58 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D354022314;
        Fri, 14 Feb 2020 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581706737;
        bh=rDuZDiF8LTia0x0F357avgt8TEOw/x+rB4MF/F1tReE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3/JM0B4pLm2N/iLytENA9CoC5JNNY7xiTbNXgPklcwuJ136fxZO1GjfqWLQjSyjU
         q9m6F0ra6RcWGlwc8Iq+PfxHKIgVxpDud1ViYpAwbkhyOuRqMDN5EO1eoM/bpyPXL4
         T8qjYBwcRzWP/RITcUqxsqkNUxDKIVTHrzaUht70=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: add migration count iff migration happens
Date:   Fri, 14 Feb 2020 10:58:54 -0800
Message-Id: <20200214185855.217360-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214185855.217360-1-jaegeuk@kernel.org>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If first segment is empty and migration_granularity is 1, we can't move this
at all.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 65c0687ee2bb..bbf4db3f6bb4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1233,12 +1233,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 							segno, gc_type);
 
 		stat_inc_seg_count(sbi, type, gc_type);
+		migrated++;
 
 freed:
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
-		migrated++;
 
 		if (__is_large_section(sbi) && segno + 1 < end_segno)
 			sbi->next_victim_seg[gc_type] = segno + 1;
-- 
2.25.0.265.gbab2e86ba0-goog

