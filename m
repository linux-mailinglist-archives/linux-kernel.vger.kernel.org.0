Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D032F855
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfE3IKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:10:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfE3IKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:10:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8AUAw2904234
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:10:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8AUAw2904234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203831;
        bh=9M6OzNL7rv7rHmmNJPNEspaV6z4hH4gUT99h+fZMBpw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KavaIMX4NfNTzhEmhq5BBoo2xT8Gab6ptnQPvJHkhPt9fWbpQyOFLuTC6CB/AAN7K
         GAS/S1tw/cFXfpusAy4LpLCVfbhYVfl5QebPXT849THSiXzBfY7QVTA0FT4SaW2Ji2
         6EXHlKmF/oAMVo74bgpUea3jbrz31ANiVHfi7dUm940zQK6eh3loQamry8mFzfqTV4
         1+FRVOx0CNqq/bit8FLtOVjPa4Qhh+XaFR2n7/TwpTL9BnZHL1kQ+ElTVl03PBRfvb
         Xzum5rRz2QDrmSgdJDRWSAWxg+S7ChKYmlrm/HvBx4yNk4WL2EMHyhts7h1fq3WRTP
         XWCMju6nnQ+Zg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8AUmO2904231;
        Thu, 30 May 2019 01:10:30 -0700
Date:   Thu, 30 May 2019 01:10:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6c398d723a6a6d27485e701ae21e50304ec95595@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
        acme@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, sdf@google.com,
        jolsa@kernel.org, songliubraving@fb.com
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, sdf@google.com, jolsa@kernel.org,
          songliubraving@fb.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20190508132010.14512-5-jolsa@kernel.org>
References: <20190508132010.14512-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Add BPF DSO read and size hooks
Git-Commit-ID: 6c398d723a6a6d27485e701ae21e50304ec95595
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6c398d723a6a6d27485e701ae21e50304ec95595
Gitweb:     https://git.kernel.org/tip/6c398d723a6a6d27485e701ae21e50304ec95595
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf dso: Add BPF DSO read and size hooks

Add BPF related code into DSO reading paths to return size (bpf_size)
and read the BPF code (bpf_read).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-5-jolsa@kernel.org
[ Use uintptr_t when casting from u64 to u8 pointers ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1e6a045adb8c..1fb18292c2d3 100644
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
+	buf = (u8 *)(uintptr_t)node->info_linear->info.jited_prog_insns;
+
+	if (offset >= len)
+		return -1;
+
+	size = (ssize_t)min(len - offset, (u64)size);
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
 
