Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558102DE90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfE2Niu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:49 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E7A2253D;
        Wed, 29 May 2019 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137129;
        bh=Bxy2QVAtD7OaR3LKJOHeKWFTimcRVCQlVjaAlgRHHcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0qReqiv3vVuJg8SDut6JLdz0HockBQImZFuedk+ir3SLiZ834UFvGFczJKRaF7vO
         L3XV0ngTcJCN4GX8pUuSHiE28fKZLkPS25wwPC7G0GypA0g212vh470OtO0n3DDCSB
         4O0SLZx7RvP//Iq2MGPbCVYEH3/aKuJJxKixKrh0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/41] perf machine: Return NULL instead of null-terminating /proc/version array
Date:   Wed, 29 May 2019 10:35:55 -0300
Message-Id: <20190529133605.21118-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Donald Yandt <donald.yandt@gmail.com>

Return NULL instead of null-terminating version char array when fgets
fails due to end-of-file or error.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: 30ba5b0e66c8 ("perf machine: Null-terminate version char array upon fgets(/proc/version) error")
Link: http://lkml.kernel.org/r/20190528134128.30841-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f5569f005cf3..17eec39e775e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1241,9 +1241,9 @@ static char *get_kernel_version(const char *root_dir)
 		return NULL;
 
 	tmp = fgets(version, sizeof(version), file);
-	if (!tmp)
-		*version = '\0';
 	fclose(file);
+	if (!tmp)
+		return NULL;
 
 	name = strstr(version, prefix);
 	if (!name)
-- 
2.20.1

