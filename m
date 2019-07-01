Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7641814
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 00:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436824AbfFKWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 18:22:17 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:28995 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436772AbfFKWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:13 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:08 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 60A7F41BAB;
        Tue, 11 Jun 2019 15:22:11 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 00/13] Cleanup recordmcount and begin objtool conversion
Date:   Tue, 11 Jun 2019 15:21:42 -0700
Message-ID: <cover.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up recordmcount and then makes it into
an objtool subcommand.

The series starts with 8 cleanup patches which make recordmcount
easier to review and integrate with objtool. The final 5 patches
show the beginning steps of converting recordmcount to use objtool's
ELF code rather than its own open-coded methods of accessing ELF
files.

---

v2:
	Fix whitespace before line continuation

	Add ftrace/mcount/record.h to objtool_dep

	Rename the Makefile variable BUILD_C_RECORDMCOUNT to
	    better reflect its purpose

	Similar: rename recordmcount_source => recordmcount_dep
	    When using objtool we can just depend on the
	    binary rather than the source the binary is
	    built from. This should address Josh's feedback and
	    make the Makefile code a bit clearer

	Add a comment to make reading the Makefile a little
	    easier

	Rebased to latest mainline -rc

	Collected some build time measurements

Build times measurements -- median of multiple runs in a VM measured
with "time":

	mainline (5.2.0-rc4) build times (median of 3 runs):
		real    2m58.379s
		user    2m29.621s
		sys     1m35.116s

	Post recordmcount-cleanup build times (median of 5 runs):
		real    2m51.973s
		user    2m29.094s
		sys     1m33.688s
		
	objtool mcount build times (median of 7 runs):
		real	2m57.92s
		user	2m33.73s
		sys	1m37.06s

Note: I saw some significant variation especially in the "real" time
	measurements probably because it was in a VM on a machine with
	various "idle" GUI tasks running. This is why I took the median
	rather than the mean. Though I haven't run the statistics, my
	sense is the numbers don't support concluding that things really
	got any faster or slower.

I'm working on a separate, follow-on RFC set which implements the
pseudo-pipe idea.

Matt Helsley (13):
  recordmcount: Remove redundant strcmp
  recordmcount: Remove uread()
  recordmcount: Remove unused fd from uwrite() and ulseek()
  recordmcount: Rewrite error/success handling
  recordmcount: Kernel style function signature formatting
  recordmcount: Kernel style formatting
  recordmcount: Remove redundant cleanup() calls
  recordmcount: Clarify what cleanup() does
  objtool: Prepare to merge recordmcount
  objtool: Make recordmcount into an objtool subcmd
  objtool: recordmcount: Start using objtool's elf wrapper
  objtool: recordmcount: Search for __mcount_loc before walking the
    sections
  objtool: recordmcount: Convert do_func() relhdrs

 Makefile                                   |   6 +-
 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  27 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   1 +
 tools/objtool/Makefile                     |   1 +
 tools/objtool/builtin-mcount.c             |  72 +++++
 tools/objtool/builtin-mcount.h             |  23 ++
 tools/objtool/builtin.h                    |   1 +
 tools/objtool/objtool.c                    |   1 +
 {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
 {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
 {scripts => tools/objtool}/recordmcount.pl |   0
 14 files changed, 407 insertions(+), 275 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h
 rename {scripts => tools/objtool}/recordmcount.c (78%)
 rename {scripts => tools/objtool}/recordmcount.h (78%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

-- 
2.20.1

