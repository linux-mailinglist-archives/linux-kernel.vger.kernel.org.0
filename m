Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D773769B01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfGOSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 14:48:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfGOSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:48:31 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn61P-00044x-FA; Mon, 15 Jul 2019 20:48:23 +0200
Date:   Mon, 15 Jul 2019 20:48:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] x86/mm: Check for pfn instead of page in
 vmalloc_sync_one()
In-Reply-To: <20190715154418.GA13091@suse.de>
Message-ID: <alpine.DEB.2.21.1907152047550.1767@nanos.tec.linutronix.de>
References: <20190715110212.18617-1-joro@8bytes.org> <20190715110212.18617-2-joro@8bytes.org> <alpine.DEB.2.21.1907151508210.1722@nanos.tec.linutronix.de> <20190715154418.GA13091@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Joerg Roedel wrote:
> On Mon, Jul 15, 2019 at 03:08:42PM +0200, Thomas Gleixner wrote:
> > On Mon, 15 Jul 2019, Joerg Roedel wrote:
> > 
> > > From: Joerg Roedel <jroedel@suse.de>
> > > 
> > > Do not require a struct page for the mapped memory location
> > > because it might not exist. This can happen when an
> > > ioremapped region is mapped with 2MB pages.
> > > 
> > > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > 
> > Lacks a Fixes tag, hmm?
> 
> Yeah, right, the question is, which commit to put in there. The problem
> results from two changes:
> 
> 	1) Introduction of !SHARED_KERNEL_PMD path in x86-32. In itself
> 	   this is not a problem, and the path was only enabled for
> 	   Xen-PV.
> 
> 	2) Huge IORemapings which use the PMD level. Also not a problem
> 	   by itself, but together with !SHARED_KERNEL_PMD problematic
> 	   because it requires to sync the PMD entries between all
> 	   page-tables, and that was not implemented.
> 
> Before PTI-x32 was merged this problem did not show up, maybe because
> the 32-bit Xen-PV users did not trigger it. But with PTI-x32 all PAE
> users run with !SHARED_KERNEL_PMD and the problem popped up.
> 
> For the last patch I put the PTI-x32 enablement commit in the fixes tag,
> because that was the one that showed up during bisection. But more
> correct would probably be
> 
> 	5d72b4fba40e ('x86, mm: support huge I/O mapping capability I/F')

Looks about right.

Thanks,

	tglx
