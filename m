Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF22A67EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfGNMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 08:02:08 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51676 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:02:08 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 69FDE72CA65;
        Sun, 14 Jul 2019 15:02:06 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5C4D37CCE3A; Sun, 14 Jul 2019 15:02:06 +0300 (MSK)
Date:   Sun, 14 Jul 2019 15:02:06 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] clone: fix CLONE_PIDFD support
Message-ID: <20190714120206.GC6773@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of clone3 syscall accidentally broke CLONE_PIDFD
support in traditional clone syscall on compat x86 and those
architectures that use do_fork to implement clone syscall.

This bug was found by strace test suite.

Link: https://strace.io/logs/strace/2019-07-12
Fixes: 7f192e3cd316 ("fork: add clone3")
Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/x86/ia32/sys_ia32.c | 1 +
 kernel/fork.c            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 64a6c952091e..98754baf411a 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
diff --git a/kernel/fork.c b/kernel/fork.c
index 8f3e2d97d771..2c3cbad807b6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2417,6 +2417,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
-- 
ldv
