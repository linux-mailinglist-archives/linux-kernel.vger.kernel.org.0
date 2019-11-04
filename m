Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E133EF12D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfKDX1U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Nov 2019 18:27:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728810AbfKDX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:27:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-f_r9c5y6OXCN-NgBxiEUDg-1; Mon, 04 Nov 2019 18:27:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7654C800C73;
        Mon,  4 Nov 2019 23:27:14 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-100.brq.redhat.com [10.40.204.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4F219C58;
        Mon,  4 Nov 2019 23:27:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Fix time sorting
Date:   Tue,  5 Nov 2019 00:27:11 +0100
Message-Id: <20191104232711.16055-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: f_r9c5y6OXCN-NgBxiEUDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final sort might get confused when the comparison
is done over bigger numbers than int like for -s time.

Check following report for longer workloads:
  $ perf report -s time -F time,overhead --stdio

Fixing hist_entry__sort to properly return int64_t and
not possible cut int.

Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-uetl5z1eszpubzqykvdftaq6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..7b6eaf5e0bda 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1625,7 +1625,7 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
 	return 0;
 }
 
-static int hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
+static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
 {
 	struct hists *hists = a->hists;
 	struct perf_hpp_fmt *fmt;
-- 
2.21.0

