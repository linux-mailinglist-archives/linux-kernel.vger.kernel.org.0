Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6850C38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfFXNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbfFXNnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:43:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7DDB316290E;
        Mon, 24 Jun 2019 13:43:39 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BE9B600CD;
        Mon, 24 Jun 2019 13:43:38 +0000 (UTC)
Date:   Mon, 24 Jun 2019 21:43:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kyle Pelton <kyle.d.pelton@intel.com>
Subject: Re: [PATCH] x86/mm: Handle physical-virtual alignment mismatch in
 phys_p4d_init()
Message-ID: <20190624134333.GO24419@MiWiFi-R3L-srv>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
 <20190621090249.GL24419@MiWiFi-R3L-srv>
 <20190621105449.fp7h7tsmpitvplyr@box>
 <20190624100742.GM24419@MiWiFi-R3L-srv>
 <20190624122355.762cadxds37enfdo@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624122355.762cadxds37enfdo@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 13:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/19 at 03:23pm, Kirill A. Shutemov wrote:
> On Mon, Jun 24, 2019 at 06:07:42PM +0800, Baoquan He wrote:
> > On 06/21/19 at 01:54pm, Kirill A. Shutemov wrote:
> > > > The code block as below is to zero p4d entries which are not coverred by
> > > > the current memory range, and if haven't been mapped already. It's
> > > > clearred away in this patch, could you also mention it in log, and tell
> > > > why it doesn't matter now?
> > > > 
> > > > If it doesn't matter, should we clear away the simillar code in
> > > > phys_pud_init/phys_pmd_init/phys_pte_init? Maybe a prep patch to do the
> > > > clean up?
> > > 
> > > It only matters for the levels that contains page table entries that can
> > > point to pages, not page tables. There's no p4d or pgd huge pages on x86.
> > > Otherwise we only leak page tables without any benefit.
> > 
> > Ah, I checked git history, didn't find why it's added. I just Have a
> > superficial knowledge of the clearing, but in a low-efficiency way.
> > 
> > > 
> > > We might have this on all leveles under p?d_large() condition and don't
> > > touch page tables at all.
> > 
> > I see.
> > 
> > > 
> > > BTW, it all becomes rather risky for this late in the release cycle. Maybe
> > > we should revert the original patch and try again later with more
> > > comprehansive solution?
> > 
> > It's not added in one time. I am fine with your current change, would be
> > much better if mention it in log, and also add code comment above the
> > clearing code. Surely reverting and trying later with more comprehensive
> > solution is also good to me, this need a little more effort.
> 
> I've decided to keep the block for now. We can remove it later, once the fixis in.
> I'll post it soon

That's great, can make those codes more understandable with clear commit
log and code comment.
