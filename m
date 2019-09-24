Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35361BD534
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411100AbfIXXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 19:03:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41287 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411088AbfIXXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:03:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so2077930pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jduGEvWmBGhRShNg6nWweJDofSNAgUfI7rJulsDdDIs=;
        b=IvNgtMkfcLrQwUFrGcI/dr2ZIRkDr5ZC9OTUqXqmalRTDPui+awXiQTeW/SIKvu+h3
         Lra5XZG7OYOyX3oXAhXBwkLsRJeIK9jydfmiMtZJGniqOfvsHK0IR84/X03hPuj6jepC
         wT5t1hd1fqYxTw7LLY3Ii3nfTr32LnQZ41ybQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jduGEvWmBGhRShNg6nWweJDofSNAgUfI7rJulsDdDIs=;
        b=rLC4PSoV3g7ZkCS59DzPBctqzg8QaSZGqMiSfV1+NPfd75Faunav4zSKcU5bUGCw4H
         Xlzlne3zIDxmLDgeh3DUt0s7vOuTRvLc65OQdBgcjWtGEPyZ9/sLhc/GJSu5XErHk0Es
         ArKvY3Svat7Zh6zvwmcUBADdh2Rh7rHJjiizPwQeq1SlrEyxMbL43+qF3U0GBIoKNbBu
         liowPHv4PEDeV9z4NEEx8+UcWiTEgKsEkU49bLXJDhcIhdWujJ/SNGx26ujivcM9dNKM
         PZya1N6kxnh5OGWGZCdGTAilLk6OQXBCzthpUcU7VviC7po0fBPkhN1BZ9RZ4cdqS+kI
         YzdA==
X-Gm-Message-State: APjAAAU7L0liv9lSkZsARjz37wK8ggg+iCKdJLw5nIp6zZM6yR1wV0DL
        NcKPORUIrjLRdJIANhe4kOscALyO1OQ=
X-Google-Smtp-Source: APXvYqzWN9tmuQpUdaRK2noYQkNvPr6YmKgO+m0rsFK2Kkb2iN+c+MrhVupHKJiH0xnDM+KXQ2/SHQ==
X-Received: by 2002:a17:90a:be13:: with SMTP id a19mr2621440pjs.55.1569366133054;
        Tue, 24 Sep 2019 16:02:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 129sm3184668pfd.173.2019.09.24.16.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 16:02:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] doc-rst: Programmatically render MAINTAINERS into ReST
Date:   Tue, 24 Sep 2019 16:02:08 -0700
Message-Id: <20190924230208.12414-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190924230208.12414-1-keescook@chromium.org>
References: <20190924230208.12414-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have the MAINTAINERS file visible in the rendered ReST
output, this makes some small changes to the existing MAINTAINERS file
to allow for better machine processing, and adds a new Sphinx directive
"maintainers-include" to perform the rendering.

Features include:
- Per-subsystem reference links: subsystem maintainer entries can be
  trivially linked to both internally and external. For example:
  https://www.kernel.org/doc/html/latest/process/maintainers.html#secure-computing

- Internally referenced .rst files are linked so they can be followed
  when browsing the resulting rendering. This allows, for example, the
  future addition of maintainer profiles to be automatically linked.

