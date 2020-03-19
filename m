Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA118C3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 00:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCSXyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 19:54:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:54:36 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jF4z5-0002E7-Dg; Fri, 20 Mar 2020 00:53:56 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4DD6B100375; Fri, 20 Mar 2020 00:53:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200319174254.GE13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic> <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic> <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com> <20200319112054.GD13073@zn.tnic> <878sjw5k9u.fsf@nanos.tec.linutronix.de> <20200319174254.GE13073@zn.tnic>
Date:   Fri, 20 Mar 2020 00:53:49 +0100
Message-ID: <87pnd752b6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Thu, Mar 19, 2020 at 06:25:49PM +0100, Thomas Gleixner wrote:
>> TBH, I don't see how
>> 
>> 	if (force_dma_decrypted(dev))
>> 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>>
>> makes more sense than the above. It's both non-sensical unless there is
>
> 9087c37584fb ("dma-direct: Force unencrypted DMA under SME for certain DMA masks")

Reading the changelog again...

I have to say that force_dma_unencrypted() makes way more sense in that
context than force_dma_decrypted(). It still wants a comment.

Linguistical semantics and correctness matters a lot. Consistency is
required as well, but not for the price of ambiguous wording.

Thanks,

        tglx


