Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6485B52565
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfFYHxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:53:09 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:52465 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfFYHxH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 25 Jun 2019 03:53:07 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 25 Jun 2019 09:53:06 +0200
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 25 Jun 2019 08:52:33 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, anshuman.khandual@arm.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/5] drivers/base/memory: Remove unneeded check in remove_memory_block_devices
Date:   Tue, 25 Jun 2019 09:52:23 +0200
Message-Id: <20190625075227.15193-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190625075227.15193-1-osalvador@suse.de>
References: <20190625075227.15193-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_memory_block_devices() checks for the range to be aligned
to memory_block_size_bytes, which is our current memory block size,
and WARNs_ON and bails out if it is not.

This is the right to do, but we do already do that in try_remove_memory(),
where remove_memory_block_devices() gets called from, and we even are
more strict in try_remove_memory, since we directly BUG_ON in case the range
is not properly aligned.

Since remove_memory_block_devices() is only called from try_remove_memory(),
we can safely drop the check here.

To be honest, I am not sure if we should kill the system in case we cannot
remove memory.
I tend to think that WARN_ON and return and error is better.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 826dd76f662e..07ba731beb42 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -771,10 +771,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 	struct memory_block *mem;
 	int block_id;
 
-	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
-			 !IS_ALIGNED(size, memory_block_size_bytes())))
-		return;
-
 	mutex_lock(&mem_sysfs_mutex);
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id, NULL);
-- 
2.12.3

