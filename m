Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831E42DE86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfE2NiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfE2NiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:23 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC352231F;
        Wed, 29 May 2019 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137102;
        bh=j4lYpMw1GvyLvwBSK4RsFw4YjOPiVc+Rs1WSQkRVX8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axNAs9EhKocv4zYKaR1jdd0DcyMGqAQPI+UMc11tldn1d6cwwjXSlyEnQbxwpvS9t
         1LXJVqfafYVEg0Ds7BSsoNbzokB8l0UimcH1NZsrMb22KjAhfW13xu6dNRV4MCH+mJ
         BQ6olkkd+3046SSjTL/GMuv3bV7KTuZ1/Maes4Q0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 26/41] perf script: Pad DSO name for --call-trace
Date:   Wed, 29 May 2019 10:35:50 -0300
Message-Id: <20190529133605.21118-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pad the DSO name in --call-trace so we don't have the indent screwed by
different DSO name lengths, as now for kernel there's also BPF code
displayed.

  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
  # perf-core/perf-with-kcore script pt --call-trace

Before:

   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                      kretprobe_perf_func
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                          trace_call_bpf
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                              __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                                  __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_get_current_pid_tgid
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_ktime_get_ns
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms])                                          __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms])                                              __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         __htab_map_lookup_elem
   sleep 3660 [16] 57036.806465366: ([kernel.kallsyms])                                          memcmp
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                          probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                                  check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                          probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                                  check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_get_current_uid_gid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms])                                          from_kgid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms])                                          from_kuid
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                          perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                              perf_prepare_sample
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                  perf_misc_flags
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                      __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                          __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kvm])                                                      kvm_is_in_guest
   sleep 3660 [16] 57036.806466649: ([kernel.kallsyms])                                                  __perf_event_header__init_id.isra.0
   sleep 3660 [16] 57036.806466649: ([kernel.kallsyms])                                              perf_output_begin

After:

   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )     kretprobe_perf_func
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )         trace_call_bpf
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )             __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )                 __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_get_current_pid_tgid
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_ktime_get_ns
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms]                      )                         __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms]                      )                             __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     __htab_map_lookup_elem
   sleep 3660 [16] 57036.806465366: ([kernel.kallsyms]                      )                         memcmp
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                         probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                                 check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                         probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                                 check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_get_current_uid_gid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms]                      )                         from_kgid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms]                      )                         from_kuid
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                         perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                             perf_prepare_sample
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                 perf_misc_flags
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                     __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                         __x86_indirect_thunk_rax

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/kernel.h  |  1 +
 tools/lib/vsprintf.c          | 19 +++++++++++++++++++
 tools/perf/builtin-script.c   |  1 +
 tools/perf/util/map.c         |  6 ++++++
 tools/perf/util/symbol_conf.h |  1 +
 5 files changed, 28 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 857d9e22826e..cba226948a0c 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -102,6 +102,7 @@
 
 int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 int scnprintf(char * buf, size_t size, const char * fmt, ...);
+int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
index e08ee147eab4..8780b4cdab21 100644
--- a/tools/lib/vsprintf.c
+++ b/tools/lib/vsprintf.c
@@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...)
 
        return (i >= ssize) ? (ssize - 1) : i;
 }
+
+int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
+{
+	ssize_t ssize = size;
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vscnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	if (i < (int) size) {
+		for (; i < (int) size; i++)
+			buf[i] = ' ';
+		buf[i] = 0x0;
+	}
+
+	return (i >= ssize) ? (ssize - 1) : i;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 61cfd8f70989..7adaa6c63a0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3297,6 +3297,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
 	itrace_parse_synth_opts(opt, "cewp", 0);
 	symbol_conf.nanosecs = true;
+	symbol_conf.pad_output_len_dso = 50;
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ee71efb9db62..6fce983c6115 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -405,6 +405,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 {
+	char buf[symbol_conf.pad_output_len_dso + 1];
 	const char *dsoname = "[unknown]";
 
 	if (map && map->dso) {
@@ -414,6 +415,11 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 			dsoname = map->dso->name;
 	}
 
+	if (symbol_conf.pad_output_len_dso) {
+		scnprintf_pad(buf, symbol_conf.pad_output_len_dso, "%s", dsoname);
+		dsoname = buf;
+	}
+
 	return fprintf(fp, "%s", dsoname);
 }
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 6c55fa6fccec..382ba63fc554 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -69,6 +69,7 @@ struct symbol_conf {
 			*tid_list;
 	const char	*symfs;
 	int		res_sample;
+	int		pad_output_len_dso;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.20.1

