Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9C22284
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfERJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:09:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:09:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I99UiK1736972
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:09:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I99UiK1736972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170570;
        bh=22iwg4vE2A/cF38F7Fv9unq86DIk7aEhj95Y7TSiS+Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VTRu2YmLuvCB78+IpntuaG/ODp6sBZ3mSN9/6/VOz8sbJ7n+3NmfdKPHX/zErT7Ao
         PLOPXUlCMvLvvSpONBY+88F2J1NQUrECXGrOQaNeAbsxQ72EWbZDlxbgnaC/oBV3cL
         9XKcodc4ZNPiUFmiTtueQJZqPLuvK0BebjHpIJjNE9HK3sRF6zEbIfQFqKOlN1Hryq
         JXYzb/DnNPWQRWehrmYE5xqbsP3ZWyK7yCZEdULgOVH+l2g9ow1RIGM9ZSU6aMsWg9
         VMzFtaOmwsgaHFJb6uNnAIoClSh+490yQH53zWDlxep9rcqEm1Z9XMz8fBOdXXUg3P
         eN6ESLUT7eYkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I99T2K1736969;
        Sat, 18 May 2019 02:09:29 -0700
Date:   Sat, 18 May 2019 02:09:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-86e8076e93ff69213931f867878709f2c6139032@git.kernel.org>
Cc:     tstoyanov@vmware.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        namhyung@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com
Reply-To: tstoyanov@vmware.com, mingo@kernel.org,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
          jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20190510200108.197407057@goodmis.org>
References: <20190510200108.197407057@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for event find APIs
Git-Commit-ID: 86e8076e93ff69213931f867878709f2c6139032
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

Commit-ID:  86e8076e93ff69213931f867878709f2c6139032
Gitweb:     https://git.kernel.org/tip/86e8076e93ff69213931f867878709f2c6139032
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:21 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for event find APIs

Create man pages for libtraceevent APIs:

  tep_find_event()
  tep_find_event_by_name()
  tep_find_event_by_record()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-15-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.197407057@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-event_find.txt     | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
new file mode 100644
index 000000000000..7bc062c9f76f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
@@ -0,0 +1,103 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_find_event,tep_find_event_by_name,tep_find_event_by_record -
+Find events by given key.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_event pass:[*]*tep_find_event*(struct tep_handle pass:[*]_tep_, int _id_);
+struct tep_event pass:[*]*tep_find_event_by_name*(struct tep_handle pass:[*]_tep_, const char pass:[*]_sys_, const char pass:[*]_name_);
+struct tep_event pass:[*]*tep_find_event_by_record*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_record_);
+--
+
+DESCRIPTION
+-----------
+This set of functions can be used to search for an event, based on a given
+criteria. All functions require a pointer to a _tep_, trace event parser
+context.
+
+The _tep_find_event()_ function searches for an event by given event _id_. The
+event ID is assigned dynamically and can be viewed in event's format file,
+"ID" field.
+
+The tep_find_event_by_name()_ function searches for an event by given
+event _name_, under the system _sys_. If the _sys_ is NULL (not specified),
+the first event with _name_ is returned.
+
+The tep_find_event_by_record()_ function searches for an event from a given
+_record_.
+
+RETURN VALUE
+------------
+All these functions return a pointer to the found event, or NULL if there is no
+such event.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+struct tep_event *event;
+
+event = tep_find_event(tep, 1857);
+if (event == NULL) {
+	/* There is no event with ID 1857 */
+}
+
+event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
+if (event == NULL) {
+	/* There is no kvm_exit event, from kvm system */
+}
+
+void event_from_record(struct tep_record *record)
+{
+ struct tep_event *event = tep_find_event_by_record(tep, record);
+	if (event == NULL) {
+		/* There is no event from given record */
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
