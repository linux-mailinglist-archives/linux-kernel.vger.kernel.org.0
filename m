Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3244D707B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfGVRmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:07 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F50A21903;
        Mon, 22 Jul 2019 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817326;
        bh=JdowPRpPbbQQV14qRQQAF/+PxPxi44BB8cKBgxEZ2VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASz8i5hEyZGcbCo2Ml+K8V11uJn+nwrUU23BQCZy1od8xAkxmNyzg5+ZiAkYwdpiw
         GxSVlhsTKfIPMbe57ErwY+yktuQPPVnBfL/4QTLEzXGWx1CApMpOmvbp36KjYSxBRS
         LJQ+rAx06Ay1RE0o5gQypux3BB0hFY9h01wcVyTk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/37] perf session: Fix loading of compressed data split across adjacent records
Date:   Mon, 22 Jul 2019 14:38:30 -0300
Message-Id: <20190722173839.22898-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Fix decompression failure found during the loading of compressed trace
collected on larger scale systems (>48 cores).

The error happened due to lack of decompression space for a mmaped
buffer data chunk split across adjacent PERF_RECORD_COMPRESSED records.

  $ perf report -i bt.16384.data --stats
  failed to decompress (B): 63869 -> 0 : Destination buffer is too small
  user stack dump failure
  Can't parse sample, err = -14
  0x2637e436 [0x4080]: failed to process type: 9
  Error:
  failed to process sample

  $ perf test 71
  71: Zstd perf.data compression/decompression              : Ok

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 22 ++++++++++++++--------
 tools/perf/util/session.h |  1 +
 tools/perf/util/zstd.c    |  4 ++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0fd6c614e68..37efa1f43d8b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,10 +36,16 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	void *src;
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
-	size_t decomp_len = session->header.env.comp_mmap_len;
+	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->decomp_last;
 
-	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		decomp_len += decomp_last_rem;
+	}
+
+	mmap_len = sizeof(struct decomp) + decomp_len;
+	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
 		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (decomp == MAP_FAILED) {
 		pr_err("Couldn't allocate memory for decompression\n");
@@ -47,10 +53,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	}
 
 	decomp->file_pos = file_offset;
+	decomp->mmap_len = mmap_len;
 	decomp->head = 0;
 
-	if (decomp_last) {
-		decomp_last_rem = decomp_last->size - decomp_last->head;
+	if (decomp_last_rem) {
 		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
 		decomp->size = decomp_last_rem;
 	}
@@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
-		munmap(decomp, sizeof(struct decomp) + decomp_len);
+		munmap(decomp, mmap_len);
 		pr_err("Couldn't decompress data\n");
 		return -1;
 	}
@@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
 static void perf_session__release_decomp_events(struct perf_session *session)
 {
 	struct decomp *next, *decomp;
-	size_t decomp_len;
+	size_t mmap_len;
 	next = session->decomp;
-	decomp_len = session->header.env.comp_mmap_len;
 	do {
 		decomp = next;
 		if (decomp == NULL)
 			break;
 		next = decomp->next;
-		munmap(decomp, decomp_len + sizeof(struct decomp));
+		mmap_len = decomp->mmap_len;
+		munmap(decomp, mmap_len);
 	} while (1);
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index dd8920b745bc..863dbad87849 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -46,6 +46,7 @@ struct perf_session {
 struct decomp {
 	struct decomp *next;
 	u64 file_pos;
+	size_t mmap_len;
 	u64 head;
 	size_t size;
 	char data[];
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 23bdb9884576..d2202392ffdb 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -99,8 +99,8 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
-			       src_size, output.size, ZSTD_getErrorName(ret));
+			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
 		output.dst  = dst + output.pos;
-- 
2.21.0

