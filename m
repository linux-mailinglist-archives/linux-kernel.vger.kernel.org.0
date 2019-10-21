Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589E7DEDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfJUNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfJUNkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90AA214B2;
        Mon, 21 Oct 2019 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665216;
        bh=9UxFmKuBFjeNvT1nzWgHQrO/jr2YDfCt399FobUHFrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly1AgBf15ZhXjnv18TsCyAXCb5gjRPEj3fhCyCvH6vTBbdx24jHzjbS+P5k08v4D8
         B/4UHxsTPWyWRU/wSNWLpt8RfLRv60DQKBaBXz4TNxmifMFsDARA8YiTm9Ed6ZlsJr
         f40Tnh4GgY03JlTsqGEA1uLdiIq6FBI1uNDH0WVs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 29/57] perf trace: Show error message when not finding a field used in a filter expression
Date:   Mon, 21 Oct 2019 10:38:06 -0300
Message-Id: <20191021133834.25998-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was there, but as pr_debug(), make it pr_err() so that we can see it
without -v:

  # trace -e syscalls:*lseek --filter="whenc==SET" sleep 1
  "whenc" not found in "syscalls:sys_enter_lseek", can't set filter "whenc==SET"
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ly4rgm1bto8uwc2itpaixjob@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e71605c99080..cafd18466dfa 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3611,8 +3611,8 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 			fmt = perf_evsel__syscall_arg_fmt(evsel, arg);
 			if (fmt == NULL) {
-				pr_debug("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
-					 arg, evsel->name, evsel->filter);
+				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
+				       arg, evsel->name, evsel->filter);
 				return -1;
 			}
 
-- 
2.21.0

