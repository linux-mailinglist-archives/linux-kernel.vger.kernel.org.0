Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E497C15F640
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbgBNS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgBNS65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:58:57 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9EC206CC;
        Fri, 14 Feb 2020 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581706737;
        bh=hN7SPeLJCWEGiPDKat8V/+hhK7EWj0c4fKIn0VjGFk0=;
        h=From:To:Cc:Subject:Date:From;
        b=qHZpcGNuWvHNt/z3H9CN/IMRyi0p2dBOzNsijHzhWgXo8NjQ2NUxR0eGpaLmS55hK
         yLfOG8hj01HDsWBYgeHp4kTgK/XMeuyZYrcPAz6zdc2fSXFrEsZcj7WWCMOFSjfp+T
         uRvfQcKsdF7F6a4eJ+oSQXIYfuACGsrYmKAWfquU=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: skip GC when section is full
Date:   Fri, 14 Feb 2020 10:58:53 -0800
Message-Id: <20200214185855.217360-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes skipping GC when segment is full in large section.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 53312d7bc78b..65c0687ee2bb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1018,8 +1018,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 * race condition along with SSR block allocation.
 		 */
 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
-				get_valid_blocks(sbi, segno, false) ==
-							sbi->blocks_per_seg)
+				get_valid_blocks(sbi, segno, true) ==
+							BLKS_PER_SEC(sbi))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
-- 
2.25.0.265.gbab2e86ba0-goog

