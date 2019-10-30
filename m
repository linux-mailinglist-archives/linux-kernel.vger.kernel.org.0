Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3527CE970A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 08:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfJ3HJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 03:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfJ3HJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:09:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC4120874;
        Wed, 30 Oct 2019 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572419355;
        bh=wu1a035odmEKhNaKNAU3jTqvdQ+vw9LIaPSIO4MjlKs=;
        h=From:To:Cc:Subject:Date:From;
        b=dPSH0DIx7R/GZ1BjIa217l081dXfFM30mVsX77gTLBU+Ga3hvk/whgEgtKOzAr3ZC
         y1fedqc24gxgKejkMZ7v2xe8RDs6ZvkrLAP0iRogolfTA6/S67Q3yLwXARRy8QaWpD
         IDg2vLYCkKVWCPtxScxuBT/jtC4yihC9Prf5V2AY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/4] perf probe: Fixes bugs in show-lines and show vars etc.
Date:   Wed, 30 Oct 2019 16:09:10 +0900
Message-Id: <157241935028.32002.10228194508152968737.stgit@devnote2>
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

Here are some more patches for fixing bugs which I found
while testing it.

 - [1/4]: I found that the debuginfo had precise line information
	but including non-statement and end-of-sequence entries.
	Those must be ignored because not represent target line.

 - [2/4]: I also found that there is GNU_call_site DIEs in debuginfo,
	which represents the location which calls another function.
	Since it is not an instance of inlined function, it must be
	ignored while searching instances of inlined function.

 - [3/4]: However, while listing up the available lines, we also need
	to show the lines calling another function. So if call_line and
	call_file attribute are same as line information, it shows that
	line as available.

 - [4/4]: It's a small fix to skip overlapped location while showing
	available variables.


Thank you,

---

Masami Hiramatsu (4):
      perf probe: Skip end-of-sequence and non statement lines
      perf probe: Filter out instances except for inlined subroutine and subprogram
      perf probe: Fix to show calling lines of inlined functions
      perf probe: Skip overlapped location on searching variables


 tools/perf/util/dwarf-aux.c    |   36 +++++++++++++++++++++++++++++-------
 tools/perf/util/probe-finder.c |   20 ++++++++++++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
