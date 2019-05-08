Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D350617A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfEHNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 09:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfEHNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50F07307E053;
        Wed,  8 May 2019 13:20:32 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8F051018A2A;
        Wed,  8 May 2019 13:20:29 +0000 (UTC)
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
Subject: [PATCH 05/12] perf tools: Read also the end of the kernel
Date:   Wed,  8 May 2019 15:20:03 +0200
Message-Id: <20190508132010.14512-6-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 13:20:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We mark the end of kernel based on the first module,
but that could cover some bpf program maps. Reading
_etext symbol if it's present to get precise kernel
map end.

Link: http://lkml.kernel.org/n/tip-ynut991ttyyhvo1sbhlm4c42@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa198c..ad0205fbb506 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -924,7 +924,8 @@ const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
  * symbol_name if it's not that important.
  */
 static int machine__get_running_kernel_start(struct machine *machine,
-					     const char **symbol_name, u64 *start)
+					     const char **symbol_name,
+					     u64 *start, u64 *end)
 {
 	char filename[PATH_MAX];
 	int i, err = -1;
@@ -949,6 +950,11 @@ static int machine__get_running_kernel_start(struct machine *machine,
 		*symbol_name = name;
 
 	*start = addr;
+
+	err = kallsyms__get_function_start(filename, "_etext", &addr);
+	if (!err)
+		*end = addr;
+
 	return 0;
 }
 
@@ -1440,7 +1446,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 start = 0, end = ~0ULL;
 	int ret;
 
 	if (kernel == NULL)
@@ -1459,9 +1465,9 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
+	if (!machine__get_running_kernel_start(machine, &name, &start, &end)) {
 		if (name &&
-		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
+		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, start)) {
 			machine__destroy_kernel_maps(machine);
 			ret = -1;
 			goto out_put;
@@ -1471,16 +1477,19 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, addr, ~0ULL);
+		machine__update_kernel_mmap(machine, start, end);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
 		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
 
-	/* update end address of the kernel map using adjacent module address */
-	map = map__next(machine__kernel_map(machine));
-	if (map)
-		machine__set_kernel_mmap(machine, addr, map->start);
+	if (end == ~0ULL) {
+		/* update end address of the kernel map using adjacent module address */
+		map = map__next(machine__kernel_map(machine));
+		if (map)
+			machine__set_kernel_mmap(machine, start, map->start);
+	}
+
 out_put:
 	dso__put(kernel);
 	return ret;
-- 
2.20.1

