Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDC12D35
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfECMKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:10:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:1063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbfECMJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:09:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043083"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:09:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf scripts python: exported-sql-viewer.py: Move view creation
Date:   Fri,  3 May 2019 15:08:24 +0300
Message-Id: <20190503120828.25326-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503120828.25326-1-adrian.hunter@intel.com>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for adding support for copying to clipboard, create view in
TreeWindowBase instead of derived classes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 289e8dbd1444..73fc02d6d1e4 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -891,9 +891,10 @@ class TreeWindowBase(QMdiSubWindow):
 		super(TreeWindowBase, self).__init__(parent)
 
 		self.model = None
-		self.view = None
 		self.find_bar = None
 
+		self.view = QTreeView()
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -935,7 +936,6 @@ class CallGraphWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
@@ -958,7 +958,6 @@ class CallTreeWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 230), (1, 100), (2, 100), (3, 70), (4, 70), (5, 100)):
-- 
2.17.1

