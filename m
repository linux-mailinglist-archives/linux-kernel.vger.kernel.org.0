Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF99FB023
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfKMMDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:03:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:6589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfKMMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:03:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 04:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="379203287"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by orsmga005.jf.intel.com with ESMTP; 13 Nov 2019 04:03:02 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf scripts python: exported-sql-viewer.py: Fix use of TRUE with SQLite
Date:   Wed, 13 Nov 2019 14:02:06 +0200
Message-Id: <20191113120206.26957-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to version 3.23 SQLite does not support TRUE or FALSE, so always use
1 and 0 for SQLite.

Fixes: 26c11206f433 ("perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index ebc6a2e5eae9..26d7be785288 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -637,7 +637,7 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 		self.query_done = True
 		if_has_calls = ""
 		if IsSelectable(glb.db, "comms", columns = "has_calls"):
-			if_has_calls = " WHERE has_calls = TRUE"
+			if_has_calls = " WHERE has_calls = " + glb.dbref.TRUE
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
@@ -918,7 +918,7 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 		self.query_done = True
 		if_has_calls = ""
 		if IsSelectable(glb.db, "comms", columns = "has_calls"):
-			if_has_calls = " WHERE has_calls = TRUE"
+			if_has_calls = " WHERE has_calls = " + glb.dbref.TRUE
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
@@ -1290,7 +1290,7 @@ class SwitchGraphData(GraphData):
 		QueryExec(query, "SELECT id, c_time"
 					" FROM comms"
 					" WHERE c_thread_id = " + str(thread_id) +
-					"   AND exec_flag = TRUE"
+					"   AND exec_flag = " + self.collection.glb.dbref.TRUE +
 					"   AND c_time >= " + str(start_time) +
 					"   AND c_time <= " + str(end_time) +
 					" ORDER BY c_time, id")
@@ -5016,6 +5016,12 @@ class DBRef():
 	def __init__(self, is_sqlite3, dbname):
 		self.is_sqlite3 = is_sqlite3
 		self.dbname = dbname
+		self.TRUE = "TRUE"
+		self.FALSE = "FALSE"
+		# SQLite prior to version 3.23 does not support TRUE and FALSE
+		if self.is_sqlite3:
+			self.TRUE = "1"
+			self.FALSE = "0"
 
 	def Open(self, connection_name):
 		dbname = self.dbname
-- 
2.17.1

