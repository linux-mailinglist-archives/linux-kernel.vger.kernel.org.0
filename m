Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE4C966A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfJCBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfJCBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E127B222C8;
        Thu,  3 Oct 2019 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066993;
        bh=674sHQEd1wluZlpmpGS4UprpGUXEIOiNdSfx4wnH0Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhlZM0t9VUSt50XzFkt/IP1tuY5mku4MD4KrTjlETK9iTuEeduxMqFNUJjebxX4Cx
         MTep+XQa5SE7NRRfIkugNjmwvh3vc4+kYIqk/lxCEQYmoZNnx+GOhnjnq9lNmF/uSz
         bZfftureC0kb/3jyxCPXzkqbEKpGUp/vGZYl8cRE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH tip/core/rcu 4/9] drivers/scsi: Replace rcu_swap_protected() with rcu_replace()
Date:   Wed,  2 Oct 2019 18:43:05 -0700
Message-Id: <20191003014310.13262-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/scsi/scsi.c       | 4 ++--
 drivers/scsi/scsi_sysfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1f5b5c8..6a38d4a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -434,8 +434,8 @@ static void scsi_update_vpd_page(struct scsi_device *sdev, u8 page,
 		return;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(*sdev_vpd_buf, vpd_buf,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_buf = rcu_replace(*sdev_vpd_buf, vpd_buf,
+			      lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_buf)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 64c96c7..8d17779 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -466,10 +466,10 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	sdev->request_queue = NULL;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(sdev->vpd_pg80, vpd_pg80,
-			   lockdep_is_held(&sdev->inquiry_mutex));
-	rcu_swap_protected(sdev->vpd_pg83, vpd_pg83,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg80 = rcu_replace(sdev->vpd_pg80, vpd_pg80,
+			       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg83 = rcu_replace(sdev->vpd_pg83, vpd_pg83,
+			       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg83)
-- 
2.9.5

