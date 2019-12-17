Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CE122BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfLQMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:35:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfLQMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VsVtFdevxlGRCrWfP8hci6f/iyunYEOpJSp0xS6dOKc=; b=T3ZuDtNmNHBKv1GTIKaS38XVK
        NPZRhzDbIgWl19Zn3aURQfpLQ4BtKUvyToE96lr2vB7Nerr8miVjF15Fiv2OUKtAMT1/B9xGMM+/I
        ic0uBcM7Sb/GxumsPZ8FJHoM+dv13rM2u11M9C6CT7/4nLkZH/29gk+6t+DrFCQ05F3FVZ+ltvvxP
        4Wk+vakVyiGcNvPbskuRgory7ttL0rSeFVKyCBRXCbJBHK4jz6QIWqvzya4SM74LiBCvQXBmGU3NC
        fW0jICEd3F2C9DLotg9xz9Uime/23202eOXhPnGHZC7wQeUMLgZYF5b4YexaELg2wXxrm+Xq6Zhpm
        l96wNbvnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihC4o-0000n4-7X; Tue, 17 Dec 2019 12:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E9F83007F2;
        Tue, 17 Dec 2019 13:34:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 450622B2CF994; Tue, 17 Dec 2019 13:35:44 +0100 (CET)
Date:   Tue, 17 Dec 2019 13:35:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191217123544.GI2827@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217090914.GX2844@hirez.programming.kicks-ass.net>
 <3d250b04-a78d-20a7-d41e-50e48e08d1cb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d250b04-a78d-20a7-d41e-50e48e08d1cb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:18:40PM +0530, Aneesh Kumar K.V wrote:
> On 12/17/19 2:39 PM, Peter Zijlstra wrote:
> > On Tue, Dec 17, 2019 at 12:47:12PM +0530, Aneesh Kumar K.V wrote:
> > > Architectures for which we have hardware walkers of Linux page table should
> > > flush TLB on mmu gather batch allocation failures and batch flush. Some
> > > architectures like POWER supports multiple translation modes (hash and radix)
> > > and in the case of POWER only radix translation mode needs the above TLBI.
> > > This is because for hash translation mode kernel wants to avoid this extra
> > > flush since there are no hardware walkers of linux page table. With radix
> > > translation, the hardware also walks linux page table and with that, kernel
> > > needs to make sure to TLB invalidate page walk cache before page table pages are
> > > freed.
> > 
> > > Based on changes from Peter Zijlstra <peterz@infradead.org>
> > 
> > AFAICT it is all my patch ;-)
> 
> Yes. I moved the changes you had to upstream. I can update the From: in the
> next version if you are ok with that?

Well, since PPC isn't broken per finding the invalidate in
__p*_free_tlb(), lets do these things on top of the patches I proposed
here. Also, you mnight want to run benchmarks to see if the movement of
that TLBI actually helps (I'm thinking the cost of the PTESYNC might add
up).
