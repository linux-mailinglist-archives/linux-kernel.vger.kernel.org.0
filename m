Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E6F349F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfKGQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:28:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEBCB21D7B;
        Thu,  7 Nov 2019 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573144111;
        bh=T6knqOwXal34LnIfA5nt6uVCJnlkveu3OyC8sWPsSV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6QUNU051fril5rTRflTG3rHmk115Z28/OWmA+JqwpQUROvfJZ/cZEEdQORwBY6uG
         1JI7h31mi4tqxApsk/N5UbXWvduCXie2aMQA6t/kS+I2OmKtkPT36sj5rGEXlAZ9lh
         epk3US1OG5+Bra3kPvfrLMwLKo0lJFbzHdA6Bii0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 4/4] perf probe: Trace a magic number if variable is not found
Date:   Fri,  8 Nov 2019 01:28:27 +0900
Message-Id: <157314410722.4063.14592909606232027107.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157314406866.4063.16995747442215702109.stgit@devnote2>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace a magic number as immediate value if the target variable
is not found at some probe points which is based on one probe
event.

This feature is good for the case if you trace a source code
line with some local variables, which is compiled into several
instructions and some of the variables are optimized out on
some instructions. Even if so, with this feature, perf probe
trace a magic number instead of such disappeared variables and
fold those probes on one event.

E.g. without this patch,
# perf probe -D "pud_page_vaddr pud"
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
Failed to find 'pud' in this function.
p:probe/pud_page_vaddr _text+23480787 pud=%ax:x64
p:probe/pud_page_vaddr _text+23808453 pud=%bp:x64
p:probe/pud_page_vaddr _text+23558082 pud=%ax:x64
p:probe/pud_page_vaddr _text+328373 pud=%r8:x64
p:probe/pud_page_vaddr _text+348448 pud=%bx:x64
p:probe/pud_page_vaddr _text+23816818 pud=%bx:x64

With this patch,
# perf probe -D "pud_page_vaddr pud" | head
spurious_kernel_fault is blacklisted function, skip it.
vmalloc_fault is blacklisted function, skip it.
p:probe/pud_page_vaddr _text+23480787 pud=%ax:x64
p:probe/pud_page_vaddr _text+149051 pud=\deade12d:x64
p:probe/pud_page_vaddr _text+23808453 pud=%bp:x64
p:probe/pud_page_vaddr _text+315926 pud=\deade12d:x64
p:probe/pud_page_vaddr _text+23807209 pud=\deade12d:x64
p:probe/pud_page_vaddr _text+23557365 pud=%ax:x64
p:probe/pud_page_vaddr _text+314097 pud=%di:x64
p:probe/pud_page_vaddr _text+314015 pud=\deade12d:x64
p:probe/pud_page_vaddr _text+313893 pud=\deade12d:x64
p:probe/pud_page_vaddr _text+324083 pud=\deade12d:x64

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix not to check event name.
  - Update before/after example.
---
 tools/perf/util/probe-event.c  |    2 +
 tools/perf/util/probe-event.h  |    3 ++
 tools/perf/util/probe-finder.c |   62 +++++++++++++++++++++++++++++++++++++---
 tools/perf/util/probe-finder.h |    1 +
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8f963a193a5d..52b2d165453a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -46,7 +46,7 @@
 #define PERFPROBE_GROUP "probe"
 
 bool probe_event_dry_run;	/* Dry run flag */
-struct probe_conf probe_conf;
+struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
 
 #define semantic_error(msg ...) pr_err("Semantic error :" msg)
 
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 96a319cd2378..4f0eb3a20c36 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -16,10 +16,13 @@ struct probe_conf {
 	bool	no_inlines;
 	bool	cache;
 	int	max_probes;
+	unsigned long	magic_num;
 };
 extern struct probe_conf probe_conf;
 extern bool probe_event_dry_run;
 
