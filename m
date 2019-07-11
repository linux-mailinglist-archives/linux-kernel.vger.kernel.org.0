Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01FC64DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfGJUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 16:45:47 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33141 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJUpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:45:46 -0400
Received: by mail-qk1-f202.google.com with SMTP id t196so3152796qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+aJnbxuhP1ajpM405sn4RetQfqn/0UdFgMvQqNBLg9o=;
        b=wG16zRvnjhY8WYd+1C7kAG69j3ZTc/YNweGHhhD+aFvJc7dRFyoDuABJCk7zi1Rq3r
         tCQ6WBbU4WplKIed2xz0HEF7OY+nfn6XeMRz6x/fPTHgV/5sXMjxtlRCzS3dzSxoiPuK
         beB/K5UNOax2CVmsphjf1eetc2/UpzK/FhJvVA89r4CSWHkWEFUzRmoWEsMHHHPnwfl8
         euywn+8HEVY0wnHeCuIvzD8ZLpUsRD4hc9dny/S2qe+uuceQwUeYHJx9+NZ46dsY+35X
         eeX95huBnI8dtITOvIgUOq9nsPC8Hyy0PJvAlTMVs8kQxM2a6raDl/BMZeQxZm6YGs2/
         h2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+aJnbxuhP1ajpM405sn4RetQfqn/0UdFgMvQqNBLg9o=;
        b=rG6RpykD16xMcaFClSoVAKu9I6G+KcAz2/+QmrLL0OZiV7XsLG/cJjp+Nne7OzK5ty
         ZUK1wjlBAskhWZpAdLCNhtCSEMJg26bupLHWYcPU4a3Ec8o5otJTiNCkv30ay/gybXTb
         JR1hNptLny3j+qQZqActZpu4+xIxHBsrokOQm+i3Cux1lrv2jKwfE3zoVXy+a7QXlbxo
         Fh5gdGi/JAWxgDu5vt5zFcKi/v74LedlwvGOgEv7ApFw7WiuhnhwM/+CW9fOC61XIlio
         EPkFKNArUsmro4d+bbjzLj348FQGt3En4/yq0k8dUYYzRTX8clAS7YQnj1hV+bE/okpE
         YYGg==
X-Gm-Message-State: APjAAAW63YoHMMiIkHCvBZEMu9GuEA6q0YOPZHSsSu2gPVMIWNfCAYuW
        FLquyEUwxwlzUBVUqGl7ndVHfRxK
X-Google-Smtp-Source: APXvYqy7DBfLrVPZVWRhf3GSvhr12oOVokaZnW+6jmRIi3L4yk/iQ9/1FL98QF9mdNTQYTdASWtucn2A
X-Received: by 2002:aed:3b9c:: with SMTP id r28mr25130819qte.74.1562791544953;
 Wed, 10 Jul 2019 13:45:44 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:45:40 -0700
Message-Id: <20190710204540.176495-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] Fix perf stat repeat segfault
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf stat is called with event groups and the repeat option,
a segfault occurs because the cpu ids are stored on each iteration
of the repeat, when they should only be stored on the first iteration,
which causes a buffer overflow.

This can be replicated by running (from the tip directory):

make -C tools/perf

then running:

tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls

Since run_idx keeps track of the current iteration of the repeat,
only storing the cpu ids on the first iteration (when run_idx < 1)
fixes this issue.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..92d6694367e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct perf_evsel *counter)
+static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
 {
-	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
+	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID
+		&& run_idx < 1;
 }
 
 static bool is_target_alive(struct target *_target,
@@ -503,7 +504,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
-		if (perf_evsel__should_store_id(counter) &&
+		if (perf_evsel__should_store_id(counter, run_idx) &&
 		    perf_evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

