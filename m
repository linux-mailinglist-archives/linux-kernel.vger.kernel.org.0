Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA615F68F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbgBNTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbgBNTMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:35 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A7222314;
        Fri, 14 Feb 2020 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707555;
        bh=RLp2LM3sQsxUER3OJE4Jk4jIV6aqM/HY1jaZJxzQHdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPaL8zN7X2Gmzdg8bed4oG7GzGYQXwcK0fdJLsKWlWg91TjNAuBZ14LFX9oreSgtg
         nF2WdpbLSr3ljXejJellaJow/vjmpjduEBhm+g7dvPPXz72E3VBjzn04O2wAfcD6KO
         Ksou1h7wz19TVNsA9wG4iACzdSoBi2SPRkNhXvXU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 17/23] tools headers UAPI: Sync asm-generic/mman-common.h with the kernel
Date:   Fri, 14 Feb 2020 16:10:51 -0300
Message-Id: <20200214191057.26266-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  d41938d2cbee ("mm: Reserve asm-generic prot flags 0x10 and 0x20 for arch use")

No changes in tooling, just a rebuild as files needed got touched.

This addresses the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index c160a5354eb6..f94f65d429be 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,8 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+/*			0x10		   reserved for arch-specific use */
+/*			0x20		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-- 
2.21.1

