Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6351928CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:45:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:45:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so984275pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teK3a3LWLbiCQvpK9qs2ncAfoeKO94eKFIg30BzrSyM=;
        b=ILo1owntRQGEMsa25xc7zx6T8apvdzzAcR42O71/aYJA9od9NE8r4MHHG8+2la3ZM8
         rftLgbhNAU0onxwNId1INoYgrFiTD4rb8n0ZkW4l/kcNV2CX34rPo3HTenTQG9FP179c
         Wwh5ErFy68YYRWfS4rOA7ePtLpSK037tBK7YBlOdQM689kX8H8/DHjB8UCMXSN9ae2Gn
         2Hr5oNp9yROxqoqRDdW2PYn0oETO6x30Tflt7XtEeBEQRaJWtuJz9DcA9rtGzMayq6GW
         y6Hsy4dYT1hGk4eNrWwrSskUbyotOH5+gPDfMF08RbDujI6z4jtXSBpii18J/4sf0iqh
         bQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=teK3a3LWLbiCQvpK9qs2ncAfoeKO94eKFIg30BzrSyM=;
        b=aizsUhf3OodL3elsFbdtEc/K88hsGL4WcCXTlQZ8Y5UL17oRLcK9JPCEXNI8jVQFhc
         JlalUdxJMomOjubJIpi+9aqfDGWIBc5AsxHhUwEtdJO1YAGxWPnDrS3XSytWwurluBNq
         /t/skY/rjR25cDgoHpH9G+GJgM5GwC8VX2bIvUPllCAblWFLQLc0AsLANQX76Rrub9mo
         dQJTTnuaQylcUWRC3JxVPDUIbsGmkTSzCbD+Sn0j9PT8Hppr5nCCIXLbmcC+nSHopp9H
         JJ3V5G5OUFzTkbF74dGwDCWbKFQ5JPIhmpFRnKqLFHuyu9Skb8DA3gNoOlXGMasSm15F
         XQhQ==
X-Gm-Message-State: ANhLgQ06Lqs0AZvWBecAaCzmTJxv0c3n4XKuTejLAzoVF6sreEbtrwbQ
        9jwnK9XRVwW1aAYcv9svr/I=
X-Google-Smtp-Source: ADFU+vun6NJwBNZOhMjrXJbZyvj5gJevWdPKspiMlzWFBsIQiGnAIjkqOfh0MAVs9hS3PKTa4W94fw==
X-Received: by 2002:a62:30c6:: with SMTP id w189mr3286656pfw.257.1585140356582;
        Wed, 25 Mar 2020 05:45:56 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:45:55 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH 3/9] perf tools: Basic support for CGROUP event
Date:   Wed, 25 Mar 2020 21:45:30 +0900
Message-Id: <20200325124536.2800725-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement basic functionality to support cgroup tracking.  Each cgroup
can be identified by inode number which can be read from userspace
too.  The actual cgroup processing will come in the later patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
[fix perf test failure on sampling parsing]
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h     | 16 ++++++++++++++--
 tools/lib/perf/include/perf/event.h       |  7 +++++++
 tools/perf/builtin-diff.c                 |  1 +
 tools/perf/builtin-report.c               |  1 +
 tools/perf/tests/sample-parsing.c         |  6 +++++-
 tools/perf/util/event.c                   | 18 ++++++++++++++++++
 tools/perf/util/event.h                   |  6 ++++++
 tools/perf/util/evsel.c                   |  6 ++++++
 tools/perf/util/machine.c                 | 12 ++++++++++++
 tools/perf/util/machine.h                 |  3 +++
 tools/perf/util/perf_event_attr_fprintf.c |  2 ++
 tools/perf/util/session.c                 |  4 ++++
 tools/perf/util/synthetic-events.c        |  8 ++++++++
 tools/perf/util/tool.h                    |  1 +
 14 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 397cfd65b3fe..7b2d6fc9e6ed 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -381,7 +382,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1012,6 +1014,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 18106899cb4e..69b44d2cc0f5 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -105,6 +105,12 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_cgroup {
+	struct perf_event_header header;
+	__u64			 id;
+	char			 path[PATH_MAX];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -352,6 +358,7 @@ union perf_event {
 	struct perf_record_mmap2		mmap2;
 	struct perf_record_comm			comm;
 	struct perf_record_namespaces		namespaces;
+	struct perf_record_cgroup		cgroup;
 	struct perf_record_fork			fork;
 	struct perf_record_lost			lost;
 	struct perf_record_lost_samples		lost_samples;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5e697cd2224a..c94a002f295e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -455,6 +455,7 @@ static struct perf_diff pdiff = {
 		.fork	= perf_event__process_fork,
 		.lost	= perf_event__process_lost,
 		.namespaces = perf_event__process_namespaces,
+		.cgroup = perf_event__process_cgroup,
 		.ordered_events = true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ea673b7eb3f4..26d8fc27e427 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1105,6 +1105,7 @@ int cmd_report(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.lost		 = perf_event__process_lost,
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 14239e472187..61865699c3f4 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -151,6 +151,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_CGROUP)
+		COMP(cgroup);
+
 	if (type & PERF_SAMPLE_AUX) {
 		COMP(aux_sample.size);
 		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
@@ -230,6 +233,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.regs	= regs,
 		},
 		.phys_addr	= 113,
+		.cgroup		= 114,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -336,7 +340,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_AUX << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CGROUP << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c5447ff516a2..824c038e5c33 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -54,6 +54,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
+	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -180,6 +181,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
 	return ret;
 }
 
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
+		       event->cgroup.id, event->cgroup.path);
+}
+
 int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -196,6 +203,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
 	return machine__process_namespaces_event(machine, event, sample);
 }
 
