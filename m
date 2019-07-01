Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073561A392
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfEJUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 16:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbfEJUBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:01:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CC2218B0;
        Fri, 10 May 2019 20:01:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hPBhb-0006hw-AY; Fri, 10 May 2019 16:01:07 -0400
Message-Id: <20190510200107.218173559@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 10 May 2019 15:56:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 09/27] tools/lib/traceevent: Man page for page size APIs
References: <20190510195606.537643615@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Create man pages for libtraceevent APIs:
  tep_get_page_size()
  tep_set_page_size()

Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-9-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../Documentation/libtraceevent-page_size.txt | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
new file mode 100644
index 000000000000..452c0cfa1822
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
@@ -0,0 +1,82 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_page_size, tep_set_page_size - Get / set the size of a memory page on
+the machine, where the trace is generated
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_get_page_size*(struct tep_handle pass:[*]_tep_);
+void *tep_set_page_size*(struct tep_handle pass:[*]_tep_, int _page_size_);
+--
+
+DESCRIPTION
+-----------
+The _tep_get_page_size()_ function returns the size of a memory page on
+the machine, where the trace is generated. The _tep_ argument is trace
+event parser context.
+
+The _tep_set_page_size()_ function stores in the _tep_ context the size of a
+memory page on the machine, where the trace is generated.
+The _tep_ argument is trace event parser context.
+The _page_size_ argument is the size of a memory page, in bytes.
+
+RETURN VALUE
+------------
+The _tep_get_page_size()_ function returns size of the memory page, in bytes.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <unistd.h>
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	int page_size = getpagesize();
+
+	tep_set_page_size(tep, page_size);
+
+	printf("The page size for this machine is %d\n", tep_get_page_size(tep));
+
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*-ltraceevent*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtraceevent(3)_, _trace-cmd(1)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtraceevent is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1


