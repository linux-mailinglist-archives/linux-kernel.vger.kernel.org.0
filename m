Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA59FE536B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfJYSJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:09:40 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41485 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbfJYSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id 22so2515096pfx.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/dDefoMM36PIRowlZl2Nw9qTsavoFN0b32BVnZFbmdI=;
        b=TE1I8ODdeGw+jnNWUNRzlklwmv17c6qrzXQrVdbHJnOnzIpNP0LmYLw3sMjAXxQAb9
         CHWFQLhifF4aJbuSeqjIAHMuTV0SNZIzVTNtVMA2/nObkoSQcT58Aqhhb51ZeKfMaZZJ
         iqipyyZjhwmdUteNYMnEZdiB1kBhdMerdQGJAhOs+tnM8seYIWZah0MT65eZBsQPrlz7
         wjsWgKm+bdrGyKT6sSCuUgcxroefjWKXAhhNGLBFlCLovRUfZRxpPjckVmvgQtEKr763
         VwjMWrK3ShE1+09qVTaNr2GMbY8/lQMjhruFBaU1xF0QJ/ywB6QauIkj48oAvU5y81jk
         s51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/dDefoMM36PIRowlZl2Nw9qTsavoFN0b32BVnZFbmdI=;
        b=IA6yPAphdbQQJp5wVWNvw/hy28aOXq4luokPIcmiqj4pW+VxM6Uu+lyKK9YoEYnrsi
         tQUDKclmEqaG6VkzjOIglwtkMcv/Vsa0iDoUEkbsd5/j2jUPTP2naDd+tf3yhpuV9M73
         xEUJ7A/+BaId7J/otTh2UA8tjleIi5ODDXmIvQ55plwsaoqwjh6IhyoKrXnLF/Y/uzT2
         dAx83usnZAqGjqz96b9hGtsAiCuvmJ11L7FLqaRXafClpegcsVi9w18IkVVk1b4Ohd+X
         6vG38RWEHVlWYnJhW+KBcBt8hJ++VOUPWtd2cRj3eJoK4vlLHqboXX7csbGnwUjbUc+X
         aKDw==
X-Gm-Message-State: APjAAAXmm1iQ+mSf0NHDQznQIpnugGK8662s3AA/G4W8DnJR7I2MkeRr
        UrWJVFfMOEe+vhpybAF8WUVsziMXAE2M
X-Google-Smtp-Source: APXvYqzIYA9d/vGzxB2esIdYemJ0Oq68o8ieY6t+zqP7n9k/G/llUi72E8BavQN495zkdxVZgQ7xf0PS/Bxl
X-Received: by 2002:a63:5d18:: with SMTP id r24mr1468551pgb.53.1572026936817;
 Fri, 25 Oct 2019 11:08:56 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:26 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191025180827.191916-9-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com> <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 8/9] perf tools: if pmu configuration fails free terms
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a memory leak when the configuration fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fb6436a74869..3db1b647db38 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1390,8 +1390,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
-	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error))
+	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+		struct perf_evsel_config_term *pos, *tmp;
+
+		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
+			list_del_init(&pos->list);
+			free(pos);
+		}
 		return -EINVAL;
+	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr,
 			    get_config_name(head_config), pmu,
-- 
2.24.0.rc0.303.g954a862665-goog

