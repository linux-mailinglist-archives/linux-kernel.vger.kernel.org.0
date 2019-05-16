Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8442039E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEPKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:38:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfEPKiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF591B8E;
        Thu, 16 May 2019 03:38:23 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4040B3F703;
        Thu, 16 May 2019 03:38:22 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 13/16] arm64: kernel: Add exception on kuser32 to prevent stack analysis
Date:   Thu, 16 May 2019 11:36:52 +0100
Message-Id: <20190516103655.5509-14-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kuser32 being used for compatibility, it contains a32 instructions
which are not recognised by objtool when trying to analyse arm64
object files. Thus, we add an exception to skip validation on this
particular file.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cd434d0719c1..c564f722ebca 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,6 +29,9 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
+
+OBJECT_FILES_NON_STANDARD_kuser32.o := y
+
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
-- 
2.17.1