+#define DEFAULT_PROBE_MAGIC_NUM	0xdeade12d	/* u32: 3735937325 */
+
 struct symbol;
 
 /* kprobe-tracer and uprobe-tracer tracing point */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2e3a468c8350..1bf3e0ccd83d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -536,6 +536,14 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		return 0;
 }
 
+static void print_var_not_found(const char *varname)
+{
+	pr_err("Failed to find the location of the '%s' variable at this address.\n"
+	       " Perhaps it has been optimized out.\n"
+	       " Use -V with the --range option to show '%s' location range.\n",
+		varname, varname);
+}
+
 /* Show a variables in kprobe event format */
 static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 {
@@ -547,11 +555,11 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 
 	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
 					&pf->sp_die, pf->machine, pf->tvar);
+	if (ret == -ENOENT && pf->skip_empty_arg)
+		/* This can be found in other place. skip it */
+		return 0;
 	if (ret == -ENOENT || ret == -EINVAL) {
-		pr_err("Failed to find the location of the '%s' variable at this address.\n"
-		       " Perhaps it has been optimized out.\n"
-		       " Use -V with the --range option to show '%s' location range.\n",
-		       pf->pvar->var, pf->pvar->var);
+		print_var_not_found(pf->pvar->var);
 	} else if (ret == -ENOTSUP)
 		pr_err("Sorry, we don't support this variable location yet.\n");
 	else if (ret == 0 && pf->pvar->field) {
@@ -598,6 +606,8 @@ static int find_variable(Dwarf_Die *sc_die, struct probe_finder *pf)
 		/* Search again in global variables */
 		if (!die_find_variable_at(&pf->cu_die, pf->pvar->var,
 						0, &vr_die)) {
+			if (pf->skip_empty_arg)
+				return 0;
 			pr_warning("Failed to find '%s' in this function.\n",
 				   pf->pvar->var);
 			ret = -ENOENT;
@@ -1348,6 +1358,44 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	return ret;
 }
 
+static int fill_empty_trace_arg(struct perf_probe_event *pev,
+				struct probe_trace_event *tevs, int ntevs)
+{
+	char **valp;
+	char *type;
+	int i, j, ret;
+
+	for (i = 0; i < pev->nargs; i++) {
+		type = NULL;
+		for (j = 0; j < ntevs; j++) {
+			if (tevs[j].args[i].value) {
+				type = tevs[j].args[i].type;
+				break;
+			}
+		}
+		if (j == ntevs) {
+			print_var_not_found(pev->args[i].var);
+			return -ENOENT;
+		}
+		for (j = 0; j < ntevs; j++) {
+			valp = &tevs[j].args[i].value;
+			if (*valp)
+				continue;
+
+			ret = asprintf(valp, "\\%lx", probe_conf.magic_num);
+			if (ret < 0)
+				return -ENOMEM;
+			/* Note that type can be NULL */
+			if (type) {
+				tevs[j].args[i].type = strdup(type);
+				if (!tevs[j].args[i].type)
+					return -ENOMEM;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Find probe_trace_events specified by perf_probe_event from debuginfo */
 int debuginfo__find_trace_events(struct debuginfo *dbg,
 				 struct perf_probe_event *pev,
@@ -1366,7 +1414,13 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	tf.tevs = *tevs;
 	tf.ntevs = 0;
 
+	if (pev->nargs != 0 && immediate_value_is_supported())
+		tf.pf.skip_empty_arg = true;
+
 	ret = debuginfo__find_probes(dbg, &tf.pf);
+	if (ret >= 0 && tf.pf.skip_empty_arg)
+		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
+
 	if (ret < 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 670c477bf8cf..11be10080613 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -87,6 +87,7 @@ struct probe_finder {
 	unsigned int		machine;	/* Target machine arch */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
 	struct probe_trace_arg	*tvar;		/* Current result variable */
+	bool			skip_empty_arg;	/* Skip non-exist args */
 };
 
 struct trace_event_finder {

