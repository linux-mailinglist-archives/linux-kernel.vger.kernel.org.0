Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8812D36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfECMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 08:10:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:1063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfECMKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:10:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043111"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:10:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] perf scripts python: exported-sql-viewer.py: Add context menu
Date:   Fri,  3 May 2019 15:08:27 +0300
Message-Id: <20190503120828.25326-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503120828.25326-1-adrian.hunter@intel.com>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a context menu (right-click) that provides options for copying to
clipboard, including, for trees, the ability to copy only the cell under
the mouse pointer.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 5804d9705ab7..421f3828ea43 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -901,6 +901,8 @@ class TreeWindowBase(QMdiSubWindow):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 
+		self.context_menu = TreeContextMenu(self.view)
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -1674,6 +1676,8 @@ class BranchWindow(QMdiSubWindow):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = TreeContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.model.root)
@@ -2483,6 +2487,39 @@ def CopyCellsToClipboardHdr(view):
 def CopyCellsToClipboardCSV(view):
 	CopyCellsToClipboard(view, True, True)
 
+# Context menu
+
+class ContextMenu(object):
+
+	def __init__(self, view):
+		self.view = view
+		self.view.setContextMenuPolicy(Qt.CustomContextMenu)
+		self.view.customContextMenuRequested.connect(self.ShowContextMenu)
+
+	def ShowContextMenu(self, pos):
+		menu = QMenu(self.view)
+		self.AddActions(menu)
+		menu.exec_(self.view.mapToGlobal(pos))
+
+	def AddCopy(self, menu):
+		menu.addAction(CreateAction("&Copy selection", "Copy to clipboard", lambda: CopyCellsToClipboardHdr(self.view), self.view))
+		menu.addAction(CreateAction("Copy selection as CS&V", "Copy to clipboard as CSV", lambda: CopyCellsToClipboardCSV(self.view), self.view))
+
+	def AddActions(self, menu):
+		self.AddCopy(menu)
+
+class TreeContextMenu(ContextMenu):
+
+	def __init__(self, view):
+		super(TreeContextMenu, self).__init__(view)
+
+	def AddActions(self, menu):
+		i = self.view.currentIndex()
+		text = str(i.data()).strip()
+		if len(text):
+			menu.addAction(CreateAction('Copy "' + text + '"', "Copy to clipboard", lambda: QApplication.clipboard().setText(text), self.view))
+		self.AddCopy(menu)
+
 # Table window
 
 class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
@@ -2506,6 +2543,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.data_model)
@@ -2622,6 +2661,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.ResizeColumnsToContents()
 
 		self.find_bar = FindBar(self, self, True)
-- 
2.17.1

