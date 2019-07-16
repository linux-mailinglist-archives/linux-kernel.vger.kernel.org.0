Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06EB6AF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfGPSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 14:51:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AklfcGpttAaMDlPGy9MDf7QZbGtYSMLGsNdmyHrq1v8=; b=clvfScQfZKrAWDOiWdrg94BuS
        703Zy08rHK7baU88WuzfEvvxoCD58JIjVwENhVhmWpk++chYfcJypf6W0nGByPsSE4oKuq4SQN9WS
        bjonGM77iJL5ysRUGSSmDdvL5LPRNABAHG2yeUhltlBLN8QDA3Pe3iMFT5wy0VCs7ue/w28UEZYPi
        IeKxliRmzj9SQ9BUatdJu41dGD/V8ZjrEU11pCQ3mkDJaUkLEX5uPAzv/+ybFjjSEz9M/b9gCnSnb
        qUKtJhZdhC2Xna4ousqlp+QgNTh/ivjuDRnunuSq+uG+5AlapBdblNDrBITu9L4TrKQSR1elv+w3I
        yGp01/AUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnSYE-0003Qd-F4; Tue, 16 Jul 2019 18:51:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA7AC20B15D60; Tue, 16 Jul 2019 20:51:44 +0200 (CEST)
Date:   Tue, 16 Jul 2019 20:51:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/22] x86/uaccess: Remove ELF function annotation from
 copy_user_handle_tail()
Message-ID: <20190716185144.GI3402@hirez.programming.kicks-ass.net>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <6166ec9ce99e5af2721793eaf4a769aaa881e14d.1563150885.git.jpoimboe@redhat.com>
 <CAKwvOdn2ZEe6y=TZ2OyphR7CrC3yJgDEUVtwSX_5fXGtYAQ=bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn2ZEe6y=TZ2OyphR7CrC3yJgDEUVtwSX_5fXGtYAQ=bA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:16:48AM -0700, Nick Desaulniers wrote:
> On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > After an objtool improvement, it's complaining about the CLAC in
> > copy_user_handle_tail():
> >
> >   arch/x86/lib/copy_user_64.o: warning: objtool: .altinstr_replacement+0x12: redundant UACCESS disable
> >   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x6: (alt)
> >   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x2: (alt)
> >   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x0: <=== (func)
> >
> > copy_user_handle_tail() is incorrectly marked as a callable function, so
> > objtool is rightfully concerned about the CLAC with no corresponding
> > STAC.
> >
> > Remove the ELF function annotation.  The copy_user_handle_tail() code
> > path is already verified by objtool because it's jumped to by other
> > callable asm code (which does the corresponding STAC).
> 
> What is CLAC and STAC?

CLear AC flag and SeT AC flag, SMAP repurposed the EFLAGS.AC for CPL0.

Also see commit: ea24213d8088 ("objtool: Add UACCESS validation")
