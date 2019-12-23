Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93C129689
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLWNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 08:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfLWNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:32:54 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DCB2073A;
        Mon, 23 Dec 2019 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577107974;
        bh=dvUrNWrKcvM8MDApuP+dGnvTKVAeHhP3DNKq6n1SAwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e947O8CuqPSNFGtTfjySt+uBa8ye1LvJ+OW6DeXYqdFTxlBobcDGer1DRQn2FkJ9n
         n+tc0cFncIG444jtEyImT0RIQU70/ndrHvJX1PxtBAFGnVIYcPK80zKBG63PnhGIMz
         ufQ0+C2sFuu71DWskQ/wxXfsAuQqdqOY0ybD2iLc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Hewenliang <hewenliang4@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Feilong Lin <linfeilong@huawei.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/4] tools lib traceevent: Fix memory leakage in filter_event
Date:   Mon, 23 Dec 2019 10:32:38 -0300
Message-Id: <20191223133241.8578-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
References: <20191223133241.8578-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hewenliang <hewenliang4@huawei.com>

It is necessary to call free_arg(arg) when add_filter_type() returns NULL
in filter_event().

Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20191209063549.59941-1-hewenliang4@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index f3cbf86e51ac..20eed719542e 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1228,8 +1228,10 @@ filter_event(struct tep_event_filter *filter, struct tep_event *event,
 	}
 
 	filter_type = add_filter_type(filter, event->id);
-	if (filter_type == NULL)
+	if (filter_type == NULL) {
+		free_arg(arg);
 		return TEP_ERRNO__MEM_ALLOC_FAILED;
+	}
 
 	if (filter_type->filter)
 		free_arg(filter_type->filter);
-- 
2.21.1

