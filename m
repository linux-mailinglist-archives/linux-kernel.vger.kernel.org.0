Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AB2227B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfERJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:07:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfERJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:07:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I96WpG1736514
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:06:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I96WpG1736514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170393;
        bh=9zqVUjn47Dc4BbmiyFbCYdX7H1EhW9w8ZoQE84WqBTs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=npT9Bmpe2K35Fe8SHxJa53pBVIUuAMwilbXS7+JXtRtDoHYvCDnflWXpWkBL88HJR
         hnUrF5tvB6bFwaNolHaOCcOyBeqoz9haLhDuuVF4JGHWvZM9cmUWtO6Yn73MjIXfoj
         RiOcpi21vVN8aMww9Z/SWbtJIW77feZSNbtx+pe6RaD8uazwkn9843p/9r+ilgaRNx
         tCdW0EU1zbgLVxdxdkpUZt/n3DAZQxPrTcvVL4LpR8tfPKWuPZvoPODpXUZs5rgsV0
         SnuzU7LMmZp1N0oKRGWkf1pXJnWimrKESlWhpoVgMa33snLr4ESzXdadIrl30Jm6iZ
         66V8QgK1HAQzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I96WgM1736511;
        Sat, 18 May 2019 02:06:32 -0700
Date:   Sat, 18 May 2019 02:06:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-db5570e5e30aa2362fc34f5ee3b4b741362d41fa@git.kernel.org>
Cc:     tstoyanov@vmware.com, rostedt@goodmis.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de,
          namhyung@kernel.org, jolsa@redhat.com, rostedt@goodmis.org,
          tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190510200107.536391771@goodmis.org>
References: <20190510200107.536391771@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for event handler
 APIs
Git-Commit-ID: db5570e5e30aa2362fc34f5ee3b4b741362d41fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  db5570e5e30aa2362fc34f5ee3b4b741362d41fa
Gitweb:     https://git.kernel.org/tip/db5570e5e30aa2362fc34f5ee3b4b741362d41fa
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:17 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for event handler APIs

Create man pages for libtraceevent APIs:

  tep_register_event_handler()
  tep_unregister_event_handler()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-11-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.536391771@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-reg_event_handler.txt            | 156 +++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt b/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
new file mode 100644
index 000000000000..53d37d72a1c1
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
@@ -0,0 +1,156 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_register_event_handler, tep_unregister_event_handler -  Register /
+unregisters a callback function to parse an event information.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_reg_handler* {
+	_TEP_REGISTER_SUCCESS_,
+	_TEP_REGISTER_SUCCESS_OVERWRITE_,
+};
+
+int *tep_register_event_handler*(struct tep_handle pass:[*]_tep_, int _id_, const char pass:[*]_sys_name_, const char pass:[*]_event_name_, tep_event_handler_func _func_, void pass:[*]_context_);
+int *tep_unregister_event_handler*(struct tep_handle pass:[*]tep, int id, const char pass:[*]sys_name, const char pass:[*]event_name, tep_event_handler_func func, void pass:[*]_context_);
+
+typedef int (*pass:[*]tep_event_handler_func*)(struct trace_seq pass:[*]s, struct tep_record pass:[*]record, struct tep_event pass:[*]event, void pass:[*]context);
+--
+
+DESCRIPTION
+-----------
+The _tep_register_event_handler()_ function registers a handler function,
+which is going to be called to parse the information for a given event.
+The _tep_ argument is the trace event parser context. The _id_ argument is
+the id of the event. The _sys_name_ argument is the name of the system,
+the event belongs to. The _event_name_ argument is the name of the event.
+If _id_ is >= 0, it is used to find the event, otherwise _sys_name_ and
+_event_name_ are used. The _func_ is a pointer to the function, which is going
+to be called to parse the event information. The _context_ argument is a pointer
+to the context data, which will be passed to the _func_. If a handler function
+for the same event is already registered, it will be overridden with the new
+one. This mechanism allows a developer to override the parsing of a given event.
+If for some reason the default print format is not sufficient, the developer
+can register a function for an event to be used to parse the data instead.
+
+The _tep_unregister_event_handler()_ function unregisters the handler function,
+previously registered with _tep_register_event_handler()_. The _tep_ argument
+is the trace event parser context. The _id_, _sys_name_, _event_name_, _func_,
+and _context_ are the same arguments, as when the callback function _func_ was
+registered.
+
+The _tep_event_handler_func_ is the type of the custom event handler
+function. The _s_ argument is the trace sequence, it can be used to create a
+custom string, describing the event. A _record_  to get the event from is passed
+as input parameter and also the _event_ - the handle to the record's event. The
+_context_ is custom context, set when the custom event handler is registered.
+
+RETURN VALUE
+------------
+The _tep_register_event_handler()_ function returns _TEP_REGISTER_SUCCESS_
+if the new handler is registered successfully or
+_TEP_REGISTER_SUCCESS_OVERWRITE_ if an existing handler is overwritten.
+If there is not  enough memory to complete the registration,
+TEP_ERRNO__MEM_ALLOC_FAILED is returned.
+
+The _tep_unregister_event_handler()_ function returns 0 if _func_ was removed
+successful or, -1 if the event was not found.
+
+The _tep_event_handler_func_ should return -1 in case of an error,
+or 0 otherwise.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+#include <trace-seq.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+int timer_expire_handler(struct trace_seq *s, struct tep_record *record,
+			 struct tep_event *event, void *context)
+{
+	trace_seq_printf(s, "hrtimer=");
+
+	if (tep_print_num_field(s, "0x%llx", event, "timer", record, 0) == -1)
+		tep_print_num_field(s, "0x%llx", event, "hrtimer", record, 1);
+
+	trace_seq_printf(s, " now=");
+
+	tep_print_num_field(s, "%llu", event, "now", record, 1);
+
+	tep_print_func_field(s, " function=%s", event, "function", record, 0);
+
+	return 0;
+}
+...
+	int ret;
+
+	ret = tep_register_event_handler(tep, -1, "timer", "hrtimer_expire_entry",
+					 timer_expire_handler, NULL);
+	if (ret < 0) {
+		char buf[32];
+
+		tep_strerror(tep, ret, buf, 32)
+		printf("Failed to register handler for hrtimer_expire_entry: %s\n", buf);
+	} else {
+		switch (ret) {
+		case TEP_REGISTER_SUCCESS:
+			printf ("Registered handler for hrtimer_expire_entry\n");
+			break;
+		case TEP_REGISTER_SUCCESS_OVERWRITE:
+			printf ("Overwrote handler for hrtimer_expire_entry\n");
+			break;
+		}
+	}
+...
+	ret = tep_unregister_event_handler(tep, -1, "timer", "hrtimer_expire_entry",
+					   timer_expire_handler, NULL);
+	if ( ret )
+		printf ("Failed to unregister handler for hrtimer_expire_entry\n");
+
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*trace-seq.h*
+	Header file to include in order to have access to trace sequences
+	related APIs. Trace sequences are used to allow a function to call
+	several other functions to create a string of data to use.
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
