Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA962F98E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfKLSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfKLSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:43 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726C4214E0;
        Tue, 12 Nov 2019 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583923;
        bh=emYX99j+iyxbfPsY627asHdzY+Dq510LD4vlJk73CpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evbZn4jdGKJSmnI+DU5sqB5lEGDLLkyNWBTGWipVVEuz6/WR/G+JT/o06UNQuzbN1
         hlBkBR8Vm3ytjemhiHDWd2+eGzdmro3LPXcyup5qV5gd0I1hBJZIjp/TMsobE7i5/1
         PMWKp8GfaCUPYvQ0Ecy91dMmPuGuJUXpGUiNKO9c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 09/15] perf symbols: Use kmaps(map)->machine when we know its a kernel map
Date:   Tue, 12 Nov 2019 15:37:51 -0300
Message-Id: <20191112183757.28660-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And then stop using map->groups to achieve that.

To test that that branch is being taken, probe the function that is only
called from there and then run something like 'perf top' in another
xterm:

  # perf probe -x ~/bin/perf machine__map_x86_64_entry_trampolines
  Added new event:
    probe_perf:machine__map_x86_64_entry_trampolines (on machine__map_x86_64_entry_trampolines in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:machine__map_x86_64_entry_trampolines -aR sleep 1

  # perf trace -e probe_perf:*
       0.000 bash/10614 probe_perf:machine__map_x86_64_entry_trampolines(__probe_ip: 5224944)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgrrzdxo2p9liq2keivcg887@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2764863212b1..88f4cfbdb69a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1588,7 +1588,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char *name;
 	int ret = -1;
 	u_int i;
-	struct machine *machine;
+	struct machine *machine = NULL;
 	char *root_dir = (char *) "";
 	int ss_pos = 0;
 	struct symsrc ss_[2];
@@ -1617,17 +1617,13 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups)
-		machine = map->groups->machine;
-	else
-		machine = NULL;
-
 	if (dso->kernel) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
+		machine = map__kmaps(map)->machine;
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2027,15 +2023,9 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
-	struct machine *machine;
+	struct machine *machine = map__kmaps(map)->machine;
 	char path[PATH_MAX];
 
-	if (!map->groups) {
-		pr_debug("Guest kernel map hasn't the point to groups\n");
-		return -1;
-	}
-	machine = map->groups->machine;
-
 	if (machine__is_default_guest(machine)) {
 		/*
 		 * if the user specified a vmlinux filename, use it and only
-- 
2.21.0

