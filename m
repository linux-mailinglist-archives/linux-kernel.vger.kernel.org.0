Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23B321E94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfEQTjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfEQTjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:39:23 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990CB216FD;
        Fri, 17 May 2019 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121961;
        bh=QALpDqSo+CStGUSkAJVvycXkl35xEgNlwdR0xk4NBk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0rjZTtavJIKKm4RyLyl8x+fYX1TW848Gk0EK5I03+pzZkvyGXtZ5opmWYsEF2k2q
         iYfUIY1vniuZjtpsypo4ex96buNvyNdXhg6nanslw4tCJ+wZ17+FFXtUcEulj8/Ive
         3uyAHtv+SGZcgg34lsUcnQjWUiUB8NLUCOTgNfEE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/73] tools lib traceevent: Man pages for event fields APIs
Date:   Fri, 17 May 2019 16:35:39 -0300
Message-Id: <20190517193611.4974-42-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Create man pages for libtraceevent APIs:

  tep_event_common_fields(),
  tep_event_fields()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-22-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200109.421670142@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-fields.txt    | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-fields.txt b/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
new file mode 100644
index 000000000000..1ccb531d5114
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
@@ -0,0 +1,105 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_event_common_fields, tep_event_fields - Get a list of fields for an event.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_format_field pass:[*]pass:[*]*tep_event_common_fields*(struct tep_event pass:[*]_event_);
+struct tep_format_field pass:[*]pass:[*]*tep_event_fields*(struct tep_event pass:[*]_event_);
+--
+
+DESCRIPTION
+-----------
+The _tep_event_common_fields()_ function returns an array of pointers to common
+fields for the _event_. The array is allocated in the function and must be freed
+by free(). The last element of the array is NULL.
+
+The _tep_event_fields()_ function returns an array of pointers to event specific
+fields for the _event_. The array is allocated in the function and must be freed
+by free(). The last element of the array is NULL.
+
+RETURN VALUE
+------------
+Both _tep_event_common_fields()_ and _tep_event_fields()_ functions return
+an array of pointers to tep_format_field structures in case of success, or
+NULL in case of an error.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+int i;
+struct tep_format_field **fields;
+struct tep_event *event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
+if (event != NULL) {
+	fields = tep_event_common_fields(event);
+	if (fields != NULL) {
+		i = 0;
+		while (fields[i]) {
+			/*
+			  walk through the list of the common fields
+			  of the kvm_exit event
+			*/
+			i++;
+		}
+		free(fields);
+	}
+	fields = tep_event_fields(event);
+	if (fields != NULL) {
+		i = 0;
+		while (fields[i]) {
+			/*
+			  walk through the list of the event specific
+			  fields of the kvm_exit event
+			*/
+			i++;
+		}
+		free(fields);
+	}
+}
+...
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

