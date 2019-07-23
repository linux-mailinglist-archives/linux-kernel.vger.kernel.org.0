Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16CB72077
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfGWUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 16:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:06:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133A2229F6;
        Tue, 23 Jul 2019 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912391;
        bh=J4QDGPm/HqiSCuR1xHuJRjaQQzQhDnzCGrNpfv9LO+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uYEAUsBqS5uQ/7wbD2i2Z/yRoCmCXdtzo1U35ItmS0Z4xpc/AhcWqaNPSLm9aFhD
         9Ipj/Iq2OyrHt+nWX3250ot/awvWM++5TE7pWofIEomZjmVy3QmUpGfDBHAmDncNNz
         VCdeA402dLOfPWbYDIAZuxrQOcfFsCSJ7DI6o7Gc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/10] perf build: Do not use -Wshadow on gcc < 4.8
Date:   Tue, 23 Jul 2019 17:05:30 -0300
Message-Id: <20190723200530.14090-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is too strict, see https://lkml.org/lkml/2006/11/28/253 and
https://gcc.gnu.org/gcc-4.8/changes.html, that takes into account
Linus's comments (search for Wshadow) for the reasoning about -Wshadow
not being interesting before gcc 4.8.

Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190719183417.GQ3624@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.include | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 495066bafbe3..ded7a950dc40 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -32,7 +32,6 @@ EXTRA_WARNINGS += -Wno-system-headers
 EXTRA_WARNINGS += -Wold-style-definition
 EXTRA_WARNINGS += -Wpacked
 EXTRA_WARNINGS += -Wredundant-decls
-EXTRA_WARNINGS += -Wshadow
 EXTRA_WARNINGS += -Wstrict-prototypes
 EXTRA_WARNINGS += -Wswitch-default
 EXTRA_WARNINGS += -Wswitch-enum
@@ -69,8 +68,16 @@ endif
 # will do for now and keep the above -Wstrict-aliasing=3 in place
 # in newer systems.
 # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
+#
+# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
+# that takes into account Linus's comments (search for Wshadow) for the reasoning about
+# -Wshadow not being interesting before gcc 4.8.
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)  # make-3
 EXTRA_WARNINGS += -fno-strict-aliasing
+EXTRA_WARNINGS += -Wno-shadow
+else
+EXTRA_WARNINGS += -Wshadow
 endif
 
 ifneq ($(findstring $(MAKEFLAGS), w),w)
-- 
2.21.0

