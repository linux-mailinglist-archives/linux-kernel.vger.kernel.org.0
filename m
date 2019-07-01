Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DF129C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfECITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 04:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfECITG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:19:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E735F300271F;
        Fri,  3 May 2019 08:19:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C10F1F6E6;
        Fri,  3 May 2019 08:19:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/12] perf script: Pad dso name for --call-trace
Date:   Fri,  3 May 2019 10:18:36 +0200
Message-Id: <20190503081841.1908-8-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
References: <20190503081841.1908-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 03 May 2019 08:19:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padding dso name for --call-trace so we don't have the
indent screwed by different dso name lengths, as now
for kernel there's also bpf code displayed.

  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
  # perf-core/perf-with-kcore script pt --call-trace

Before:
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                  kretprobe_perf_func
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                      trace_call_bpf
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                          __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                              __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_get_current_pid_tgid
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_ktime_get_ns
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])                                                      __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])                                                          __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     __htab_map_lookup_elem
           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms])                                                      memcmp
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                      probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                              check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                      probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                              check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_get_current_uid_gid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])                                                      from_kgid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])                                                      from_kuid
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                      perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                          perf_prepare_sample
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                              perf_misc_flags
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                                  __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                                      __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kvm])                                                                  kvm_is_in_guest
           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])                                                              __perf_event_header__init_id.isra.0
           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])                                                          perf_output_begin

After:
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                kretprobe_perf_func
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                    trace_call_bpf
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                            __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_pid_tgid
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_ktime_get_ns
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                    __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                __htab_map_lookup_elem
           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]                       )                                    memcmp
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_uid_gid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kgid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kuid
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                    perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                        perf_prepare_sample
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                            perf_misc_flags
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                    __x86_indirect_thunk_rax

Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index e08ee147eab4..149a15013b23 100644
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
+	i = vsnprintf(buf, size, fmt, args);
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
index ee71efb9db62..c3fbd6e556b0 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -405,6 +405,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 {
+	char buf[PATH_MAX];
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

