Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE63017F5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCJLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCJLQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B809624691;
        Tue, 10 Mar 2020 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838973;
        bh=eQAKiMa7qGcpy9qc02RUYOUUHYsEqcjBh8ajoMODSSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbMdB9zJ5Q3XVc6b8ylR/QB8ULYBFjWHZ/gMLfLWSRZ24yV73kXTbImnij4vS8e+a
         wGQ384VeCWumgN/q3ELo6GKl4Fgik2udk03wJZw3TPJ4cSI2fIfK9y49dzaPvzNxgv
         EqvOrs8GJLeUTfc4PhyUekIi1iiqsdG5Bp7lnDKE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/19] perf annotate: Get rid of annotation->nr_jumps
Date:   Tue, 10 Mar 2020 08:15:36 -0300
Message-Id: <20200310111551.25160-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

The 'nr_jumps' field in 'struct annotation' is not used since it's
inception in commit 2402e4a936a0 ("perf annotate browser: Show 'jumpy'
functions").  Get rid of it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-7-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 --
 tools/perf/util/annotate.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0ea95be84b3b..f1ea0d61eb5b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2611,8 +2611,6 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 
 		if (++al->jump_sources > notes->max_jump_sources)
 			notes->max_jump_sources = al->jump_sources;
-
-		++notes->nr_jumps;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 001258601a37..07c775938d46 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -279,7 +279,6 @@ struct annotation {
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
-	int			nr_jumps;
 	int			max_jump_sources;
 	int			nr_entries;
 	int			nr_asm_entries;
-- 
2.21.1

