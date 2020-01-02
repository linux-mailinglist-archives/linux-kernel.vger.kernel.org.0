Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5212E3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgABIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 03:15:17 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55911 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbgABIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:15:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmanhCh_1577952902;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmanhCh_1577952902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 16:15:14 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/page-writeback.c: avoid potential division by zero in wb_min_max_ratio()
Date:   Thu,  2 Jan 2020 16:14:40 +0800
Message-Id: <20200102081442.8273-2-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102081442.8273-1-wenyang@linux.alibaba.com>
References: <20200102081442.8273-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables 'min' and 'max' are unsigned long and
do_div truncates them to 32 bits, which means it can test
non-zero and be truncated to zero for division.
Fix this issue by using div64_ul() instead.

Fixes: 693108a8a667 ("writeback: make bdi->min/max_ratio handling cgroup writeback aware")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 50055d2..2d658b2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -201,11 +201,11 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 	if (this_bw < tot_bw) {
 		if (min) {
 			min *= this_bw;
-			do_div(min, tot_bw);
+			min = div64_ul(min, tot_bw);
 		}
 		if (max < 100) {
 			max *= this_bw;
-			do_div(max, tot_bw);
+			max = div64_ul(max, tot_bw);
 		}
 	}
 
-- 
1.8.3.1

