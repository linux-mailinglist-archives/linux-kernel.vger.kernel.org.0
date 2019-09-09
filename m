Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF0ADA8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405051AbfIINz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 09:55:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405034AbfIINz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UkyPHsUqAei6DhO0zB/xoh0Ya9g+WCqG9FpRgGkoXso=; b=Uxim2b/qFkMsY2cR6yo+ozIvX
        VeiO14bsaHIOwUVUkaeAgpqC1XJOyNg5vIRNnN435YkyFCwCDzUHcgDIw/FzAIZn1O+56JTEv743M
        6Qd4DyiweN4ivLrHZoU1EqNzTS3mG3RcTdM1uD/7nmiqGL+n3bCnJLZEGtTW7K8fnk1hnVyvb9Pof
        wZUdRewXSz3Rj16snxGC1ma20JFW/HtSjNSliq45SVNpdtfRFqPMVJzTOoMsuqSNU2nx8n5LJvjoD
        L8hqNE9VG3wAH3Nvss6Ib7rJRqflvu4AG7tnrdjKsIVzlek3SWK/4R33gn7C3ahRZDd3azas3TUzZ
        MmZiNPygw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7K8X-0000wL-DR; Mon, 09 Sep 2019 13:55:21 +0000
Date:   Mon, 9 Sep 2019 06:55:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com>,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in shmem_fault (2)
Message-ID: <20190909135521.GD29434@bombadil.infradead.org>
References: <20190831045826.748-1-hdanton@sina.com>
 <20190902135254.GC2431@bombadil.infradead.org>
 <20190902142029.fyq3dwn72pqqlzul@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142029.fyq3dwn72pqqlzul@box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 05:20:30PM +0300, Kirill A. Shutemov wrote:
> On Mon, Sep 02, 2019 at 06:52:54AM -0700, Matthew Wilcox wrote:
> > On Sat, Aug 31, 2019 at 12:58:26PM +0800, Hillf Danton wrote:
> > > On Fri, 30 Aug 2019 12:40:06 -0700
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    a55aa89a Linux 5.3-rc6
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12f4beb6600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6a2b9826fdadf9
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=03ee87124ee05af991bd
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > 
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530  
> > > > include/trace/events/lock.h:13
> > > > Read of size 8 at addr ffff8880a5cf2c50 by task syz-executor.0/26173
> > > 
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2021,6 +2021,12 @@ static vm_fault_t shmem_fault(struct vm_
> > >  			shmem_falloc_waitq = shmem_falloc->waitq;
> > >  			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> > >  					TASK_UNINTERRUPTIBLE);
> > > +			/*
> > > +			 * it is not trivial to see what will take place after
> > > +			 * releasing i_lock and taking a nap, so hold inode to
> > > +			 * be on the safe side.
> > 
> > I think the comment could be improved.  How about:
> > 
> > 			 * The file could be unmapped by another thread after
> > 			 * releasing i_lock, and the inode then freed.  Hold
> > 			 * a reference to the inode to prevent this.
> 
> It only can happen if mmap_sem was released, so it's better to put
> __iget() to the branch above next to up_read(). I've got confused at first
> how it is possible from ->fault().
> 
> This way iput() below should only be called for ret == VM_FAULT_RETRY.

Looking at the rather similar construct in filemap.c, should we solve
it the same way, where we inc the refcount on the struct file instead
of the inode before releasing the mmap_sem?
