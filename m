Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86576836A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfHFQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:36310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfHFQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9793344;
        Tue,  6 Aug 2019 09:25:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F15AB3F575;
        Tue,  6 Aug 2019 09:25:44 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Gary R Hook <gary.hook@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] lib: remove redundant ftrace flag removal
Date:   Tue,  6 Aug 2019 17:25:39 +0100
Message-Id: <20190806162539.51918-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since architectures can implement ftrace using a variety of mechanisms,
generic code should always use CC_FLAGS_FTRACE rather than assuming that
ftrace is built using -pg.

Since commit:

  2464a609ded09420 ("ftrace: do not trace library functions")

... lib/Makefile has removed CC_FLAGS_FTRACE from KBUILD_CFLAGS, so ftrace is
disabled for all files under lib/.

Given that, we shouldn't explicitly remove -pg when building
lib/string.o, as this is redundant and bad form.

This patch cleans things up accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Gary R Hook <gary.hook@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 lib/Makefile | 4 ----
 1 file changed, 4 deletions(-)

I've verified this atop of v5.3-rc3, where the Makefile removes all of
CC_FLAGS_FTRACE (containing "-pg -mrecord-mcount -mfentry") from the CFLAGS for
building string.o

Mark.

diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..c5892807e06f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -21,10 +21,6 @@ KCOV_INSTRUMENT_dynamic_debug.o := n
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KASAN_SANITIZE_string.o := n
 
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_string.o = -pg
-endif
-
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
-- 
2.11.0

