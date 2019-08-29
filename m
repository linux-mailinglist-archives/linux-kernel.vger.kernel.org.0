Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A1A15D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfH2KXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 06:23:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbfH2KXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:23:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5148EB0B3;
        Thu, 29 Aug 2019 10:23:48 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Disable compat cruft on ppc64le v4
Date:   Thu, 29 Aug 2019 12:23:39 +0200
Message-Id: <cover.1567072270.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Less code means less bugs so add a knob to skip the compat stuff.

This is tested on ppc64le top of

https://patchwork.ozlabs.org/cover/1153556/

Changes in v2: saner CONFIG_COMPAT ifdefs
Changes in v3:
 - change llseek to 32bit instead of builing it unconditionally in fs
 - clanup the makefile conditionals
 - remove some ifdefs or convert to IS_DEFINED where possible
Changes in v4:
 - cleanup is_32bit_task and current_is_64bit
 - more makefile cleanup

Michal Suchanek (4):
  powerpc: make llseek 32bit-only.
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.

 arch/powerpc/Kconfig                     |   5 +-
 arch/powerpc/include/asm/thread_info.h   |   4 +-
 arch/powerpc/kernel/Makefile             |   7 +-
 arch/powerpc/kernel/entry_64.S           |   2 +
 arch/powerpc/kernel/signal.c             | 144 ++++++++++++++++++++++-
 arch/powerpc/kernel/signal_32.c          | 140 ----------------------
 arch/powerpc/kernel/syscall_64.c         |   6 +-
 arch/powerpc/kernel/syscalls/syscall.tbl |   2 +-
 arch/powerpc/kernel/vdso.c               |   5 +-
 arch/powerpc/perf/callchain.c            |  14 ++-
 10 files changed, 167 insertions(+), 162 deletions(-)

-- 
2.22.0

