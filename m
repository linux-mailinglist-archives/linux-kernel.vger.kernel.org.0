Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954981609C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 06:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBQFEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 00:04:31 -0500
Received: from foss.arm.com ([217.140.110.172]:57578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgBQFE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:04:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DA9106F;
        Sun, 16 Feb 2020 21:04:29 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A2293F703;
        Sun, 16 Feb 2020 21:04:25 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>
Subject: [PATCH 4/5] mm/vma: Replace all remaining open encodings with vma_set_anonymous()
Date:   Mon, 17 Feb 2020 10:33:52 +0530
Message-Id: <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all remaining open encodings with vma_set_anonymous().

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/misc/mic/scif/scif_mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_mmap.c b/drivers/misc/mic/scif/scif_mmap.c
index a151d416f39c..1f0dec5df994 100644
--- a/drivers/misc/mic/scif/scif_mmap.c
+++ b/drivers/misc/mic/scif/scif_mmap.c
@@ -580,7 +580,7 @@ static void scif_munmap(struct vm_area_struct *vma)
 	 * The kernel probably zeroes these out but we still want
 	 * to clean up our own mess just in case.
 	 */
-	vma->vm_ops = NULL;
+	vma_set_anonymous(vma);
 	vma->vm_private_data = NULL;
 	kref_put(&vmapvt->ref, vma_pvt_release);
 	scif_delete_vma(ep, vma);
-- 
2.20.1

