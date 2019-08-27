Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7EE9DB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfH0Bhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfH0Bhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4D421872;
        Tue, 27 Aug 2019 01:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869850;
        bh=F2BZeg9vkl3GvkxEZJZgNFKnXRjDhwKDe1MfIKRr79I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHjEPMT+VvzPITBHp8ZfJA7eRCnuIQhIHclLjwhHC8bhSzeZtMCd5GD6ovBvnkfhl
         5q3iOV7NChoGpJdqxF61AUdE61qUSRxzt4LWlhnsc469nA0UYAn3Zh6iEg+AGzFh44
         YrN+NHfyw4/l0xD1W/ueDr5dbwCezMYUBoil/jGs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/33] perf script: Fix memory leaks in list_scripts()
Date:   Mon, 26 Aug 2019 22:36:17 -0300
Message-Id: <20190827013634.3173-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In case memory resources for *buf* and *paths* were allocated, jump to
*out* and release them before return.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1444328 ("Resource leak")
Fixes: 6f3da20e151f ("perf report: Support builtin perf script in scripts menu")
Link: http://lkml.kernel.org/r/20190408162748.GA21008@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/scripts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index f2fd9f0d7ab5..50e0c03171f2 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -133,8 +133,10 @@ static int list_scripts(char *script_name, bool *custom,
 		int key = ui_browser__input_window("perf script command",
 				"Enter perf script command line (without perf script prefix)",
 				script_args, "", 0);
-		if (key != K_ENTER)
-			return -1;
+		if (key != K_ENTER) {
+			ret = -1;
+			goto out;
+		}
 		sprintf(script_name, "%s script %s", perf, script_args);
 	} else if (choice < num + max_std) {
 		strcpy(script_name, paths[choice]);
-- 
2.21.0

