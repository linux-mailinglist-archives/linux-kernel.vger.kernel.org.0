Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48415D9BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGCAxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfGCAxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:53:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E41A218E0;
        Tue,  2 Jul 2019 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562106249;
        bh=paq3rBGRhLW2Qpm44+MevTEqQRAXrHYmPUYx69zxz/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W75jKD/rNzq2PuPQpltd8H0MgbE9WV7KUI0OFTUGJiv4fPwyzhUtfkvdxeVlqOkFL
         4b4xWxBzPXNyswEVKmLNwRI3tbXoIQnWMp3m/zqn80P3dgemCD1FV6iQddz/Pfn4vq
         yEgltIRFEizLLcYCPK78BUk8j0MPX6sFGN8Y+qYk=
Date:   Tue, 2 Jul 2019 15:24:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Henry Burns <henryburns@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before
 __SetPageMovable()
Message-Id: <20190702152409.21c6c3787d125d61fb47840a@linux-foundation.org>
In-Reply-To: <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
References: <20190702005122.41036-1-henryburns@google.com>
        <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
        <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
        <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
        <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 15:17:47 -0700 Henry Burns <henryburns@google.com> wrote:

> > > > > +       if (can_sleep) {
> > > > > +               lock_page(page);
> > > > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > > > +               unlock_page(page);
> > > > > +       } else {
> > > > > +               if (!WARN_ON(!trylock_page(page))) {
> > > > > +                       __SetPageMovable(page, pool->inode->i_mapping);
> > > > > +                       unlock_page(page);
> > > > > +               } else {
> > > > > +                       pr_err("Newly allocated z3fold page is locked\n");
> > > > > +                       WARN_ON(1);

The WARN_ON will have already warned in this case.

But the whole idea of warning in this case may be undesirable.  We KNOW
that the warning will sometimes trigger (yes?).  So what's the point in
scaring users?

Also, pr_err(...)+WARN_ON(1) can basically be replaced with WARN(1, ...)?

> > > > > +               }
> > > > > +       }