+int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	return machine__process_cgroup_event(machine, event, sample);
+}
+
 int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -417,6 +432,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_NAMESPACES:
 		ret += perf_event__fprintf_namespaces(event, fp);
 		break;
+	case PERF_RECORD_CGROUP:
+		ret += perf_event__fprintf_cgroup(event, fp);
+		break;
 	case PERF_RECORD_MMAP2:
 		ret += perf_event__fprintf_mmap2(event, fp);
 		break;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 3cda40a2fafc..b8289f160f07 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -135,6 +135,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
@@ -322,6 +323,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine);
+int perf_event__process_cgroup(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 int perf_event__process_mmap(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -377,6 +382,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 15ccd193483f..b766eb608b97 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2267,6 +2267,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->cgroup = 0;
+	if (type & PERF_SAMPLE_CGROUP) {
+		data->cgroup = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fd14f1489802..399b4731b246 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -654,6 +654,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
+int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cgroup(event, stdout);
+
+	return 0;
+}
+
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
@@ -1878,6 +1888,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_mmap_event(machine, event, sample); break;
 	case PERF_RECORD_NAMESPACES:
 		ret = machine__process_namespaces_event(machine, event, sample); break;
+	case PERF_RECORD_CGROUP:
+		ret = machine__process_cgroup_event(machine, event, sample); break;
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index be0a930eca89..fa1be9ea00fa 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -128,6 +128,9 @@ int machine__process_switch_event(struct machine *machine,
 int machine__process_namespaces_event(struct machine *machine,
 				      union perf_event *event,
 				      struct perf_sample *sample);
+int machine__process_cgroup_event(struct machine *machine,
+				  union perf_event *event,
+				  struct perf_sample *sample);
 int machine__process_mmap_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 355d3458d4e6..b94fa07f5d32 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,6 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
+		bit_name(CGROUP),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -132,6 +133,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
+	PRINT_ATTRf(cgroup, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 055b00abd56d..0b0bfe5bef17 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -471,6 +471,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->comm = process_event_stub;
 	if (tool->namespaces == NULL)
 		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
 	if (tool->fork == NULL)
 		tool->fork = process_event_stub;
 	if (tool->exit == NULL)
@@ -1436,6 +1438,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
+	case PERF_RECORD_CGROUP:
+		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
 		return tool->fork(tool, event, sample, machine);
 	case PERF_RECORD_EXIT:
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3f28af39f9c6..f72d80999506 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1230,6 +1230,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CGROUP)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1404,6 +1407,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_CGROUP) {
+		*array = sample->cgroup;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2abbf668b8de..472ef5eb4068 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -46,6 +46,7 @@ struct perf_tool {
 			mmap2,
 			comm,
 			namespaces,
+			cgroup,
 			fork,
 			exit,
 			lost,
-- 
2.25.1.696.g5e7596f4ac-goog

