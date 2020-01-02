Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA58412E3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 09:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgABIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 03:15:32 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35298 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbgABIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:15:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmaHn71_1577952921;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmaHn71_1577952921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 16:15:28 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/page-writeback.c: improve arithmetic divisions
Date:   Thu,  2 Jan 2020 16:14:42 +0800
Message-Id: <20200102081442.8273-4-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102081442.8273-1-wenyang@linux.alibaba.com>
References: <20200102081442.8273-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use div64_ul() instead of do_div() if the divisor is unsigned long,
to avoid truncation to 32-bit on 64-bit platforms.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c74c6bd..2caf780 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1102,7 +1102,7 @@ static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 	bw = written - min(written, wb->written_stamp);
 	bw *= HZ;
 	if (unlikely(elapsed > period)) {
-		do_div(bw, elapsed);
+		bw = div64_ul(bw, elapsed);
 		avg = bw;
 		goto out;
 	}
-- 
1.8.3.1

