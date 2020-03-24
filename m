Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899FE191658
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgCXQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:27:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36509 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728878AbgCXQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id C7F8D5801E3;
        Tue, 24 Mar 2020 12:26:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 24 Mar 2020 12:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EpjqqXTd+1Wm5pAE5NoGcCzxGJn
        bee7TfJZCxnuYzD0=; b=gYvbvIshEDx22jkTpGIMePKB3NCO/GN6qnZKifTgqPq
        oFirJjhFA7A44jHh68nRCpIb4tbEgC30nb/rml1oa0jT50C88klHj0+NlSO/+6u9
        5HNLcAYCDlCKTxgVW5oXZn+JWbvv3gXA5EAqHIZt5N9Kd4gO47XK8Zt6Ov7+1Qyn
        FXlX5A8tAbTXtnwc/0PAwgmQ5b4ybiHFR2X6dNC2KXqagQzTonJZP+zzarq5gMPo
        0kJZmZKn1rkjZv+rgvMsuOGnKp60WMbMC85npE3eyprkadgIIzZZ3bnAj19xlhN+
        NrBZQl+0knvDt5MfBZjk1NcYpLP+fqAj34RqdtsKMTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EpjqqX
        Td+1Wm5pAE5NoGcCzxGJnbee7TfJZCxnuYzD0=; b=nqv6WQH/3CNd1NSkwjxbFI
        2TIlVYxUexN25jq2Cu0q0BW3aOgs3a+K0qc273BKDDxd+zVWhWgLYy2W0QkaHPE7
        DIeUkBYjo1+RcNCPPEhGlViuAc+bUcUQT3mPuFUQlWSGCxfMOa4DM44zBU8dNGH3
        OhfPeO181JH6lVWrO2IoYZ/In7Sth1rtMD/zogVKd+qiztyAtMStBGFZS1kLXZTQ
        TDi4ewAkVhp6ZVUGmSLzM/j11L+PcTUwBvs/f+5ql64FCqgGJOtYFvrACewpsD6k
        n5XT3gxeicX5MP/4lFMTqUkMUjM4vHiJYBpx86A+83PPoZnrB0dfE3Dkxi9grbtw
        ==
X-ME-Sender: <xms:zjR6XsLKxKOHmtRuzFjtnT40px7bnOUZPR1IuetYnC0JPXjYG8_wFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:zjR6XslWbsGIq12_Wy0aIpl7m9MmgUY2dak-DR-A8KYpvG2uvW78mw>
    <xmx:zjR6XtaFRpZ7cb4a44MM96SH0ibR5b0talUZiA3_MLVUi74AbH05LA>
    <xmx:zjR6Xg8nWcUJ9U5DabvvdSyeHTATHxZLy1BDIkJUCGqz7zZV4E_dDA>
    <xmx:zjR6Xryl4vNZ-FbjwtUnyYoySDfaCn_nogWHZO52F-oOhqMUVzhymw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FF5C3065177;
        Tue, 24 Mar 2020 12:26:53 -0400 (EDT)
Date:   Tue, 24 Mar 2020 17:26:52 +0100
From:   Greg KH <greg@kroah.com>
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with
 data_race()
Message-ID: <20200324162652.GA2518046@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <CAG48ez1yTbbXn__Kf0csf8=LCFL+0hR0EyHNZsryN8p=SsLp5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1yTbbXn__Kf0csf8=LCFL+0hR0EyHNZsryN8p=SsLp5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:20:45PM +0100, Jann Horn wrote:
> On Tue, Mar 24, 2020 at 4:37 PM Will Deacon <will@kernel.org> wrote:
> > Some list predicates can be used locklessly even with the non-RCU list
> > implementations, since they effectively boil down to a test against
> > NULL. For example, checking whether or not a list is empty is safe even
> > in the presence of a concurrent, tearing write to the list head pointer.
> > Similarly, checking whether or not an hlist node has been hashed is safe
> > as well.
> >
> > Annotate these lockless list predicates with data_race() and READ_ONCE()
> > so that KCSAN and the compiler are aware of what's going on. The writer
> > side can then avoid having to use WRITE_ONCE() in the non-RCU
> > implementation.
> [...]
> >  static inline int list_empty(const struct list_head *head)
> >  {
> > -       return READ_ONCE(head->next) == head;
> > +       return data_race(READ_ONCE(head->next) == head);
> >  }
> [...]
> >  static inline int hlist_unhashed(const struct hlist_node *h)
> >  {
> > -       return !READ_ONCE(h->pprev);
> > +       return data_race(!READ_ONCE(h->pprev));
> >  }
> 
> This is probably valid in practice for hlist_unhashed(), which
> compares with NULL, as long as the most significant byte of all kernel
> pointers is non-zero; but I think list_empty() could realistically
> return false positives in the presence of a concurrent tearing store?
> This could break the following code pattern:
> 
> /* optimistic lockless check */
> if (!list_empty(&some_list)) {
>   /* slowpath */
>   mutex_lock(&some_mutex);
>   list_for_each(tmp, &some_list) {
>     ...
>   }
>   mutex_unlock(&some_mutex);
> }
> 
> (I'm not sure whether patterns like this appear commonly though.)


I would hope not as the list could go "empty" before the lock is
grabbed.  That pattern would be wrong.

thanks,

greg k-h
