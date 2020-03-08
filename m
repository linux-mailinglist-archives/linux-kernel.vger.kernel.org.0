Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C413517D701
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 00:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCHXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 19:23:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCHXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:48 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gb-00033R-3n; Mon, 09 Mar 2020 00:23:30 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9B5C9104099;
        Mon,  9 Mar 2020 00:23:28 +0100 (CET)
Message-Id: <20200308222609.219366430@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:02 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 03/13] x86/entry/32: Remove unused label restore_nocheck
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1091,7 +1091,7 @@ SYM_FUNC_START(entry_INT80_32)
 	TRACE_IRQS_IRET
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
-.Lrestore_nocheck:
+
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 

