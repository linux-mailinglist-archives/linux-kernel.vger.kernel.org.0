Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C203818DD7D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgCUBiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:38:46 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56147 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCUBip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:38:45 -0400
Received: by mail-pf1-f201.google.com with SMTP id 78so6029818pfy.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=koG0x0fUodpWtpVj+CIcSN6Y0DoNADEjEEo1rGt6J6c=;
        b=t1jCgyWI+GeRNmWoqxppM8hkRNxpnZf92QAkhqysrSZGlmQ2f3tm5PJ9IStzODgmb5
         rG0nNnKWThtpXjCVCDFoENvtg4n+zOIiFv+keHQ3MOaxH+WcmId7leb00wlau70rvQYl
         FLtPnFVx+8I2FDNe9ESwUCvO4m03FHY+iA6eJfWqvNDyADCuEoKTJ0q/iQgPnLBIL+DC
         2aItwjI32ExzivkgQCsAAB+4lDnEN6MPRdBLYdBgb7XU9GoqsYzqayWSdjoaChAPBsgi
         nVtgf/4PjDzFFTPREYsEt02IY9oT1zeKhCovK4/j4W0PW5yUhqZhKsUUJzV1tdJn30b7
         fP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=koG0x0fUodpWtpVj+CIcSN6Y0DoNADEjEEo1rGt6J6c=;
        b=gM8iNhlLavlBNQW8HTKzfnRSwiZK2/JAkiWRZzHaFVfhZgYcNujO6Y7Q0eFDtzsLQI
         PrkiT4iCqFuOVtTdbaKRMiPNpWvD9HTANuRXnVMYaXElp7BL9kjHYnMvD+d6255iBPJv
         hGBYImTa3Gn04SzFelRd+t4ZxtRu165nMa+92MOLecP2Feh3Qcw1fCRl9Ls2O4qlQ6t1
         mVPXeF2HuS5rU1+aEx2Cl0Os27ipw/bBzK+wSO7nwMAUvpsisrrwk+6vfO6cHSluH6sj
         CdzlxTW/lAy3xo7dp13PQC199vj4+dfAwVpX6HVVynpMbOAfYgCVifxoHZjQuV+kR6My
         iCyw==
X-Gm-Message-State: ANhLgQ0LuRSa8spj+yhfc4cjPy0UGMuKu+6ppIVVDArFThZFflsCVttR
        gmuN41pfOAMp2ayk1l6PhRiMb2pbsEaM
X-Google-Smtp-Source: ADFU+vuwIMZptgHXT0FLXLX5idQ25AxRfo2MVJZUWccTr9MY3v3Vmq8oYY6o2qUeVecfq2H45wm4ns73FBxZ
X-Received: by 2002:a63:7159:: with SMTP id b25mr2333688pgn.72.1584754724059;
 Fri, 20 Mar 2020 18:38:44 -0700 (PDT)
Date:   Fri, 20 Mar 2020 18:38:39 -0700
Message-Id: <20200321013839.197114-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf/cgroup: correct indirection in perf_less_group_idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void* in perf_less_group_idx is to a cell in the array which points
at a perf_event*, as such it is a perf_event**.

Fixes: 6eef8a7116de ("perf/core: Use min_heap in visit_groups_merge()")
Author: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d22e4ba59dfa..a758c2311c53 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3503,7 +3503,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 
 static bool perf_less_group_idx(const void *l, const void *r)
 {
-	const struct perf_event *le = l, *re = r;
+	const struct perf_event *le = *(const struct perf_event **)l;
+	const struct perf_event *re = *(const struct perf_event **)r;
 
 	return le->group_index < re->group_index;
 }
-- 
2.25.1.696.g5e7596f4ac-goog