- Field name expansion: instead of the short fields (e.g. "M", "F",
  "K"), use the indicated inline "full names" for the fields (which are
  marked with "*"s in MAINTAINERS) so that a rendered subsystem entry
  is more human readable. Email lists are additionally comma-separated.
  For example:

    SECURE COMPUTING
	Mail:	  Kees Cook <keescook@chromium.org>
	Reviewer: Andy Lutomirski <luto@amacapital.net>,
		  Will Drewry <wad@chromium.org>
	SCM:	  git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp
	Status:	  Supported
	Files:	  kernel/seccomp.c include/uapi/linux/seccomp.h
		  include/linux/seccomp.h tools/testing/selftests/seccomp/*
		  tools/testing/selftests/kselftest_harness.h
		  userspace-api/seccomp_filter
	Content regex:	\bsecure_computing \bTIF_SECCOMP\b

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/conf.py                       |   3 +-
 Documentation/process/index.rst             |   1 +
 Documentation/process/maintainers.rst       |   1 +
 Documentation/sphinx/maintainers_include.py | 194 ++++++++++++++++++++
 MAINTAINERS                                 |  62 ++++---
 5 files changed, 230 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/process/maintainers.rst
 create mode 100755 Documentation/sphinx/maintainers_include.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index a8fe845832bc..3c7bdf4cd31f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -37,7 +37,8 @@ needs_sphinx = '1.3'
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
-              'kfigure', 'sphinx.ext.ifconfig', 'automarkup']
+              'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
+              'maintainers_include']
 
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index e2c9ffc682c5..e2fb0c9652ac 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -46,6 +46,7 @@ Other guides to the community that are of interest to most developers are:
    kernel-docs
    deprecated
    embargoed-hardware-issues
+   maintainers
 
 These are some overall technical guides that have been put here for now for
 lack of a better place.
diff --git a/Documentation/process/maintainers.rst b/Documentation/process/maintainers.rst
new file mode 100644
index 000000000000..6174cfb4138f
--- /dev/null
+++ b/Documentation/process/maintainers.rst
@@ -0,0 +1 @@
+.. maintainers-include::
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
new file mode 100755
index 000000000000..de62dd3dabd5
--- /dev/null
+++ b/Documentation/sphinx/maintainers_include.py
@@ -0,0 +1,194 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+# pylint: disable=R0903, C0330, R0914, R0912, E0401
+
+u"""
+    maintainers-include
+    ~~~~~~~~~~~~~~~~~~~
+
+    Implementation of the ``maintainers-include`` reST-directive.
+
+    :copyright:  Copyright (C) 2019  Kees Cook <keescook@chromium.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    The ``maintainers-include`` reST-directive performs extensive parsing
+    specific to the Linux kernel's standard "MAINTAINERS" file, in an
+    effort to avoid needing to heavily mark up the original plain text.
+"""
+
+import re
+import os.path
+
+from docutils import statemachine
+from docutils.utils.error_reporting import ErrorString
+from docutils.parsers.rst import Directive
+from docutils.parsers.rst.directives.misc import Include
+
+__version__  = '1.0'
+
+def setup(app):
+    app.add_directive("maintainers-include", MaintainersInclude)
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
+
+class MaintainersInclude(Include):
+    u"""MaintainersInclude (``maintainers-include``) directive"""
+    required_arguments = 0
+
+    def parse_maintainers(self, path):
+        """Parse all the MAINTAINERS lines into ReST for human-readability"""
+
+        result = list()
+        result.append(".. _maintainers:")
+        result.append("")
+
+        # Poor man's state machine.
+        descriptions = False
+        maintainers = False
+        subsystems = False
+
+        # Field letter to field name mapping.
+        field_letter = None
+        fields = dict()
+
+        prev = None
+        field_prev = ""
+        field_content = ""
+
+        for line in open(path):
+            # Have we reached the end of the preformatted Descriptions text?
+            if descriptions and line.startswith('Maintainers'):
+                descriptions = False
+                # Ensure a blank line following the last "|"-prefixed line.
+                result.append("")
+
+            # Start subsystem processing? This is to skip processing the text
+            # between the Maintainers heading and the first subsystem name.
+            if maintainers and not subsystems:
+                if re.search('^[A-Z0-9]', line):
+                    subsystems = True
+
+            # Drop needless input whitespace.
+            line = line.rstrip()
+
+            # Linkify all non-wildcard refs to ReST files in Documentation/.
+            pat = '(Documentation/([^\s\?\*]*)\.rst)'
+            m = re.search(pat, line)
+            if m:
+                # maintainers.rst is in a subdirectory, so include "../".
+                line = re.sub(pat, ':doc:`%s <../%s>`' % (m.group(2), m.group(2)), line)
+
+            # Check state machine for output rendering behavior.
+            output = None
+            if descriptions:
+                # Escape the escapes in preformatted text.
+                output = "| %s" % (line.replace("\\", "\\\\"))
+                # Look for and record field letter to field name mappings:
+                #   R: Designated *reviewer*: FullName <address@domain>
+                m = re.search("\s(\S):\s", line)
+                if m:
+                    field_letter = m.group(1)
+                if field_letter and not field_letter in fields:
+                    m = re.search("\*([^\*]+)\*", line)
+                    if m:
+                        fields[field_letter] = m.group(1)
+            elif subsystems:
+                # Skip empty lines: subsystem parser adds them as needed.
+                if len(line) == 0:
+                    continue
+                # Subsystem fields are batched into "field_content"
+                if line[1] != ':':
+                    # Render a subsystem entry as:
+                    #   SUBSYSTEM NAME
+                    #   ~~~~~~~~~~~~~~
+
+                    # Flush pending field content.
+                    output = field_content + "\n\n"
+                    field_content = ""
+
+                    # Collapse whitespace in subsystem name.
+                    heading = re.sub("\s+", " ", line)
+                    output = output + "%s\n%s" % (heading, "~" * len(heading))
+                    field_prev = ""
+                else:
+                    # Render a subsystem field as:
+                    #   :Field: entry
+                    #           entry...
+                    field, details = line.split(':', 1)
+                    details = details.strip()
+
+                    # Mark paths (and regexes) as literal text for improved
+                    # readability and to escape any escapes.
+                    if field in ['F', 'N', 'X', 'K']:
+                        # But only if not already marked :)
+                        if not ':doc:' in details:
+                            details = '``%s``' % (details)
+
+                    # Comma separate email field continuations.
+                    if field == field_prev and field_prev in ['M', 'R', 'L']:
+                        field_content = field_content + ","
+
+                    # Do not repeat field names, so that field entries
+                    # will be collapsed together.
+                    if field != field_prev:
+                        output = field_content + "\n"
+                        field_content = ":%s:" % (fields.get(field, field))
+                    field_content = field_content + "\n\t%s" % (details)
+                    field_prev = field
+            else:
+                output = line
+
+            # Re-split on any added newlines in any above parsing.
+            if output != None:
+                for separated in output.split('\n'):
+                    result.append(separated)
+
+            # Update the state machine when we find heading separators.
+            if line.startswith('----------'):
+                if prev.startswith('Descriptions'):
+                    descriptions = True
+                if prev.startswith('Maintainers'):
+                    maintainers = True
+
+            # Retain previous line for state machine transitions.
+            prev = line
+
+        # Flush pending field contents.
+        if field_content != "":
+            for separated in field_content.split('\n'):
+                result.append(separated)
+
+        output = "\n".join(result)
+        # For debugging the pre-rendered results...
+        #print(output, file=open("/tmp/MAINTAINERS.rst", "w"))
+
+        self.state_machine.insert_input(
+          statemachine.string2lines(output), path)
+
+    def run(self):
+        """Include the MAINTAINERS file as part of this reST file."""
+        if not self.state.document.settings.file_insertion_enabled:
+            raise self.warning('"%s" directive disabled.' % self.name)
+
+        # Walk up source path directories to find Documentation/../
+        path = self.state_machine.document.attributes['source']
+        path = os.path.realpath(path)
+        tail = path
+        while tail != "Documentation" and tail != "":
+            (path, tail) = os.path.split(path)
+
+        # Append "MAINTAINERS"
+        path = os.path.join(path, "MAINTAINERS")
+
+        try:
+            self.state.document.settings.record_dependencies.add(path)
+            lines = self.parse_maintainers(path)
+        except IOError as error:
+            raise self.severe('Problems with "%s" directive path:\n%s.' %
+                      (self.name, ErrorString(error)))
+
+        return []
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b6f10ea1573..6c5d86aaa7dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,12 +1,14 @@
-
-
-	List of maintainers and how to submit kernel changes
+List of maintainers and how to submit kernel changes
+====================================================
 
 Please try to follow the guidelines below.  This will make things
 easier on the maintainers.  Not all of these guidelines matter for every
 trivial patch so apply some common sense.
 
-1.	Always _test_ your changes, however small, on at least 4 or
+Tips for patch submitters
+-------------------------
+
+1.	Always *test* your changes, however small, on at least 4 or
 	5 people, preferably many more.
 
 2.	Try to release a few ALPHA test versions to the net. Announce
@@ -25,7 +27,7 @@ trivial patch so apply some common sense.
 	testing and await feedback.
 
 5.	Make a patch available to the relevant maintainer in the list. Use
-	'diff -u' to make the patch easy to merge. Be prepared to get your
+	``diff -u`` to make the patch easy to merge. Be prepared to get your
 	changes sent back with seemingly silly requests about formatting
 	and variable names.  These aren't as silly as they seem. One
 	job the maintainers (and especially Linus) do is to keep things
@@ -38,7 +40,7 @@ trivial patch so apply some common sense.
 	See Documentation/process/coding-style.rst for guidance here.
 
 	PLEASE CC: the maintainers and mailing lists that are generated
-	by scripts/get_maintainer.pl.  The results returned by the
+	by ``scripts/get_maintainer.pl.`` The results returned by the
 	script will be best if you have git installed and are making
 	your changes in a branch derived from Linus' latest git tree.
 	See Documentation/process/submitting-patches.rst for details.
@@ -70,26 +72,27 @@ trivial patch so apply some common sense.
 	not represent an immediate threat and are better handled publicly,
 	and ideally, should come with a patch proposal. Please do not send
 	automated reports to this list either. Such bugs will be handled
-	better and faster in the usual public places.
+	better and faster in the usual public places. See
+	Documentation/admin-guide/security-bugs.rst for details.
 
 8.	Happy hacking.
 
-Descriptions of section entries:
+Descriptions of section entries
+-------------------------------
 
-	P: Person (obsolete)
-	M: Mail patches to: FullName <address@domain>
-	R: Designated reviewer: FullName <address@domain>
+	M: *Mail* patches to: FullName <address@domain>
+	R: Designated *Reviewer*: FullName <address@domain>
 	   These reviewers should be CCed on patches.
-	L: Mailing list that is relevant to this area
-	W: Web-page with status/info
-	B: URI for where to file bugs. A web-page with detailed bug
+	L: *Mailing list* that is relevant to this area
+	W: *Web-page* with status/info
+	B: URI for where to file *bugs*. A web-page with detailed bug
 	   filing info, a direct bug tracker link, or a mailto: URI.
-	C: URI for chat protocol, server and channel where developers
+	C: URI for *chat* protocol, server and channel where developers
 	   usually hang out, for example irc://server/channel.
-	Q: Patchwork web based patch tracking system site
-	T: SCM tree type and location.
+	Q: *Patchwork* web based patch tracking system site
+	T: *SCM* tree type and location.
 	   Type is one of: git, hg, quilt, stgit, topgit
-	S: Status, one of the following:
+	S: *Status*, one of the following:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
@@ -99,13 +102,13 @@ Descriptions of section entries:
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
-	F: Files and directories with wildcard patterns.
+	F: *Files* and directories wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net
 	   F:	drivers/net/*	all files in drivers/net, but not below
 	   F:	*/net/*		all files in "any top level directory"/net
 	   One pattern per line.  Multiple F: lines acceptable.
-	N: Files and directories with regex patterns.
+	N: Files and directories *Regex* patterns.
 	   N:	[^a-z]tegra	all files whose path contains the word tegra
 	   One pattern per line.  Multiple N: lines acceptable.
 	   scripts/get_maintainer.pl has different behavior for files that
@@ -113,14 +116,14 @@ Descriptions of section entries:
 	   get_maintainer will not look at git log history when an F: pattern
 	   match occurs.  When an N: match occurs, git log history is used
 	   to also notify the people that have git commit signatures.
-	X: Files and directories that are NOT maintained, same rules as F:
-	   Files exclusions are tested before file matches.
+	X: *Excluded* files and directories that are NOT maintained, same
+	   rules as F:. Files exclusions are tested before file matches.
 	   Can be useful for excluding a specific subdirectory, for instance:
 	   F:	net/
 	   X:	net/ipv6/
 	   matches all files in and below net excluding net/ipv6/
-	K: Keyword perl extended regex pattern to match content in a
-	   patch or file.  For instance:
+	K: *Content regex* (perl extended) pattern match in a patch or file.
+	   For instance:
 	   K: of_get_profile
 	      matches patches or files that contain "of_get_profile"
 	   K: \b(printk|pr_(info|err))\b
@@ -128,13 +131,12 @@ Descriptions of section entries:
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
 
-Note: For the hard of thinking, this list is meant to remain in alphabetical
-order. If you could add yourselves to it in alphabetical order that would be
-so much easier [Ed]
-
-Maintainers List (try to look for most precise areas first)
+Maintainers List
+----------------
 
-		-----------------------------------
+.. note:: When reading this list, please look for the most precise areas
+          first. When adding to this list, please keep the entries in
+          alphabetical order.
 
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@kernel.org>
-- 
2.17.1

