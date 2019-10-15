Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857DAD6C83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 02:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJOAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 20:34:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33261 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfJOAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:34:32 -0400
Received: by mail-pg1-f202.google.com with SMTP id f10so13817677pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b/tG0VRbZwIRSpjUHejoAWVOOXol4K25Gp7J8+effdA=;
        b=MQB0qKs44d/Pvy3R6ADgYbC9gY3ZJc5/yhPaHYvjQkQZDNz0UJJjEkrZ0JXHzwtaoS
         cFL9W4jBxERxzePcnwaCLW13NNmivC4/fhgbp3ZOrBWWfxQcjFMnyHw2ec+K/FVGjEqF
         rB0PlaOU1qzLNpEKB0aiQTdQMcrRLxV2WU/cCWiKRWws2ix21IuKyhVMGaT5T8QLFPf+
         lCYkYCuPUcJTg2BLqHB3M2UiI2uxbQ3YUAyFu02pGCEVwi/7vQ9R4SFYV2zyT5A/+D7I
         uuez8zdthuGGx5R0ZN60v+4ZHL9L93QcQoUTOpID3j90cM4M/gVMX6km7m+HYWeusD+M
         7EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b/tG0VRbZwIRSpjUHejoAWVOOXol4K25Gp7J8+effdA=;
        b=GC4Qv99a3KQpx/sTSLES+T6LzxN+/l3eWo6rV2zP04sBmLt5JG95qnMtIU+1kJsfQd
         rpTDkHjhvlJA2UIXukFUPcOq8otlsZg4AUHQy3/j1WBj1YUuBGROvRA0ADfEoO5dAbbB
         pb5CUx+hMYNBxLqLu6LbGUjSDGZt8t/4cPrnVRfHKFmaIzn9m6RDJxOO0PLWR2QSUMV0
         RfCtv3tE24zJfoUss69BbYy8DOu2FELactyVXymwuZ+yfHox5d2fRmWj/MRTJ+TTkCrA
         xgRUK/buMhaDFCdPBTynClSbziR9TOrmyvwgpuCDciYV9+Ho//tiNwksbG/W+PpH7jc9
         2xmA==
X-Gm-Message-State: APjAAAVlbseOBLp7aOLbDO6EC8nL3aA/K83a9yA2TrA1mwH4k/VA5awp
        LV8N5IFOkOB5J+I7mIW7sSPx6a/NhhNg
X-Google-Smtp-Source: APXvYqwq5ub3nOVDQbucdjsKOcWIGchSGp48AVqSORH/Sx57K5ycCq+AVtVrpe0p6Ohy/bkf8IN6oT/YD1Os
X-Received: by 2002:a63:e00e:: with SMTP id e14mr36318375pgh.146.1571099669732;
 Mon, 14 Oct 2019 17:34:29 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:34:18 -0700
Message-Id: <20191015003418.62563-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH] perf annotate: ensure objdump argv is NULL terminated
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide null termination.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f7c620e0099b..a9089e64046d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1921,6 +1921,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		NULL, /* Will be the objdump command to run. */
 		"--",
 		NULL, /* Will be the symfs path. */
+		NULL,
 	};
 	struct child_process objdump_process;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
-- 
2.23.0.700.g56cf767bdb-goog

