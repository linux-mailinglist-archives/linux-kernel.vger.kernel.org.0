Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADFA07B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfH1QoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 12:44:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbfH1Qn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:43:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4994DB038;
        Wed, 28 Aug 2019 16:43:57 +0000 (UTC)
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
Subject: [PATCH v3 1/4] powerpc: make llseek 32bit-only.
Date:   Wed, 28 Aug 2019 18:43:48 +0200
Message-Id: <a45fd1f3c40dff0851b27ee48e173eec9e4a5bac.1567007242.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567007242.git.msuchanek@suse.de>
References: <cover.1567007242.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: aff850393200 ("powerpc: add system call table generation support")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 010b9f445586..53e427606f6c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -188,7 +188,7 @@
 137	common	afs_syscall			sys_ni_syscall
 138	common	setfsuid			sys_setfsuid
 139	common	setfsgid			sys_setfsgid
-140	common	_llseek				sys_llseek
+140	32	_llseek				sys_llseek
 141	common	getdents			sys_getdents			compat_sys_getdents
 142	common	_newselect			sys_select			compat_sys_select
 143	common	flock				sys_flock
-- 
2.22.0

