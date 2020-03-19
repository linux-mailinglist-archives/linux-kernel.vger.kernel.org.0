Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2818B111
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCSKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:20:17 -0400
Received: from verein.lst.de ([213.95.11.211]:41163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgCSKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:20:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E1C468BEB; Thu, 19 Mar 2020 11:20:11 +0100 (CET)
Date:   Thu, 19 Mar 2020 11:20:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319102011.GA3617@lst.de>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319101657.GB13073@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:16:57AM +0100, Borislav Petkov wrote:
> Hi,
> 
> here's v2 with build breakage fixed on ppc and s390 (obviously I can't
> grep :-\) and commit message extended to explain more why.

I thought we agreed that decrypted is absolutely the wrong term.

So NAK - if you want to change things it needs to go the other way.
