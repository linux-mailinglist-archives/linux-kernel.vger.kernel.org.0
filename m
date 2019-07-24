Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF772DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGXLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:34:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGXLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:34:35 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqFXL-0006JX-US; Wed, 24 Jul 2019 13:34:24 +0200
Date:   Wed, 24 Jul 2019 13:34:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix possible null-pointer dereferences in
 untrack_pfn()
In-Reply-To: <alpine.DEB.2.21.1907241309420.1791@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907241320450.1791@nanos.tec.linutronix.de>
References: <20190723132648.25853-1-baijiaju1990@gmail.com> <alpine.DEB.2.21.1907241309420.1791@nanos.tec.linutronix.de>
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

On Wed, 24 Jul 2019, Thomas Gleixner wrote:
> On Tue, 23 Jul 2019, Jia-Ju Bai wrote:
> 
> > In untrack_pfn(), there is an if statement on line 1058 to check whether
> > vma is NULL:
> >     if (vma && !(vma->vm_flags & VM_PAT))
> > 
> > When vma is NULL, vma is used on line 1064:
> >     if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr))
> > and line 1069:
> >     size = vma->vm_end - vma->vm_start;
> > 
> > Thus, possible null-pointer dereferences may occur.
> > 
> > To fix these possible bugs, vma is checked on line 1063.
> > 
> > These bugs are found by a static analysis tool STCheck written by us.
> 
> In principle you are right, but that's a bit more subtle as the callers can
> provide a vma pointer and/or a valid pfn and size.
> 
> > diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
> > index d9fbd4f69920..717456e7745e 100644
> > --- a/arch/x86/mm/pat.c
> > +++ b/arch/x86/mm/pat.c
> > @@ -1060,7 +1060,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
> >  
> >  	/* free the chunk starting from pfn or the whole chunk */
> >  	paddr = (resource_size_t)pfn << PAGE_SHIFT;
> > -	if (!paddr && !size) {
> > +	if (vma && !paddr && !size) {
> >  		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
> >  			WARN_ON_ONCE(1);
> >  			return;
> 
> So I'd rather have a sanity check in that function which does:
> 
> 	if (WARN_ON_ONCE(!vma && !pfn && !size))
> 		return;

The even better solution is to have separate functions:

    untrack_pfn(unsigned long pfn, unsigned long size)

and

    untrack_vma(struct vm_area_struct *vma, unsigned long pfn, unsigned long size)

The amount of shared code is minimal and the result is less confusing.

Thanks,

	tglx
