Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA927315
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 02:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfEWADy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 20:03:54 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13601 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbfEWADx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:03:53 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 May 2019 17:03:38 -0700
Received: from rlwimi.localdomain (unknown [10.129.221.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id F1DAEB2031;
        Wed, 22 May 2019 20:03:51 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool conversion
Date:   Wed, 22 May 2019 17:03:23 -0700
Message-ID: <cover.1558569448.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
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

 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  22 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   1 +
 tools/objtool/Makefile                     |   7 +-
 tools/objtool/builtin-mcount.c             |  72 +++++
 tools/objtool/builtin-mcount.h             |  23 ++
 tools/objtool/builtin.h                    |   6 +
 tools/objtool/objtool.c                    |   6 +
 {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
 {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
 {scripts => tools/objtool}/recordmcount.pl |   0
 13 files changed, 420 insertions(+), 267 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h
 rename {scripts => tools/objtool}/recordmcount.c (78%)
 rename {scripts => tools/objtool}/recordmcount.h (78%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

-- 
2.20.1

