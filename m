Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914AEE5356
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfJYSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:09:12 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53187 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbfJYSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id u12so2499083pfn.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8AHd3HYchFy/HqRZwIHZe+ZvKQYWtBTSUbJ/l//sqzk=;
        b=VreoqVn1XaiXPvtcxm+rBDixfWIMnp8gLxhWjAxWBTyg0dAyIcfBVL/7cWZ6ogIL3F
         pGRI5NqEySO5BH0uzaZ1vOSh5pvs8x1JEcp7YIP71NZpfB49TQQHy+/xCOo0oLe4mn1F
         ReLkEtXHfUU7iFhe4gktadIys+QMc8NwdUCBAWvx4zoF07YNr2xhfONUpJ7nLxysA+G6
         9BGXXjySEBHROHbvnscwMCPHcgdx5KczMYUvs/7nkweWLJYYpokaRP2KSHP0c8fM7CDs
         HYv8DgqFXz26v7SPh1NZi5yg6VtZtS8UvWIKSll/Cq/U7/ZhiZkWWquKJDrF9BQQ1TKF
         fm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8AHd3HYchFy/HqRZwIHZe+ZvKQYWtBTSUbJ/l//sqzk=;
        b=LXx/jAU4vxWzPhgmF7r9klxc2PsgOsMYBD66ZwP55fd3ZMionbA7pmuHHFvg0QzUGy
         /NQn69gPstaKwnTz7HqiZOCXy+D+r0eJ9jTcy0iSzDiUrwaswX8jXHYBeUVCmT+Zs15o
         RXg1mNMBY/h6hsNrban9QYCJBBjAAOqPARobwvN/0oltd/stOIFYBjwhIVSSYJftxbHN
         Cgzf4bCqG3J0XoetU9MTGfxPKXVTKN0107mJt6a2wUMcfpW1HS2Qz5R5r+h4OsXPG33x
         bP6nJSOMQ6QUsP2fSJw6edSuXqWeNiwrPb85AJT7SuiAkCM/jjyG0C6hKCJCm0jiIVCF
         XmOA==
X-Gm-Message-State: APjAAAVyMkPns6qDwvFJMLa5jjyHTIw62eD3GughTukggT6G/LSPWBgB
        IDNAnHsA3DgyutANe7onuqpQfVNKHUd/
X-Google-Smtp-Source: APXvYqy6/LK5TlIh+s/6IHlmfMBBm1ODbouvMiu0CW009V2OWRdTJ10R53vwgqJ2X50mrzOzGB9J3j/oENyR
X-Received: by 2002:a63:5762:: with SMTP id h34mr6120881pgm.235.1572026929070;
 Fri, 25 Oct 2019 11:08:49 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:23 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191025180827.191916-6-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com> <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 5/9] perf tools: ensure config and str in terms are unique
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

Make it easier to release memory associated with parse event terms by
duplicating the string for the config name and ensuring the val string
is a duplicate.

Currently the parser may memory leak terms and this is addressed in a
later patch.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 51 ++++++++++++++++++++++++++++------
 tools/perf/util/parse-events.y |  4 ++-
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4c4c6f3e866a..fb6436a74869 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1414,7 +1414,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head **listp)
 {
-	struct list_head *head;
 	struct parse_events_term *term;
 	struct list_head *list;
 	struct perf_pmu *pmu = NULL;
@@ -1431,19 +1430,30 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
+				struct list_head *head;
+				char *config;
+
 				head = malloc(sizeof(struct list_head));
 				if (!head)
 					return -1;
 				INIT_LIST_HEAD(head);
-				if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-							   str, 1, false, &str, NULL) < 0)
+				config = strdup(str);
+				if (!config)
+					return -1;
+				if (parse_events_term__num(&term,
+						   PARSE_EVENTS__TERM_TYPE_USER,
+						   config, 1, false, &config,
+						   NULL) < 0) {
+					free(list);
+					free(config);
 					return -1;
+				}
 				list_add_tail(&term->list, head);
 
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, head,
 							  true, true)) {
-					pr_debug("%s -> %s/%s/\n", str,
+					pr_debug("%s -> %s/%s/\n", config,
 						 pmu->name, alias->str);
 					ok++;
 				}
@@ -1452,8 +1462,10 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			}
 		}
 	}
-	if (!ok)
+	if (!ok) {
+		free(list);
 		return -1;
+	}
 	*listp = list;
 	return 0;
 }
@@ -2748,30 +2760,51 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 			      char *config, unsigned idx)
 {
 	struct event_symbol *sym;
+	char *str;
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-		.config    = config ?: (char *) "event",
+		.config    = config,
 	};
 
+	if (!temp.config) {
+		temp.config = strdup("event");
+		if (!temp.config)
+			return -ENOMEM;
+	}
 	BUG_ON(idx >= PERF_COUNT_HW_MAX);
 	sym = &event_symbols_hw[idx];
 
-	return new_term(term, &temp, (char *) sym->symbol, 0);
+	str = strdup(sym->symbol);
+	if (!str)
+		return -ENOMEM;
+	return new_term(term, &temp, str, 0);
 }
 
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
+	char *str;
 	struct parse_events_term temp = {
 		.type_val  = term->type_val,
 		.type_term = term->type_term,
-		.config    = term->config,
+		.config    = NULL,
 		.err_term  = term->err_term,
 		.err_val   = term->err_val,
 	};
 
-	return new_term(new, &temp, term->val.str, term->val.num);
+	if (term->config) {
+		temp.config = strdup(term->config);
+		if (!temp.config)
+			return -ENOMEM;
+	}
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+		return new_term(new, &temp, NULL, term->val.num);
+
+	str = strdup(term->val.str);
+	if (!str)
+		return -ENOMEM;
+	return new_term(new, &temp, str, 0);
 }
 
 int parse_events_copy_term_list(struct list_head *old,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index ffa1a1b63796..545ab7cefc20 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -665,9 +665,11 @@ PE_NAME array '=' PE_VALUE
 PE_DRV_CFG_TERM
 {
 	struct parse_events_term *term;
+	char *config = strdup($1);
 
+	ABORT_ON(!config);
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					$1, $1, &@1, NULL));
+					config, $1, &@1, NULL));
 	$$ = term;
 }
 
-- 
2.24.0.rc0.303.g954a862665-goog

