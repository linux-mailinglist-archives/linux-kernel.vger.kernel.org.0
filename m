Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2F17A63
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfEHNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 09:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49881 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfEHNU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64CF181E06;
        Wed,  8 May 2019 13:20:29 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB14C1018A2A;
        Wed,  8 May 2019 13:20:26 +0000 (UTC)
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
Subject: [PATCH 04/12] perf tools: Add bpf dso read and size hooks
Date:   Wed,  8 May 2019 15:20:02 +0200
Message-Id: <20190508132010.14512-5-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 08 May 2019 13:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bpf related code into dso reading paths to return
size (bpf_size) and read the bpf code (bpf_read).

Link: http://lkml.kernel.org/n/tip-ql6jpegvv5823yc87u0hlzfa@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1e6a045adb8c..2c9289621efd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -9,6 +9,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
+#include <bpf/libbpf.h>
+#include "bpf-event.h"
 #include "compress.h"
 #include "namespaces.h"
 #include "path.h"
@@ -706,6 +708,44 @@ bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
 	return false;
 }
 
+static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
+{
+	struct bpf_prog_info_node *node;
+	ssize_t size = DSO__DATA_CACHE_SIZE;
+	u64 len;
+	u8 *buf;
+
+	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	if (!node || !node->info_linear) {
+		dso->data.status = DSO_DATA_STATUS_ERROR;
+		return -1;
+	}
+
+	len = node->info_linear->info.jited_prog_len;
+	buf = (u8 *) node->info_linear->info.jited_prog_insns;
+
+	if (offset >= len)
+		return -1;
+
+	size = (ssize_t) min(len - offset, (u64) size);
+	memcpy(data, buf + offset, size);
+	return size;
+}
+
+static int bpf_size(struct dso *dso)
+{
+	struct bpf_prog_info_node *node;
+
+	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	if (!node || !node->info_linear) {
+		dso->data.status = DSO_DATA_STATUS_ERROR;
+		return -1;
+	}
+
+	dso->data.file_size = node->info_linear->info.jited_prog_len;
+	return 0;
+}
+
 static void
 dso_cache__free(struct dso *dso)
 {
@@ -832,7 +872,11 @@ dso_cache__read(struct dso *dso, struct machine *machine,
 	if (!cache)
 		return -ENOMEM;
 
-	ret = file_read(dso, machine, cache_offset, cache->data);
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		ret = bpf_read(dso, cache_offset, cache->data);
+	else
+		ret = file_read(dso, machine, cache_offset, cache->data);
+
 	if (ret > 0) {
 		cache->offset = cache_offset;
 		cache->size   = ret;
@@ -941,6 +985,9 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
 	if (dso->data.status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return bpf_size(dso);
+
 	return file_size(dso, machine);
 }
 
-- 
2.20.1

