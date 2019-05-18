Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99922285
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfERJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:10:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:10:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9AEQD1737092
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:10:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9AEQD1737092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170615;
        bh=y/SZrLDa16BVSv06DSM7fze2hXZjaJhPKvs2RkAQrn0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MIDVx9eZQsdIl4p9rFl5vytRhU1qx5xbuvOtO4Yuml9rbN2n+aFoXXDVq3Kxtk41D
         ffjriyVrftAj9+5EYdqzeTAIuwQRauADovG8RwIldnrM78v1yHzQX4pmDGJo2KtAKW
         foJ0FwwUKQc5ywJ3yZTDWZT/SHSWBIdZT3xG71LwRnoNWj2F6DfF2/zLV0Pa22yRnU
         WxrkrtBoJFhdgXo1OBfB/kDtxDh6UnBMDbA9v4si9Gnv0a9UCvi361YYjlv+50zHxr
         zFIxDAylIWmlZYuC/slnxANwcvGvZkH+7JelxNyGpeylPph5qAEdDrE9MJ/nRwtG9y
         oasUda/iUd4QA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9ADwA1737089;
        Sat, 18 May 2019 02:10:13 -0700
Date:   Sat, 18 May 2019 02:10:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-7935c316ef067881ee4043c4c7d611e982e5fe21@git.kernel.org>
Cc:     tstoyanov@vmware.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org, rostedt@goodmis.org
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tstoyanov@vmware.com, namhyung@kernel.org,
          akpm@linux-foundation.org, mingo@kernel.org, rostedt@goodmis.org,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190510200108.367633707@goodmis.org>
References: <20190510200108.367633707@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for list events APIs
Git-Commit-ID: 7935c316ef067881ee4043c4c7d611e982e5fe21
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

Commit-ID:  7935c316ef067881ee4043c4c7d611e982e5fe21
Gitweb:     https://git.kernel.org/tip/7935c316ef067881ee4043c4c7d611e982e5fe21
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:22 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man page for list events APIs

Create man page for libtraceevent APIs:

  tep_list_events()
  tep_list_events_copy()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-16-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.367633707@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-event_list.txt     | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
new file mode 100644
index 000000000000..fba350e5a4cb
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
@@ -0,0 +1,122 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_list_events, tep_list_events_copy -
+Get list of events, sorted by given criteria.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_event_sort_type* {
+	_TEP_EVENT_SORT_ID_,
+	_TEP_EVENT_SORT_NAME_,
+	_TEP_EVENT_SORT_SYSTEM_,
+};
+
+struct tep_event pass:[*]pass:[*]*tep_list_events*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
+struct tep_event pass:[*]pass:[*]*tep_list_events_copy*(struct tep_handle pass:[*]_tep_, enum tep_event_sort_type _sort_type_);
+--
+
+DESCRIPTION
+-----------
+The _tep_list_events()_ function returns an array of pointers to the events,
+sorted by the _sort_type_ criteria. The last element of the array is NULL.
+The returned memory must not be freed, it is managed by the library.
+The function is not thread safe. The _tep_ argument is trace event parser
+context. The _sort_type_ argument is the required sort criteria:
+[verse]
+--
+	_TEP_EVENT_SORT_ID_	- sort by the event ID.
+	_TEP_EVENT_SORT_NAME_	- sort by the event (name, system, id) triplet.
+	_TEP_EVENT_SORT_SYSTEM_	- sort by the event (system, name, id) triplet.
+--
+
+The _tep_list_events_copy()_ is a thread safe version of _tep_list_events()_.
+It has the same behavior, but the returned array is allocated internally and
+must be freed by the caller. Note that the content of the array must not be
+freed (see the EXAMPLE below).
+
+RETURN VALUE
+------------
+The _tep_list_events()_ function returns an array of pointers to events.
+In case of an error, NULL is returned. The returned array must not be freed,
+it is managed by the library.
+
+The _tep_list_events_copy()_ function returns an array of pointers to events.
+In case of an error, NULL is returned. The returned array must be freed by
+the caller.
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
+struct tep_event_format **events;
+
+i=0;
+events = tep_list_events(tep, TEP_EVENT_SORT_ID);
+if (events == NULL) {
+	/* Failed to get the events, sorted by ID */
+} else {
+	while(events[i]) {
+		/* walk through the list of the events, sorted by ID */
+		i++;
+	}
+}
+
+i=0;
+events = tep_list_events_copy(tep, TEP_EVENT_SORT_NAME);
+if (events == NULL) {
+	/* Failed to get the events, sorted by name */
+} else {
+	while(events[i]) {
+		/* walk through the list of the events, sorted by name */
+		i++;
+	}
+	free(events);
+}
+
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
