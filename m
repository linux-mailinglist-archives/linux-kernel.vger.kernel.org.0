Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3A3C75E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405034AbfFKJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:38:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405018AbfFKJig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DAAFEC;
        Tue, 11 Jun 2019 02:38:36 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85AEE3F77D;
        Tue, 11 Jun 2019 02:38:34 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 8/8] arm64: Allow selecting Pseudo-NMI again
Date:   Tue, 11 Jun 2019 10:38:13 +0100
Message-Id: <1560245893-46998-9-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Pseudo-NMI are fixed, allow the use of that option again

This reverts commit 96a13f57b946be7a6c10405e4bd780c0b6b6fe63 ("arm64:
Kconfig: Make ARM64_PSEUDO_NMI depend on BROKEN for now").

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8acc40e..a9dde24 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1423,7 +1423,6 @@ config ARM64_MODULE_PLTS

 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
-	depends on BROKEN # 1556553607-46531-1-git-send-email-julien.thierry@arm.com
 	select CONFIG_ARM_GIC_V3
 	help
 	  Adds support for mimicking Non-Maskable Interrupts through the use of
--
1.9.1
