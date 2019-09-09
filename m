Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A577AD469
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbfIIIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfIIIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:06:57 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618342086D;
        Mon,  9 Sep 2019 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568016416;
        bh=gBnN4mBgf2SZFJnxSuZz5ZjjrkXhkkVXGa7TuEUaPYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shcqLVlkKJ8x8hG17xWUsY/UzdOjlYXf3/brnsMT7+cu79VhwxLHE6Gvs2ZPgQc6b
         7PEFUwCQavFWkAnoujhIFkpuIH3339qVrYAhnUD+mosCSScXNUm/eeCzDHFDHRqHhP
         axYv35sE2skJL0/YDAVuFdWFPxLqLqdQRiCr3BpM=
Date:   Mon, 9 Sep 2019 09:06:54 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: do not select same victim right
 again
Message-ID: <20190909080654.GD21625@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <69933b7f-48cc-47f9-ba6f-b5ca8f733cba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69933b7f-48cc-47f9-ba6f-b5ca8f733cba@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Chao Yu wrote:
> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> > GC must avoid select the same victim again.
> 
> Blocks in previous victim will occupy addition free segment, I doubt after this
> change, FGGC may encounter out-of-free space issue more frequently.

Hmm, actually this change seems wrong by sec_usage_check().
We may be able to avoid this only in the suspicious loop?

---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e88f98ddf396..5877bd729689 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		round++;
 	}
 
-	if (gc_type == FG_GC)
+	if (gc_type == FG_GC && seg_freed)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (sync)
-- 
2.19.0.605.g01d371f741-goog

