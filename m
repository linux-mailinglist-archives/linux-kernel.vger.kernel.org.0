Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D451E63B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfGISdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbfGISdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:33:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5F92087F;
        Tue,  9 Jul 2019 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697192;
        bh=rmMeP9jdmvBC3BSIzK+VFeBtg04e2doVgFNy8JolSCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft43xKrcMHaR3eeew5ccuFnPrOvzHlEoOhGG0cknw7xiHJjq4yuryZvvHvGte+x4P
         oNafc9yJwjgNGn6rrp3/qT/UZGjOZgCOzNl0rkIAu0yXELEafh7MjdXJgLIFc29+cG
         3zgvAc56z63oGiFF9Z3jGEArQO6aR52vJlJ97AgI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/25] perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
Date:   Tue,  9 Jul 2019 15:31:22 -0300
Message-Id: <20190709183126.30257-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

PostgreSQL can error if power_events_view is not dropped before its
dependent tables e.g.

  Exception: Query failed: ERROR:  cannot drop table mwait because other
  objects depend on it
  DETAIL:  view power_events_view depends on table mwait

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: aba44287a224 ("perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events")
Link: http://lkml.kernel.org/r/20190708055232.5032-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 4447f0d7c754..92713d93e956 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -898,11 +898,11 @@ def trace_end():
 	if is_table_empty("ptwrite"):
 		drop("ptwrite")
 	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
+		do_query(query, 'DROP VIEW power_events_view');
 		drop("mwait")
 		drop("pwre")
 		drop("exstop")
 		drop("pwrx")
-		do_query(query, 'DROP VIEW power_events_view');
 		if is_table_empty("cbr"):
 			drop("cbr")
 
-- 
2.21.0

