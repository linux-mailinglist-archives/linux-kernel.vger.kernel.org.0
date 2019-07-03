Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD745DCF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGCD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 23:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfGCD25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F5B21871;
        Wed,  3 Jul 2019 03:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124536;
        bh=q6NPunlPl7glSalNJqR89+RniPP3z8aacYYQpG8ejiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZUiDS2V6b3qZHEpqRCF1nb79sbRgFe2WltMj9+LkWJaOm5IYXLDrkNrjBDZH2aCa
         lQGkKAFBIjk7WcS6ribzepB5229DnPYtEv+Jt0/jmHsJafAWxvkIJ/kR6orTC4vdU3
         5hzb3lBPCGZApvb4xlKmWDec35oorVyOPQrCuol4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/18] perf list: Avoid extra : for --raw metrics
Date:   Wed,  3 Jul 2019 00:27:43 -0300
Message-Id: <20190703032746.21692-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When printing the metrics raw, don't print : after the metricgroups.
This helps the command line completion to complete those too.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index bc25995255ab..7d36435fa84c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -375,7 +375,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
-			printf("%s%s%s", me->name, metrics ? ":" : "", raw ? " " : "\n");
+			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
 		if (metrics)
 			metricgroup__print_strlist(me->metrics, raw);
 		next = rb_next(node);
-- 
2.20.1

