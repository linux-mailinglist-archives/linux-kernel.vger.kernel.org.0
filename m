Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C015063E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfFXJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:56:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfFXJ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6694C2B;
        Mon, 24 Jun 2019 02:56:31 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B893F71E;
        Mon, 24 Jun 2019 02:56:30 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 15/18] arm64: kernel: Add exception on kuser32 to prevent stack analysis
Date:   Mon, 24 Jun 2019 10:55:45 +0100
Message-Id: <20190624095548.8578-16-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
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
index 478491f07b4f..1239c7da4c02 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,6 +33,9 @@ ifneq ($(CONFIG_COMPAT_VDSO), y)
 obj-$(CONFIG_COMPAT)			+= sigreturn32.o
 endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
+
+OBJECT_FILES_NON_STANDARD_kuser32.o := y
+
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
-- 
2.17.1

