Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E5A0501
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfH1Obm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:31:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1Obm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:31:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2yz5-00061s-Nj; Wed, 28 Aug 2019 16:31:39 +0200
Message-Id: <20190828142445.454151604@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 28 Aug 2019 16:24:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: [patch 0/2] x86/mm/pti: Robustness updates
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on the discussions around the patch Song submitted to 'cure' a
iTLB related performance regression, I picked up Song's patch which makes
clone_page_tables() more robust by handling unaligned addresses proper and
added one which prevents calling into the PTI code when PTI is enabled
compile time, but disabled at runtime (command line or CPU not affected).

There is no point in calling into those PTI functions unconditionally. The
resulting page tables are the same before and after the change which makes
sense as the code clones the kernel page table into the secondary page
table space which is available but not used when PTI is boot time disabled.

But even if it does not do damage today, this could have nasty side effect
when the PTI code is changed, extended etc. later.

Thanks,

	tglx
8<----------------
 pti.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)



