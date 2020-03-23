Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59D18FD13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCWSvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:51:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46910 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgCWSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:51:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGSA6-0013ex-06; Mon, 23 Mar 2020 18:50:58 +0000
Date:   Mon, 23 Mar 2020 18:50:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCHSET] futex uaccess cleanups
Message-ID: <20200323185057.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        As it is, arch_futex_atomic_op_inuser() has access_ok() done by
the (only) caller.  It would be better off closer to the actual user
memory access, as it is already done for futex_atomic_cmpxchg_inatomic().
And just as for futex_atomic_cmpxchg_inatomic() we can take
pagefault_{disable,enable}() into the caller.  Doing that brings
access_ok() and whatever an architecture needs to do to enable
the actual userland memory access into the same level; e.g. for x86
we can immediately convert them to user_access_begin/user_access_end
pair.
        Also in this series: removal of user_atomic_cmpxchg_inatomic().
The only remaining user had been futex_atomic_cmpxchg_inatomic() and
it doesn't require that kind of polymorphism.  It used to have callers
in MPX (and had been introduced for the sake of those), but MPX is
gone now and nobody else has ever made use of that primitive.

	Please, review.  This stuff lives in vfs.git#next.uaccess-3,
individual patches in followups.  The branch is based at #next.uaccess-2,
diffstat is
 arch/alpha/include/asm/futex.h      |  5 +-
 arch/arc/include/asm/futex.h        |  5 +-
 arch/arm/include/asm/futex.h        |  5 +-
 arch/arm64/include/asm/futex.h      |  5 +-
 arch/hexagon/include/asm/futex.h    |  5 +-
 arch/ia64/include/asm/futex.h       |  5 +-
 arch/microblaze/include/asm/futex.h |  5 +-
 arch/mips/include/asm/futex.h       |  5 +-
 arch/nds32/include/asm/futex.h      |  6 +--
 arch/openrisc/include/asm/futex.h   |  5 +-
 arch/parisc/include/asm/futex.h     |  2 -
 arch/powerpc/include/asm/futex.h    |  5 +-
 arch/riscv/include/asm/futex.h      |  5 +-
 arch/s390/include/asm/futex.h       |  2 -
 arch/sh/include/asm/futex.h         |  4 --
 arch/sparc/include/asm/futex_64.h   |  4 --
 arch/x86/include/asm/futex.h        | 38 ++++++++++-----
 arch/x86/include/asm/uaccess.h      | 93 -------------------------------------
 arch/xtensa/include/asm/futex.h     |  5 +-
 include/asm-generic/futex.h         |  2 -
 kernel/futex.c                      |  5 +-
 tools/objtool/check.c               |  1 +
 22 files changed, 58 insertions(+), 159 deletions(-)
Shortlog:
	futex: arch_futex_atomic_op_inuser() calling conventions change
	sh: no need of access_ok() in arch_futex_atomic_op_inuser()
	[parisc, s390, sparc64] no need for access_ok() in futex handling
	objtool: whitelist __sanitizer_cov_trace_switch()
	x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
	generic arch_futex_atomic_op_inuser() doesn't need access_ok()
	x86: get rid of user_atomic_cmpxchg_inatomic()
