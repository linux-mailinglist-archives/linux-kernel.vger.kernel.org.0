Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73EA8263A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfHEUn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 16:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfHEUn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:43:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55F02086D;
        Mon,  5 Aug 2019 20:43:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hujpi-0008Qh-Vf; Mon, 05 Aug 2019 16:43:55 -0400
Message-Id: <20190805204312.169565525@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 05 Aug 2019 16:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrick McLean <chutzpah@gentoo.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 0/3] tools lib traceevent: Fixing the API to be less policy driven
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo and Jiri,

We are still working on getting libtraceevent ready to be a stand alone
library. Part of that is to audit all the interfaces. We noticed
that the most the tep_print_*() interfaces define policy and limit
the way an application can display data. Instead of fixing this later
and being stuck with a limiting API that we must maintain for backward
compatibility, we removed and replaced most of it. perf was only affected
by a single function that was removed. These functions are replaced
by a more flexible one that allows the user to place what they want
where they want it (timestamps, event info, latency format, COMM, PID, etc).

The other noticeable perf change, is that we changed the location to
where the plugins are loaded from:

 ${HOME}/.traceevent/plugins

to

 ${HOME}/.local/lib/traceevent/plugins

As Patrick McLean (Gentoo package maintainer) informed us of the
XGD layout.

Should we have something the warns people if they have plugins in
the old directory. Should we move them on install? Currently, we
just ignore them.

Anyway, please add these patches to tip.

Thanks!

-- Steve


Tzvetomir Stoyanov (3):
      tools/lib/traceevent, tools/perf: Changes in tep_print_event_* APIs
      tools/lib/traceevent: Remove tep_register_trace_clock()
      tools/lib/traceevent: Change user's plugin directory

----
 tools/lib/traceevent/Makefile            |   6 +-
 tools/lib/traceevent/event-parse-api.c   |  40 ----
 tools/lib/traceevent/event-parse-local.h |   6 -
 tools/lib/traceevent/event-parse.c       | 333 +++++++++++++++++--------------
 tools/lib/traceevent/event-parse.h       |  30 +--
 tools/lib/traceevent/event-plugin.c      |   2 +-
 tools/perf/builtin-kmem.c                |   3 +-
 tools/perf/util/sort.c                   |   3 +-
 tools/perf/util/trace-event-parse.c      |   2 +-
 9 files changed, 207 insertions(+), 218 deletions(-)
