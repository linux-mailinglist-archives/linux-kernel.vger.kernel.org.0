Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A508FBA66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfKMVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:03:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKMVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:19 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmL-00066g-T0; Wed, 13 Nov 2019 22:02:18 +0100
Message-Id: <20191113210104.404509322@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 07/20] x86/ioperm: Avoid bitmap allocation if no
 permissions are set
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ioperm() is invoked the first time and the @turn_on argument is 0, then
there is no point to allocate a bitmap just to clear permissions which are
not set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Split out from large combo patch
---
 arch/x86/kernel/ioport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -36,6 +36,9 @@ long ksys_ioperm(unsigned long from, uns
 	 */
 	bitmap = t->io_bitmap_ptr;
 	if (!bitmap) {
+		/* No point to allocate a bitmap just to clear permissions */
+		if (!turn_on)
+			return 0;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap)
 			return -ENOMEM;


