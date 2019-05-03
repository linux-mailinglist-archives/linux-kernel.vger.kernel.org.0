Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EC12D31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfECMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:09:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:1063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfECMJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:09:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043079"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:09:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font
Date:   Fri,  3 May 2019 15:08:23 +0300
Message-Id: <20190503120828.25326-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503120828.25326-1-adrian.hunter@intel.com>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following error if shrink / enlarge font is used with the help
window.

  Traceback (most recent call last):
    File "tools/perf/scripts/python/exported-sql-viewer.py", line 2791, in ShrinkFont
      ShrinkFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c586abfb2b46..289e8dbd1444 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2770,6 +2770,14 @@ class MainWindow(QMainWindow):
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
 
+	def Try(self, fn):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				fn(win.view)
+			except:
+				pass
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
@@ -2787,12 +2795,10 @@ class MainWindow(QMainWindow):
 				pass
 
 	def ShrinkFont(self):
-		win = self.mdi_area.activeSubWindow()
-		ShrinkFont(win.view)
+		self.Try(ShrinkFont)
 
 	def EnlargeFont(self):
-		win = self.mdi_area.activeSubWindow()
-		EnlargeFont(win.view)
+		self.Try(EnlargeFont)
 
 	def EventMenu(self, events, reports_menu):
 		branches_events = 0
-- 
2.17.1

