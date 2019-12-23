Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D212966B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLWNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 08:20:41 -0500
Received: from 8bytes.org ([81.169.241.247]:58548 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfLWNUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:20:41 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 93001374; Mon, 23 Dec 2019 14:20:39 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Remove unused variable
Date:   Mon, 23 Dec 2019 14:20:37 +0100
Message-Id: <20191223132037.21016-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The iommu variable in set_device_exclusion_range() us unused
now and causes a compiler warning. Remove it.

Fixes: 387caf0b759a ("iommu/amd: Treat per-device exclusion ranges as r/w unity-mapped regions")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 36649592ddf3..ba7ee4aa04f9 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1118,8 +1118,6 @@ static int __init add_early_maps(void)
  */
 static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 {
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
 		return;
 
-- 
2.16.4

