Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFB643FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfGJJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:00:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:35469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfGJI7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102564"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
Date:   Wed, 10 Jul 2019 11:58:03 +0300
Message-Id: <20190710085810.1650-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a thread's current comm is exported, it shows up in the call graph
and call tree even if it has no calls. That can happen because the calls
are recorded against the main thread's initial comm.

Add a table column to make it easy for the exported-sql-viewer.py script to
select only comms with calls.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 01f37877f5bb..13205e4e5b3b 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -886,6 +886,8 @@ def trace_end():
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = TRUE WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 	do_query(query, 'ALTER TABLE ptwrite '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  cbr '
-- 
2.17.1

