Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE48235B36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfFELXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:23:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFELXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sVN3EHsvpO4JEKTL1zRRHRBKbHxUnSg7DWieN951vaQ=; b=ZxNl0qOQMb2nfXeNThDfWARnO
        IjMcoH4MbKtQUU/nYGjzXO/SzWGoG4bwvM6cBsqxqnboCmwXwdmrZT6ztabNtnUgigfRmXDx8fQga
        0rKqTEt4/6uc2AluHwNMT79+xCxIagqOb/We+wKGSyrnU5U0zj89HIUQ91CjDb3ocZFKE34NA73Xt
        ht21jsc6XZzCEdyBsoxDu/s7ytcLxb6tZ+TqSKkA+jPRHteOcwa78zZTOL6egPiRNwQtvKPfLFnxB
        43TAXA7rZyGVZ8LyRQz4qMmoOohTstIupqEoWtffXXODQJqZlI73n1KFz6tSlAtnVI5oGHg9JPstG
        ajfQGCbTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYU0u-0005Bg-TM; Wed, 05 Jun 2019 11:23:28 +0000
Date:   Wed, 5 Jun 2019 04:23:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
Message-ID: <20190605112328.GB2025@bombadil.infradead.org>
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
 <87sgsomg91.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgsomg91.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:19:22PM +1000, Michael Ellerman wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> > Similar notify_page_fault() definitions are being used by architectures
> > duplicating much of the same code. This attempts to unify them into a
> > single implementation, generalize it and then move it to a common place.
> > kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
> > need not be wrapped again within CONFIG_KPROBES. Trap number argument can
> > now contain upto an 'unsigned int' accommodating all possible platforms.
> ...
> 
> You've changed several of the architectures from something like above,
> where it disables preemption around the call into the below:
> 
> 
> Which skips everything if we're preemptible. Is that an equivalent
> change? If so can you please explain why in more detail.

See the discussion in v1 of this patch, which you were cc'd on.

I agree the description here completely fails to mention why the change.
It should mention commit a980c0ef9f6d8c.

> Also why not have it return bool?
> 
> cheers
> 
