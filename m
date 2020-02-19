Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F5164906
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBSPpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 10:45:02 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:33007 "EHLO
        1.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBSPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:45:01 -0500
Received: from player739.ha.ovh.net (unknown [10.108.35.210])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 108A08EAB3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:35:13 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player739.ha.ovh.net (Postfix) with ESMTPSA id B14AEB8813C7;
        Wed, 19 Feb 2020 15:35:00 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v3] docs: add a script to check sysctl docs
Date:   Wed, 19 Feb 2020 16:34:42 +0100
Message-Id: <20200219153442.10205-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6174716565579910533
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrkedtgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script allows sysctl documentation to be checked against the
kernel source code, to identify missing or obsolete entries. Running
it against 5.5 shows for example that sysctl/kernel.rst has two
obsolete entries and is missing 52 entries.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v2:
* drop UTF-8 characters
* fix license identifier
* fix example invocation to include path as well as table

v2 was the initial submission (in v2 of the sysctl/kernel.rst patch
set).
---
 Documentation/admin-guide/sysctl/kernel.rst |   3 +
 scripts/check-sysctl-docs                   | 181 ++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 scripts/check-sysctl-docs

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6fbfa497388a..ba4b51bb1f3e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -2,6 +2,9 @@
 Documentation for /proc/sys/kernel/
 ===================================
 
+.. See scripts/check-sysctl-docs to keep this up to date
+
+
 Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
new file mode 100755
index 000000000000..8bcb9e26c7bc
--- /dev/null
+++ b/scripts/check-sysctl-docs
@@ -0,0 +1,181 @@
+#!/usr/bin/gawk -f
+# SPDX-License-Identifier: GPL-2.0
+
+# Script to check sysctl documentation against source files
+#
+# Copyright (c) 2020 Stephen Kitt
+
+# Example invocation:
+#	scripts/check-sysctl-docs -vtable="kernel" \
+#		Documentation/admin-guide/sysctl/kernel.rst \
+#		$(git grep -l register_sysctl_)
+#
+# Specify -vdebug=1 to see debugging information
+
+BEGIN {
+    if (!table) {
+	print "Please specify the table to look for using the table variable" > "/dev/stderr"
+	exit 1
+    }
+}
+
+# The following globals are used:
+# children: maps ctl_table names and procnames to child ctl_table names
+# documented: maps documented entries (each key is an entry)
+# entries: maps ctl_table names and procnames to counts (so
+#          enumerating the subkeys for a given ctl_table lists its
+#          procnames)
+# files: maps procnames to source file names
+# paths: maps ctl_path names to paths
+# curpath: the name of the current ctl_path struct
+# curtable: the name of the current ctl_table struct
+# curentry: the name of the current proc entry (procname when parsing
+#           a ctl_table, constructed path when parsing a ctl_path)
+
+
+# Remove punctuation from the given value
+function trimpunct(value) {
+    while (value ~ /^["&]/) {
+	value = substr(value, 2)
+    }
+    while (value ~ /[]["&,}]$/) {
+	value = substr(value, 1, length(value) - 1)
+    }
+    return value
+}
+
+# Print the information for the given entry
+function printentry(entry) {
+    seen[entry]++
+    printf "* %s from %s", entry, file[entry]
+    if (documented[entry]) {
+	printf " (documented)"
+    }
+    print ""
+}
+
+
+# Stage 1: build the list of documented entries
+FNR == NR && /^=+$/ {
+    if (prevline ~ /Documentation for/) {
+	# This is the main title
+	next
+    }
+
+    # The previous line is a section title, parse it
+    $0 = prevline
+    if (debug) print "Parsing " $0
+    inbrackets = 0
+    for (i = 1; i <= NF; i++) {
+	if (length($i) == 0) {
+	    continue
+	}
+	if (!inbrackets && substr($i, 1, 1) == "(") {
+	    inbrackets = 1
+	}
+	if (!inbrackets) {
+	    token = trimpunct($i)
+	    if (length(token) > 0 && token != "and") {
+		if (debug) print trimpunct($i)
+		documented[trimpunct($i)]++
+	    }
+	}
+	if (inbrackets && substr($i, length($i), 1) == ")") {
+	    inbrackets = 0
+	}
+    }
+}
+
+FNR == NR {
+    prevline = $0
+    next
+}
+
+
+# Stage 2: process each file and find all sysctl tables
+BEGINFILE {
+    delete children
+    delete entries
+    delete paths
+    curpath = ""
+    curtable = ""
+    curentry = ""
+    if (debug) print "Processing file " FILENAME
+}
+
+/^static struct ctl_path/ {
+    match($0, /static struct ctl_path ([^][]+)/, tables)
+    curpath = tables[1]
+    if (debug) print "Processing path " curpath
+}
+
+/^static struct ctl_table/ {
+    match($0, /static struct ctl_table ([^][]+)/, tables)
+    curtable = tables[1]
+    if (debug) print "Processing table " curtable
+}
+
+/^};$/ {
+    curpath = ""
+    curtable = ""
+    curentry = ""
+}
+
+curpath && /\.procname[\t ]*=[\t ]*".+"/ {
+    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
+    if (curentry) {
+	curentry = curentry "/" names[1]
+    } else {
+	curentry = names[1]
+    }
+    if (debug) print "Setting path " curpath " to " curentry
+    paths[curpath] = curentry
+}
+
+curtable && /\.procname[\t ]*=[\t ]*".+"/ {
+    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
+    curentry = names[1]
+    if (debug) print "Adding entry " curentry " to table " curtable
+    entries[curtable][curentry]++
+    file[curentry] = FILENAME
+}
+
+/\.child[\t ]*=/ {
+    child = trimpunct($NF)
+    if (debug) print "Linking child " child " to table " curtable " entry " curentry
+    children[curtable][curentry] = child
+}
+
+/register_sysctl_table\(.*\)/ {
+    match($0, /register_sysctl_table\(([^)]+)\)/, tables)
+    if (debug) print "Registering table " tables[1]
+    if (children[tables[1]][table]) {
+	for (entry in entries[children[tables[1]][table]]) {
+	    printentry(entry)
+	}
+    }
+}
+
+/register_sysctl_paths\(.*\)/ {
+    match($0, /register_sysctl_paths\(([^)]+), ([^)]+)\)/, tables)
+    if (debug) print "Attaching table " tables[2] " to path " tables[1]
+    if (paths[tables[1]] == table) {
+	for (entry in entries[tables[2]]) {
+	    printentry(entry)
+	}
+    }
+    split(paths[tables[1]], components, "/")
+    if (length(components) > 1 && components[1] == table) {
+	# Count the first subdirectory as seen
+	seen[components[2]]++
+    }
+}
+
+
+END {
+    for (entry in documented) {
+	if (!seen[entry]) {
+	    print "No implementation for " entry
+	}
+    }
+}
-- 
2.20.1

