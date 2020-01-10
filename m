Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19741365B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 04:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgAJDJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 22:09:06 -0500
Received: from foss.arm.com ([217.140.110.172]:39046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJDJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:09:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2925411D4;
        Thu,  9 Jan 2020 19:09:05 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5672B3F703;
        Thu,  9 Jan 2020 19:08:57 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH V11 3/5] of/fdt: Mark boot memory with MEMBLOCK_BOOT
Date:   Fri, 10 Jan 2020 08:39:13 +0530
Message-Id: <1578625755-11792-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
References: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_init_dt_add_memory_arch() adds memory into memblock on both UEFI and
DT based arm64 systems. Lets mark these as boot memory right after they get
into memblock. All other platforms using this default implementation for
early_init_dt_add_memory_arch() will also have this memblock flag set on
boot memory ranges but will be upto the platforms if they would like to
use it or not. On arm64 platform this flag will be used to identify boot
memory at runtime and reject any attempt to remove them.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/of/fdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2cdf64d..a2ae2c88 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1143,6 +1143,7 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 		base = phys_offset;
 	}
 	memblock_add(base, size);
+	memblock_mark_boot(base, size);
 }
 
 int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
-- 
2.7.4

