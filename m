Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2770790
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfGVRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfGVRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:23 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8763B21901;
        Mon, 22 Jul 2019 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817162;
        bh=5LkOgcPDaLCwL5UVlzn70Wlc+nI4zLnqaopdl77+VnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PM9jGfr7QDFj6nn6N73X+7gD5uE7V4YDQdZrr/C77Ly08okqCZ2PVwJriLeWAJHqZ
         ADB/JuCJqEab7h1m4Pm94gRGSbMexdzoxLSjTPVdv0OfmK09LvhrMspIs4ic3IDWGY
         Vp/HPfmhraonqCmtuHr20g78EqdIfhRfMnwuX5wg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 04/37] perf trace: Add pointer to BPF object containing __augmented_syscalls__
Date:   Mon, 22 Jul 2019 14:38:06 -0300
Message-Id: <20190722173839.22898-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it when looking for other components of that object
file, such as other programs to add to the BPF_MAP_TYPE_PROG_ARRAY and
use with bpf_tail_call().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1ibmz7ouv6llqxajy7m8igtd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4f0bbffee05f..6aa080845a84 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -96,6 +96,7 @@ struct trace {
 	struct perf_evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
+	struct bpf_object	*bpf_obj;
 	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
@@ -3895,6 +3896,20 @@ int cmd_trace(int argc, const char **argv)
 
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+
+		evsel = perf_evlist__find_tracepoint_by_name(trace.evlist, "raw_syscalls:sys_enter");
+		if (evsel == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not found in the augmented BPF object\n");
+			goto out;
+		}
+
+		if (evsel->bpf_obj == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not associated to a BPF object\n");
+			goto out;
+		}
+
+		trace.bpf_obj = evsel->bpf_obj;
+
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
 	}
-- 
2.21.0

