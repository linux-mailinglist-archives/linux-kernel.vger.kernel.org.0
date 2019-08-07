Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2823849A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHGKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 06:34:50 -0400
Received: from foss.arm.com ([217.140.110.172]:46156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfHGKeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84A1728;
        Wed,  7 Aug 2019 03:34:49 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DFE13F575;
        Wed,  7 Aug 2019 03:34:48 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, oleg@redhat.com,
        Dave.Martin@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH] arm64/ptrace: Fix typoes in sve_set() comment
Date:   Wed,  7 Aug 2019 11:34:45 +0100
Message-Id: <20190807103445.32257-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptrace trace SVE flags are prefixed with SVE_PT_*. Update the
comment accordingly.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 17525da8d5c8..0de3eae09d36 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -870,7 +870,7 @@ static int sve_set(struct task_struct *target,
 		goto out;
 
 	/*
-	 * Apart from PT_SVE_REGS_MASK, all PT_SVE_* flags are consumed by
+	 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are consumed by
 	 * sve_set_vector_length(), which will also validate them for us:
 	 */
 	ret = sve_set_vector_length(target, header.vl,
-- 
2.11.0

