Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779BD9DB23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfH0BhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbfH0BhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70356217F5;
        Tue, 27 Aug 2019 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869823;
        bh=+fJVP/ciPxlvT0JnnPLcOdqYsZvt3m5E7HedU6H9qJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQPP5AaXhdJYkVJgLHLh2kNntzHlv5L07Rxh2Zs/qWDoR2/sfzEBCLq03jr+ndjHB
         ahSQaCkpu+tRJ1BrdNw/lt7K2ACBgFqCpGYUo/ia4cfKomHWXyPGPIso2bDZxMRARM
         LSiRd62cDOZbNv3ZkLh1r41oEDMrdGmtKrghDLdU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <James.Clark@arm.com>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/33] perf tests: Fixes hang in zstd compression test by changing the source of random data
Date:   Mon, 26 Aug 2019 22:36:08 -0300
Message-Id: <20190827013634.3173-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <James.Clark@arm.com>

Running 'perf test' with zstd compression linked will hang at the test
'Zstd perf.data compression/decompression' because /dev/random blocks
reads until there is enough entropy. This means that the test will
appear to never complete unless the mouse is continually moved while
running it.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/3d8cc701-df4e-f949-1715-5118b530e990@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 899604d17b85..63a91ec473bb 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -13,7 +13,7 @@ skip_if_no_z_record() {
 collect_z_record() {
 	echo "Collecting compressed record file:"
 	$perf_tool record -o $trace_file -g -z -F 5000 -- \
-		dd count=500 if=/dev/random of=/dev/null
+		dd count=500 if=/dev/urandom of=/dev/null
 }
 
 check_compressed_stats() {
-- 
2.21.0

