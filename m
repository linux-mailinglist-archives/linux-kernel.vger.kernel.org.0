Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C118DD32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfHNSnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:00 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BC72084F;
        Wed, 14 Aug 2019 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808179;
        bh=xXbxKYL1QSlhNhqzF7tNzZomPLhyayzMggl/0dcU1RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYJG/bl2/BV79ROb5ThsQ6S6n3Cfm3W21CQykjmbP3vtruHE1cj9HolXt880o1bUa
         aVjEtyOCU3yxtZE0KPpZpJBYrxJ0eF1CZ8JnCj2Xm5pol12dOZ31iXwkf8Yj2eRW+v
         pr8/OoEH2GFGSwWCajQ0BoJP/7VnHff6wDnjJ074=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/28] perf hists: Do not link a pair if already linked
Date:   Wed, 14 Aug 2019 15:40:31 -0300
Message-Id: <20190814184051.3125-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we have multiple events in a group we link hist_entries in the
non-leader evsel hists to the one in the leader that points to the same
sorting criteria, in hists__match().

For 'perf report' we do this just once and then print the results, but
for 'perf top' we need to look if this was already done in the previous
refresh of the screen, so check for that and don't try to link again.

This is part of having 'perf top' using the hists browser for showing
multiple events in multiple columns.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iwvb37rgb7upswhruwpcdnhw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4297f56b1e05..d923a5bb7b48 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2453,7 +2453,7 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair)
+		if (pair && list_empty(&pair->pairs.node))
 			hist_entry__add_pair(pair, pos);
 	}
 }
-- 
2.21.0

