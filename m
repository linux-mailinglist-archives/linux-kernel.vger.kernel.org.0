Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BDD6EBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfGSVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 17:10:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfGSVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 17:10:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hoa9N-0004hk-UE; Fri, 19 Jul 2019 23:10:46 +0200
Date:   Fri, 19 Jul 2019 23:10:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] x86/mm: Sync also unmappings in vmalloc_sync_one()
In-Reply-To: <20190719140122.GF19068@suse.de>
Message-ID: <alpine.DEB.2.21.1907192309190.1782@nanos.tec.linutronix.de>
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-3-joro@8bytes.org> <alpine.DEB.2.21.1907172337590.1778@nanos.tec.linutronix.de> <20190718084654.GF13091@suse.de> <alpine.DEB.2.21.1907181103120.1984@nanos.tec.linutronix.de>
 <20190719140122.GF19068@suse.de>
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

On Fri, 19 Jul 2019, Joerg Roedel wrote:
> On Thu, Jul 18, 2019 at 11:04:57AM +0200, Thomas Gleixner wrote:
> > Joerg,
> > 
> > On Thu, 18 Jul 2019, Joerg Roedel wrote:
> > > On Wed, Jul 17, 2019 at 11:43:43PM +0200, Thomas Gleixner wrote:
> > > > On Wed, 17 Jul 2019, Joerg Roedel wrote:
> > > > > +
> > > > > +	if (!pmd_present(*pmd_k))
> > > > > +		return NULL;
> > > > >  	else
> > > > >  		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
> > > > 
> > > > So in case of unmap, this updates only the first entry in the pgd_list
> > > > because vmalloc_sync_all() will break out of the iteration over pgd_list
> > > > when NULL is returned from vmalloc_sync_one().
> > > > 
> > > > I'm surely missing something, but how is that supposed to sync _all_ page
> > > > tables on unmap as the changelog claims?
> > > 
> > > No, you are right, I missed that. It is a bug in this patch, the code
> > > that breaks out of the loop in vmalloc_sync_all() needs to be removed as
> > > well. Will do that in the next version.
> > 
> > I assume that p4d/pud do not need the pmd treatment, but a comment
> > explaining why would be appreciated.
> 
> Actually there is already a comment in this function explaining why p4d
> and pud don't need any treatment:
> 
>         /*
>          * set_pgd(pgd, *pgd_k); here would be useless on PAE
>          * and redundant with the set_pmd() on non-PAE. As would
>          * set_p4d/set_pud.
>          */ 

Indeed. Why did I think there was none?

> I couldn't say it with less words :)

It's perfectly fine.

Thanks,

	tglx
