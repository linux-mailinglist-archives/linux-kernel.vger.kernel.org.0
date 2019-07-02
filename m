Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21F25C756
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGBC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfGBC1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118B72173E;
        Tue,  2 Jul 2019 02:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034439;
        bh=niY7EnZgcoeF2K5OsTL9dDqBq9YwENercYi6BxL91Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFcrmmyuDrZ62O4aIwHMPR2FH1oL3GiJadv6L1r/EvTsDmwklRuSHmYU5O8ETm5Uf
         vU2ZPUhREMlvjrmoVEGZDTEfVsDLTuaCNpNcgCJ7uHOuJ5UVfXqH1KQNsedCqUEteD
         ed7+v86F9GcebFmUsc8ElzxMJepmnV5ZcXSlcUOE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/43] perf symbols: We need util.h in symbol-elf.c for zfree()
Date:   Mon,  1 Jul 2019 23:25:51 -0300
Message-Id: <20190702022616.1259-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Continuing to untangle the headers, we're about to remove the old odd
baggage that is tools/perf/util/include/linux/ctype.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gapezcq3p8bzrsi96vdtq0o0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fdc5bd7dbb90..f04ef851ae86 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -14,6 +14,7 @@
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
+#include "util.h"
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
 
-- 
2.20.1

