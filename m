Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955FA63B18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfGIScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbfGIScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F2521670;
        Tue,  9 Jul 2019 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697171;
        bh=LjI26sTNejndiNXkACixRrWdKxRqpjR09VqfnLB2LwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TP+utexmQYqYJI+iyNBjJ1A3MoR6d/5uc9EVuXZjJPdw3HyxgDb74zPgqrRjQWvtS
         KQa/zt7GMgrNK7aqxmtFfYFJVB+w7oUAKnDgRw2qslskEpbiA5yzZxLK6gogHUtJfQ
         BxBROCtIzNWiH3tpjG6WsrZLMlXWgrOD/IT8mj84=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 16/25] perf metricgroup: Add missing list_del_init() when flushing egroups list
Date:   Tue,  9 Jul 2019 15:31:17 -0300
Message-Id: <20190709183126.30257-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that at the end each of the entries have its list node struct cleared
and the egroup list head ends emptied.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dxzj1ah350fy9ec0xbhb15b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0d8c840f88c0..416a9015405e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -492,6 +492,7 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 		for (i = 0; i < eg->idnum; i++)
 			zfree(&eg->ids[i]);
 		zfree(&eg->ids);
+		list_del_init(&eg->nd);
 		free(eg);
 	}
 }
-- 
2.21.0

