Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA08125A36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 05:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLSEKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 23:10:03 -0500
Received: from foss.arm.com ([217.140.110.172]:34700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfLSEKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 23:10:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B154231B;
        Wed, 18 Dec 2019 20:10:02 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5563A3F719;
        Wed, 18 Dec 2019 20:09:59 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Drop elements 'hw' and 'phys_callback' from struct memory_block
Date:   Thu, 19 Dec 2019 09:40:50 +0530
Message-Id: <1576728650-13867-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_block structure elements 'hw' and 'phys_callback' are not getting
used. This was originally added with commit 3947be1969a9 ("[PATCH] memory
hotplug: sysfs and add/remove functions") but never seem to have been used.
Just drop them now.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memory.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0ebb105eb261..4e95a9eb8061 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -29,8 +29,6 @@ struct memory_block {
 	int section_count;		/* serialized by mem_sysfs_mutex */
 	int online_type;		/* for passing data to online routine */
 	int phys_device;		/* to which fru does this belong? */
-	void *hw;			/* optional pointer to fw/hw data */
-	int (*phys_callback)(struct memory_block *);
 	struct device dev;
 	int nid;			/* NID for this memory block */
 };
-- 
2.20.1

