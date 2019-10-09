Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80CD0BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfJIJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 05:45:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbfJIJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:45:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6021000;
        Wed,  9 Oct 2019 02:45:03 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61D243F68E;
        Wed,  9 Oct 2019 02:45:02 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/panfrost: Remove commented out call to panfrost_core_dump
Date:   Wed,  9 Oct 2019 10:44:56 +0100
Message-Id: <20191009094456.9704-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009094456.9704-1-steven.price@arm.com>
References: <20191009094456.9704-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

panfrost_core_dump() has never existed in mainline, so remove it and add
a TODO entry that core dump support is currently lacking.

Signed-off-by: Steven Price <steven.price@arm.com>
---
v2:
 * New patch

 drivers/gpu/drm/panfrost/TODO           | 2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/TODO b/drivers/gpu/drm/panfrost/TODO
index 536a0d4f8d29..8c811a9e683b 100644
--- a/drivers/gpu/drm/panfrost/TODO
+++ b/drivers/gpu/drm/panfrost/TODO
@@ -10,3 +10,5 @@
 
 - Compute job support. So called 'compute only' jobs need to be plumbed up to
   userspace.
+
+- Support core dump on job failure
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 21f34d44aac2..33bf25ba506e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -404,8 +404,6 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	}
 	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
 
-	/* panfrost_core_dump(pfdev); */
-
 	panfrost_devfreq_record_transition(pfdev, js);
 	panfrost_device_reset(pfdev);
 
-- 
2.20.1

