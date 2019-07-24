Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100D4733C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfGXQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:26:10 -0400
Received: from foss.arm.com ([217.140.110.172]:43434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfGXQ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0329428;
        Wed, 24 Jul 2019 09:26:06 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35343F71F;
        Wed, 24 Jul 2019 09:26:04 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 12/15] arm64/lib: Add an helper to free memory allocated by the ASID allocator
Date:   Wed, 24 Jul 2019 17:25:31 +0100
Message-Id: <20190724162534.7390-13-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the ASID allocator (e.g VMID) may require to free any
resource if the initialization fail. So introduce a function allows to
free any memory allocated by the ASID allocator.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v3:
        - Patch added
---
 arch/arm64/include/asm/lib_asid.h | 2 ++
 arch/arm64/lib/asid.c             | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/lib_asid.h b/arch/arm64/include/asm/lib_asid.h
index c18e9eca500e..ff78865a6823 100644
--- a/arch/arm64/include/asm/lib_asid.h
+++ b/arch/arm64/include/asm/lib_asid.h
@@ -74,4 +74,6 @@ int asid_allocator_init(struct asid_info *info,
 			u32 bits, unsigned int asid_per_ctxt,
 			void (*flush_cpu_ctxt_cb)(void));
 
+void asid_allocator_free(struct asid_info *info);
+
 #endif
diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
index 0b3a99c4aed4..d23f0df656c1 100644
--- a/arch/arm64/lib/asid.c
+++ b/arch/arm64/lib/asid.c
@@ -183,3 +183,8 @@ int asid_allocator_init(struct asid_info *info,
 
 	return 0;
 }
+
+void asid_allocator_free(struct asid_info *info)
+{
+	kfree(info->map);
+}
-- 
2.11.0

