Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140DB1327C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgAGNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:35:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55748 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgAGNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so9029096pjz.5;
        Tue, 07 Jan 2020 05:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePgxXkR2iu9tRJM2FK4wl4gl+RESHBuYHRa00y0NfS0=;
        b=L1yETiX2bhl9F5h7KUJusUeIuCMSWkZ5x5JUmhVHl6OQRMlqXnTMr24MDSUT2Vs2eC
         m0Jo/jL/yMCrAMG6cJkkI4xkvPw3E9i47CIPZmjAnEhnwxLmRkue6YAfUbnbPscU9HxR
         8RmW0Lifu9mQ//JyI3VEu38U0fVYGsS4b3haX4ymmDhEB4Leay9YvH0zhjTidj7PgJ+j
         0odrvfddtytXRZmR4XzXP4K7ydV5RSeBoaIAMoZe7DX5aR+eAHNuH0sdl4UUhx6nmrvT
         qpNWz7slWCbZWFuP5Q+FKZ69SNGhqkerHFrZks1SbKzhQwVzgXZs5g/v9SVXsif5gbX1
         EYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ePgxXkR2iu9tRJM2FK4wl4gl+RESHBuYHRa00y0NfS0=;
        b=WYlzgMf1lm9umkqX7QLr/X3Wv1MdhHah4+DvFD4FfQIwtfHpto1ypTS7auv9bhy9Dk
         SSVwBRIaj9/0QI3lLe8TJNB4GxupcEbssuoDOMvSSBbT5vlHv4nss+S4iqV6GvO8N3S4
         0dHWhu+d6CS7HcI3nA3rDYXt24YXHYm3aeXMFVYXPOqTUYZfFa0cVUb4H0txDAi2Wfkx
         gGKKsYotHiDld6Hh/9NdgruVAXe7aS7mjrMaNLO1JQHFtz8xO9hbVlXrGciLMJe0inY7
         p3m6aJd4XcjroujndJVxhVazm6ZjrnQ4UTT6PQB3id4WMB0o/Yk6zcldFpltdfPOTWsp
         42JA==
X-Gm-Message-State: APjAAAVvsl7uy1qEll4Wft6wczJTsEa9zOpWQUsZmW62rZcFdzqHacgu
        85gPlxvi45xkbK5zaP/CVtg=
X-Google-Smtp-Source: APXvYqx6tVqHu3Q71aTK9fZasVN/x0CaCNqZhDvvYGEVvc2xwlMyYMujRh3+C+sMHDb+xpD9hxRIqQ==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr50709560pjv.15.1578404151672;
        Tue, 07 Jan 2020 05:35:51 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p17sm80358484pfn.31.2020.01.07.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:35:51 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 8/9] perf top: Add --all-cgroups option
Date:   Tue,  7 Jan 2020 22:35:00 +0900
Message-Id: <20200107133501.327117-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..c75507f50071 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -266,6 +266,10 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--cgroup::
+	Record events of type PERF_RECORD_CGROUP and display it with the
+	'cgroup' sort key.
+
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 795e353de095..f6256c533b09 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
 	if (ret < 0)
 		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
+	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
+					     &top->session->machines.host);
+	if (ret < 0)
+		pr_debug("Couldn't synthesize cgroup events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
@@ -1539,6 +1546,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.24.1.735.g03f4e72817-goog

