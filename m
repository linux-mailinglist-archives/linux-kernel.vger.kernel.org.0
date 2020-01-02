Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2D12E3B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgABIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 03:15:25 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51859 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbgABIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:15:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmanhFc_1577952914;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmanhFc_1577952914)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 16:15:21 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/page-writeback.c: use div64_ul() for u64-by-unsigned-long divide
Date:   Thu,  2 Jan 2020 16:14:41 +0800
Message-Id: <20200102081442.8273-3-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102081442.8273-1-wenyang@linux.alibaba.com>
References: <20200102081442.8273-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two variables 'numerator' and 'denominator',
though they are declared as long, they should actually be
unsigned long (according to the implementation of the
fprop_fraction_percpu() function)

And do_div() does a 64-by-32 division, while the divisor
'denominator' is unsigned long, thus 64-bit on 64-bit platforms.
Hence the proper function to call is div64_ul().

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
index 2d658b2..c74c6bd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -766,7 +766,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 	struct wb_domain *dom = dtc_dom(dtc);
 	unsigned long thresh = dtc->thresh;
 	u64 wb_thresh;
-	long numerator, denominator;
+	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
 	/*
@@ -777,7 +777,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 
 	wb_thresh = (thresh * (100 - bdi_min_ratio)) / 100;
 	wb_thresh *= numerator;
-	do_div(wb_thresh, denominator);
+	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
 
-- 
1.8.3.1

