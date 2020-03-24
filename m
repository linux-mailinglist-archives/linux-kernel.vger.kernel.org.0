Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA39219171B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCXQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:59:44 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50581 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727314AbgCXQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:59:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 16CEA5800FF;
        Tue, 24 Mar 2020 12:59:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Mar 2020 12:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EmgflmADeX3uKMoV9z6ZCDVZvdB
        T42jj27XLkAu0280=; b=N8IFPUhGgraum0WfQg7hW7S+v41IJ/sSIlOnX+tcuFr
        cHBCkIRuCentE8TS0Z4a23DWnqePzysHB3fAigWRvO3PTf1u08sVcfgxU45ihkhD
        hklmih52QH0vwEOBbEfC4eb1dBqmy0IpLH9NPC43pIEohDWthooGANVifOpAlYCQ
        e8kodiuovk2PdUDo2j3/7lR78Gb/2/bvTXP6FYNEop/3rh21DibHLzht1DLJK0nV
        3OUX0rRJxMvRJnxrVhQdxo7Dv+J3dpkAIQdvu3Stwb1uVkd4tBitxLKyVYxoFUY+
        Si/qdKwpqeV+CfcgSDsM9/1GeQGShU1mKZHBqFshmXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Emgflm
        ADeX3uKMoV9z6ZCDVZvdBT42jj27XLkAu0280=; b=a0S+/jxJ5p5bDXnlVG5Ph8
        4QDCN8OK6oebG/3/fUV/ncDX5EGMuNToMf/Y+XXHQFNFgUf78C0e391lOQ+6T1Jz
        dXXhrghdicVQRLSoDsXuGx4+SXU6WFUKyfqfnurz05qWNGBbLHaDEultpXfqAzRY
        lDmi+D5zd+5tc8cw1ElYkHtuD0+F8Dl7cOPe8svUCoPvMU20VdreE/Y9o5iY6DXl
        biatMZLgovryilGBBihCdFEe/0l0aqs1OV0EUegmmONPl5En0gCK8vxh6FUznTSr
        lCJhgfP5xclZ6T/5wwdi6wISU9qOarq7AFRS0Wa2zTU0TJDFIvJr0A0ja8bF7hxw
        ==
X-ME-Sender: <xms:fTx6XnGdayaYLdMg97_00iek-9mgSd1FcT9FNwNk5SySwtp1XU2VJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:fTx6Xn10M5T6WpbDLR8vgx-cHaiLmkGsvkhw7hhA7Sev6Yg1ou-jgw>
    <xmx:fTx6XhqO3uPNrgOiTmMCgF9PDnRaFmTBZ74hKOKR1BFWk1R7tlrt2Q>
    <xmx:fTx6Xn55YFOy6m5pabJiqg34xGgvCPgJuxeJ9vIzGnsSX6UO408bHQ>
    <xmx:fzx6XltL3TawRFpMtINceQTNvTK3BFrf1tjTgQFFH73_vEtH0_PWsA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 81DA93280067;
        Tue, 24 Mar 2020 12:59:40 -0400 (EDT)
Date:   Tue, 24 Mar 2020 17:59:38 +0100
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
Message-ID: <20200324165938.GA2521386@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <CAG48ez1yTbbXn__Kf0csf8=LCFL+0hR0EyHNZsryN8p=SsLp5Q@mail.gmail.com>
 <20200324162652.GA2518046@kroah.com>
 <CAG48ez1c5Rjo+RZRW-qR7h40zT4mT8iQv5m3h0qTjfFpsckEsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1c5Rjo+RZRW-qR7h40zT4mT8iQv5m3h0qTjfFpsckEsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:38:30PM +0100, Jann Horn wrote:
> On Tue, Mar 24, 2020 at 5:26 PM Greg KH <greg@kroah.com> wrote:
> > On Tue, Mar 24, 2020 at 05:20:45PM +0100, Jann Horn wrote:
> > > On Tue, Mar 24, 2020 at 4:37 PM Will Deacon <will@kernel.org> wrote:
> > > > Some list predicates can be used locklessly even with the non-RCU list
> > > > implementations, since they effectively boil down to a test against
> > > > NULL. For example, checking whether or not a list is empty is safe even
> > > > in the presence of a concurrent, tearing write to the list head pointer.
> > > > Similarly, checking whether or not an hlist node has been hashed is safe
> > > > as well.
> > > >
> > > > Annotate these lockless list predicates with data_race() and READ_ONCE()
> > > > so that KCSAN and the compiler are aware of what's going on. The writer
> > > > side can then avoid having to use WRITE_ONCE() in the non-RCU
> > > > implementation.
> > > [...]
> > > >  static inline int list_empty(const struct list_head *head)
> > > >  {
> > > > -       return READ_ONCE(head->next) == head;
> > > > +       return data_race(READ_ONCE(head->next) == head);
> > > >  }
> > > [...]
> > > >  static inline int hlist_unhashed(const struct hlist_node *h)
> > > >  {
> > > > -       return !READ_ONCE(h->pprev);
> > > > +       return data_race(!READ_ONCE(h->pprev));
> > > >  }
> > >
> > > This is probably valid in practice for hlist_unhashed(), which
> > > compares with NULL, as long as the most significant byte of all kernel
> > > pointers is non-zero; but I think list_empty() could realistically
> > > return false positives in the presence of a concurrent tearing store?
> > > This could break the following code pattern:
> > >
> > > /* optimistic lockless check */
> > > if (!list_empty(&some_list)) {
> > >   /* slowpath */
> > >   mutex_lock(&some_mutex);
> > >   list_for_each(tmp, &some_list) {
> > >     ...
> > >   }
> > >   mutex_unlock(&some_mutex);
> > > }
> > >
> > > (I'm not sure whether patterns like this appear commonly though.)
> >
> >
> > I would hope not as the list could go "empty" before the lock is
> > grabbed.  That pattern would be wrong.
> 
> If the list becomes empty in between, the loop just iterates over
> nothing, and the effect is no different from what you'd get if you had
> bailed out before. But sure, you have to be aware that that can
> happen.

Doh, yeah, so it is safe, crazy, but safe :)
