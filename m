Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76E412968C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 14:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfLWNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 08:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfLWNdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:33:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E047E2075B;
        Mon, 23 Dec 2019 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577107984;
        bh=cPU+3xhCuAHX7FdaESpumX6rksm9tNTNRV04YImy5vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+l4VTGglt+rju+uY4wvo7It7HzNxfyp43iwbjpBaDB3cHYDej1DSMuhX5MUpYvxz
         R6gLBUmw0ve+UxlUJHXOSOY2O5vNK+EEwpvUxXNM+Q73seyfDoMl9k+HNs9n0HSn6C
         dIM2q/IUXMT9EUiWMXpczpeRXyskmUJGRjzwBbhM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yuya Fujita <fujita.yuya@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf hists: Fix variable name's inconsistency in hists__for_each() macro
Date:   Mon, 23 Dec 2019 10:32:41 -0300
Message-Id: <20191223133241.8578-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
References: <20191223133241.8578-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuya Fujita <fujita.yuya@fujitsu.com>

Variable names are inconsistent in hists__for_each macro().

Due to this inconsistency, the macro replaces its second argument with
"fmt" regardless of its original name.

So far it works because only "fmt" is passed to the second argument.
However, this behavior is not expected and should be fixed.

Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")
Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 45286900aacb..0aa63aeb58ec 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
 
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
 
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
 
 extern struct perf_hpp_fmt perf_hpp__format[];
 
-- 
2.21.1

