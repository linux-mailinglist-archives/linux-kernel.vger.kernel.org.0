Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60A70762
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfGVRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:34:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37862 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfGVReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:23 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC8-0003HL-8b; Mon, 22 Jul 2019 13:33:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 07/14] sched,cfs: fix zero length timeslice calculation
Date:   Mon, 22 Jul 2019 13:33:41 -0400
Message-Id: <20190722173348.9241-8-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way the time slice length is currently calculated, not only do high
priority tasks get longer time slices than low priority tasks, but due
to fixed point math, low priority tasks could end up with a zero length
time slice. This can lead to cache thrashing and other inefficiencies.

Cap the minimum time slice length to sysctl_sched_min_granularity.

Tasks that end up getting a time slice length too long for their relative
priority will simply end up having their vruntime advanced much faster than
other tasks, resulting in them receiving time slices less frequently.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39f7a2d810e1..9ff69b927a3c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -732,6 +732,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	/*
+	 * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
+	 * The vruntime of a low priority task advances faster; those tasks
+	 * will simply get time slices less frequently.
+	 */
+	slice = max_t(u64, slice, sysctl_sched_min_granularity);
 	return slice;
 }
 
-- 
2.20.1

