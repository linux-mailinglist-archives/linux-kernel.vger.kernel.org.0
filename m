Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC22FC76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfE3Nj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:39:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3Nj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1z2R00tGmVK2jShz09WQ0aSl4fghOklhUmq3MkzmZGo=; b=cO8H1JSNfCwyIOlnTHicp8Zhy
        tdZp1B1hNurTw3WgAzPBczTGKcSpIkF2nUeFXWFXbacSglBjt8yYhoxBpvJQd2bkSo8SPeHDMVlbk
        AmGm77WpHy+tChpRqlM72RL0yDXaK+gT4W1Kljnz/VQ/KVDugsJZ0Tc/HFFB2pHCUi7WQ8dCXvAcZ
        squPNwIZONWngjyh6R0Q/O1CiEId8WQLaglsMjfxroLiY82v0UZBHk7vWS3/3ejIRWejmUyHZlDM1
        gPiCoTWkidUnsD2jvuDxMSsXlKB3TaOPHa9W0ihPAK8uyAmomCO3ELcq+JfaA9MCjatOQ5PlCd63o
        jpySg/rQw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWLHe-0001vX-Pd; Thu, 30 May 2019 13:39:54 +0000
Date:   Thu, 30 May 2019 06:39:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] mm: Generalize notify_page_fault()
Message-ID: <20190530133954.GA2024@bombadil.infradead.org>
References: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
 <20190530110639.GC23461@bombadil.infradead.org>
 <4f9a610d-e856-60f6-4467-09e9c3836771@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9a610d-e856-60f6-4467-09e9c3836771@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:31:15PM +0530, Anshuman Khandual wrote:
> On 05/30/2019 04:36 PM, Matthew Wilcox wrote:
> > The two handle preemption differently.  Why is x86 wrong and this one
> > correct?
> 
> Here it expects context to be already non-preemptible where as the proposed
> generic function makes it non-preemptible with a preempt_[disable|enable]()
> pair for the required code section, irrespective of it's present state. Is
> not this better ?

git log -p arch/x86/mm/fault.c

search for 'kprobes'.

tell me what you think.
