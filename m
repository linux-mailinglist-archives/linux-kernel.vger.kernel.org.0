Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58909DD71B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJSH0L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Oct 2019 03:26:11 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:31120 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfJSH0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:26:11 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id B03D8734A3179D6AD7A2;
        Sat, 19 Oct 2019 15:26:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x9J7Pkjr067896;
        Sat, 19 Oct 2019 15:25:46 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019101915260155-30950 ;
          Sat, 19 Oct 2019 15:26:01 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     robh@kernel.org
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH] drm/panfrost: fix -Wmissing-prototypes warnings
Date:   Sat, 19 Oct 2019 15:28:14 +0800
Message-Id: <1571470094-39589-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-19 15:26:01,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-19 15:25:53
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn x9J7Pkjr067896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get these warnings when build kernel W=1:
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous prototype for ‘panfrost_perfcnt_clean_cache_done’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous prototype for ‘panfrost_perfcnt_sample_done’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_enable’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_dump’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous prototype for ‘panfrost_perfcnt_close’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous prototype for ‘panfrost_perfcnt_init’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous prototype for ‘panfrost_perfcnt_fini’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous prototype for ‘panfrost_mmu_flush_range’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous prototype for ‘panfrost_mmu_map_fault_addr’ [-Wmissing-prototypes]

For file panfrost_mmu.c, make functions static to fix this.
For file panfrost_perfcnt.c, include head file can fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index bdd9905..d0458a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -224,7 +224,7 @@ static size_t get_pgsize(u64 addr, size_t size)
 	return SZ_2M;
 }
 
-void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
+static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
 			      struct panfrost_mmu *mmu,
 			      u64 iova, size_t size)
 {
@@ -432,7 +432,8 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
-int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
+static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
+		u64 addr)
 {
 	int ret, i;
 	struct panfrost_gem_object *bo;
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 83c57d3..7493dc0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -17,6 +17,7 @@
 #include "panfrost_job.h"
 #include "panfrost_mmu.h"
 #include "panfrost_regs.h"
+#include "panfrost_perfcnt.h"
 
 #define COUNTERS_PER_BLOCK		64
 #define BYTES_PER_COUNTER		4
-- 
1.8.3.1

