Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAF5E632
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGCONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:13:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:13:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EDP1c3322279
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:13:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EDP1c3322279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163206;
        bh=mWzQE7WR778LqqE4/+Qb8nEIFTAAIWeQf0Ijx5ZzrUg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=WZT1TVr2GNH82UkbMk0LzuSA+Izlp96nVRd1yGbgjwquZYGbjF7WdDabo0tY3FK4W
         8VZDQWasrLDUM8SEY/1A41uvGfEK6aXVE1wRFJ1UA39VlyrOrPHH8izClAPPgyn9tF
         xDCF0FB0X0MtINh9G8O+mThVMYqVlrZ5aYBqgbyuhjeeh+BlEX1DU6Y+O4ZtSOcfvd
         aWWrwvheU3LX5kkLwAd83AQVnWLE4yvWCb59P4k1gGyRUDw8iuWHtefHTV2tbuCIqB
         jxoLhXYMuSEgolEe/QqRd0D+QDaT00La/feoPJfy4eU7y30uF676V34AJCxOArBbr7
         hEN1HFR/CIwHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EDPjJ3322276;
        Wed, 3 Jul 2019 07:13:25 -0700
Date:   Wed, 3 Jul 2019 07:13:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-gapezcq3p8bzrsi96vdtq0o0@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, mingo@kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: We need util.h in symbol-elf.c for
 zfree()
Git-Commit-ID: cf8b6970f4fc31898f3d9e25159aa57e235ca4d1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cf8b6970f4fc31898f3d9e25159aa57e235ca4d1
Gitweb:     https://git.kernel.org/tip/cf8b6970f4fc31898f3d9e25159aa57e235ca4d1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 18:15:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 18:31:06 -0300

perf symbols: We need util.h in symbol-elf.c for zfree()

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
 
