Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E22EEE82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfKDWGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 17:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389917AbfKDWGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:06:10 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2DC20650;
        Mon,  4 Nov 2019 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905169;
        bh=/bed9kQ9wctSWQIEVWMoM3vLii4+hyghZGfFJWUIRk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbDKDqgVJKlSuwoxRkatk3weSk7B01giHoyIuu22sQYM3BIJbikKHlDcEoer7X5VV
         YF/wcenRUpVG6i3hS75fXveTFKezzgdPrOqt9vSQEJWSI2fJ1qVn/933QAkIiV8YZO
         bkAMKhsWCum0883zZi+EQgWb1xNLgZVmFh1Q+lsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.3 014/163] perf annotate: Propagate perf_env__arch() error
Date:   Mon,  4 Nov 2019 22:43:24 +0100
Message-Id: <20191104212141.482686941@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit a66fa0619a0ae3585ef09e9c33ecfb5c7c6cb72b ]

The callers of symbol__annotate2() use symbol__strerror_disassemble() to
convert its failure returns into a human readable string, so
propagate error values from functions it calls, starting with
perf_env__arch() that when fails the right thing to do is to look at
'errno' to see why its possible call to uname() failed.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-it5d83kyusfhb1q1b0l4pxzs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 163536720149b..6d9642c082e52 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2065,7 +2065,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	int err;
 
 	if (!arch_name)
-		return -1;
+		return errno;
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-- 
2.20.1



