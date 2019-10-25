Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607E2E4612
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408441AbfJYIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733196AbfJYIqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73AF721D71;
        Fri, 25 Oct 2019 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993179;
        bh=KXJuP0pUFHkbCI10hjxJRzAuKi8BeiA9tc/QElt9k7A=;
        h=From:To:Cc:Subject:Date:From;
        b=gW6jT9zs+Q5/FnePhz6og8pWtkIbo0Hs3h3hnvGjZ437NOZaCu3N+N3UPZLIv1kv+
         B+xp2T2v9/iLjbbyADhjFw3kWZQu5Q4jaJfCc9OEonzyraxNrBd71fxWs8bjTzDcNO
         zS64fw324s15njtrkr55JLJPd4AvCVxCA2TZx5wU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/6] perf/probe: Additional fixes for range only functions
Date:   Fri, 25 Oct 2019 17:46:15 +0900
Message-Id: <157199317547.8075.1010940983970397945.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Here are some bugfixes for the bugs you found in previous series
and similar one.

I found that there are some dwarf_entrypc() related bugs in perf
probe and fixed all except one special add-hoc code in
convert_variable_location()(*).

This time I embedded before-and-after examples in each commit.
Please check it how to reproduce it.

(*) This had been introduced for fixup fentry related gcc bug,
see commit 3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed
parameter location") for detail. Nowadays gcc already fixed
this issue and this seems like a dead code. Moreover, it is not
sure such old gcc can generate DIE without entry_pc attribute.
So I decided not to touch it.

Thank you,

---

Masami Hiramatsu (6):
      perf/probe: Fix wrong address verification
      perf/probe: Fix to probe a function which has no entry pc
      perf/probe: Fix to probe an inline function which has no entry pc
      perf/probe: Fix to list probe event with correct line number
      perf/probe: Fix to show inlined function callsite without entry_pc
      perf/probe: Fix to show ranges of variables in functions without entry_pc


 tools/perf/util/dwarf-aux.c    |    6 +++---
 tools/perf/util/probe-finder.c |   40 ++++++++++++++--------------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
