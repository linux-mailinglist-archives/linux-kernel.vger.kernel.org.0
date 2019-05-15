Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29321E6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 04:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEOC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 22:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEOC2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 22:28:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8EE2084F;
        Wed, 15 May 2019 02:28:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQjef-0005My-Fk; Tue, 14 May 2019 22:28:29 -0400
Message-Id: <20190515022747.719887946@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 May 2019 22:27:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Final updates for this merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 693713cbdb3a4bda5a8a678c31f06560bbb14657


Jiri Kosina (1):
      livepatch: Remove klp_check_compiler_support()

Linus Torvalds (1):
      tracing: Simplify "if" macro code

Steven Rostedt (VMware) (3):
      ftrace/x86_32: Remove support for non DYNAMIC_FTRACE
      ftrace/x86: Remove mcount support
      x86: Hide the int3_emulate_call/jmp functions from UML

----
 arch/powerpc/include/asm/livepatch.h |  5 ---
 arch/s390/include/asm/livepatch.h    |  5 ---
 arch/x86/Kconfig                     | 11 ++++++
 arch/x86/include/asm/ftrace.h        |  8 ++--
 arch/x86/include/asm/livepatch.h     |  8 ----
 arch/x86/include/asm/text-patching.h |  4 +-
 arch/x86/kernel/ftrace_32.S          | 75 +++---------------------------------
 arch/x86/kernel/ftrace_64.S          | 28 +-------------
 include/linux/compiler.h             | 35 +++++++++--------
 kernel/livepatch/core.c              |  8 ----
 10 files changed, 41 insertions(+), 146 deletions(-)
