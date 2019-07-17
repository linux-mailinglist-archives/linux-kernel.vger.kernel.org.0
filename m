Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986216BA44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 12:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfGQKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 06:32:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfGQKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:32:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B648628;
        Wed, 17 Jul 2019 03:32:33 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B0EF3F71A;
        Wed, 17 Jul 2019 03:32:32 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, will@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH] MAINTAINERS: Update my email address
Date:   Wed, 17 Jul 2019 11:32:15 +0100
Message-Id: <1563359535-2762-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My @arm.com address will stop working in a couple of weeks. Update
MAINTAINERS and .mailmap files with an address I'll have access to.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0fef932..468bced8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -116,6 +116,7 @@ John Stultz <johnstul@us.ibm.com>
 Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
+Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
 Kay Sievers <kay.sievers@vrfy.org>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 91d8700..9525601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8808,7 +8808,7 @@ F:	arch/x86/kvm/svm.c
 KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
 M:	Marc Zyngier <marc.zyngier@arm.com>
 R:	James Morse <james.morse@arm.com>
-R:	Julien Thierry <julien.thierry@arm.com>
+R:	Julien Thierry <julien.thierry.kdev@gmail.com>
 R:	Suzuki K Pouloze <suzuki.poulose@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
-- 
1.9.1

