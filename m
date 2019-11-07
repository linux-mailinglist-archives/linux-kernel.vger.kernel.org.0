Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4CFF349B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfKGQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKGQ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:27:53 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33725214D8;
        Thu,  7 Nov 2019 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573144073;
        bh=6V33I/CbC9scqkL+yAKQkI5e5SvV8zhCoIW63U6j6pU=;
        h=From:To:Cc:Subject:Date:From;
        b=W99uIl/+aFt07anrqVOKd4U8Cv6kF2DNOiasnEfo+0MjHMgfriPvAPVQmkjHfYUI3
         s0XqWE+OLR+w8fRn+Z/4UAhDTOQtmpDd6rkJjVy06bhZKThGckyJ3SJ5W31gvfHIy8
         2wWA29qDB3ZVmmxIV+uZJX+hpMlz7lNPWFyrNUxU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 0/4] perf/probe: Support multiprobe and immediates
Date:   Fri,  8 Nov 2019 01:27:48 +0900
Message-Id: <157314406866.4063.16995747442215702109.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 2nd version of the multiprobe support on perf probe.

This can be applied on top of perf/core.

Inlined functions or the lines which have multiple statements can
be compiled in multiple addresses. Current perf probe generates
different events for each address, but this is not useful for
users.

Since ftrace multiprobe per event support is on upstream kernel,
it is a time to push this series. In this version, I have updated
the [1/4] not to add suffix _L* if user doesn't specify the line
number for the function or the line number is 0. And also,
[4/4] is updated according to [1/4] change.

The previous version is here.

https://lkml.kernel.org/r/157291299825.19771.5190465639558208592.stgit@devnote2

Thank you,

---

Masami Hiramatsu (4):
      perf probe: Generate event name with line number
      perf probe: Support multiprobe event
      perf probe: Support DW_AT_const_value constant value
      perf probe: Trace a magic number if variable is not found


 tools/perf/util/probe-event.c  |   19 +++++++++-
 tools/perf/util/probe-event.h  |    3 ++
 tools/perf/util/probe-file.c   |   14 ++++++++
 tools/perf/util/probe-file.h   |    2 +
 tools/perf/util/probe-finder.c |   73 ++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/probe-finder.h |    1 +
 6 files changed, 105 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
