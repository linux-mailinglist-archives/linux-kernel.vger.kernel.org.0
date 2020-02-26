Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8916F66D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 05:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBZEZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 23:25:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39096 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgBZEZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:25:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so1485758wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 20:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaElR6snRGlE0TDpGAVIUCBE4hGVALelZfAA0uwYifk=;
        b=uQK0INmSUKMOj4+3aPu2QNPje1xYSylMSdtsjLu/FUsR+z1GfvR5qcV6SWI1u2cqG5
         HzU9Kz+aWwD6PyrfURc2iL0COP0LbfJ5VQh+vhP+u+UvmVRwB8w52beN+Fnb4jUmeNYq
         pSsTro+3/xad3kQa7KhAEwoi4oiBSpxBlbsfg9V7JAE0mLJL13DlxzXHFjQMCBEiPpJs
         D3fqQKAKYHwN/uW5hJ+R+oihbZT9zgx+FblXzO4Ynqf+ngs2Wmefd3HH2fO42kzakBtl
         EXI9Bif/r4dZJf46eA8CxBNedV1GBrGrfzOpDc0eWvsdXDsvLIYy1/OFjpiH7sHozymZ
         t4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaElR6snRGlE0TDpGAVIUCBE4hGVALelZfAA0uwYifk=;
        b=hvjOvKxqs1dFf1qLvDxvDnwbJvCourpuQEUIADAtEl9sm/AiFnxtwlitx9M/00lBjp
         wrMM/NBKe/4rSnB6ANAjdDTk7o/aqkTv2DlF1XL+ncGhRanyd+Hw1/bTY+hE4phF01kv
         ASoIWYbXANSTushL4lqzp7m/fjCyPxZ7tp3BjaNFIgJHBAjJFPeCkwz9nK0TsM1gfN6p
         R8Q2aJR//JdnJJjpGDtyGGCm3xSIDhkgr3Dvi+rx2AXZbSFFKjf2fp5aZriXRSksUT6/
         q0lCAvqKJdHt8x40mUlNYZBCJ/ww8ghckzuyGTKza+ChKHIFFqvRV0pbtpfvpYma2fme
         IL9g==
X-Gm-Message-State: APjAAAUQ2JFSb2mS2MTRaAhSx/BQQZnVTviWMypZKCDMvT17zThWngE9
        3VnwoGCdmA3sV9Lv/PyJsnAOGhf547mW7V+sPwN91A==
X-Google-Smtp-Source: APXvYqz1c4ugbX6eIMSNa3QgVpjuZT5a0ZZunpb3xGgOySK7U8GVR/3OBr178NNPn4Kt4Sg/KCe9tiwXPmBTjYB82FU=
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr2963633wmj.133.1582691142276;
 Tue, 25 Feb 2020 20:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217145711.4af495a3@canb.auug.org.au> <20200226150229.138122d2@canb.auug.org.au>
In-Reply-To: <20200226150229.138122d2@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Tue, 25 Feb 2020 20:25:30 -0800
Message-ID: <CAOFY-A2fn2A_xpCQjiUeVO15bVDozFFe4khs41OEYqZtMRWC_Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 8:02 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 17 Feb 2020 14:57:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the akpm tree, today's linux-next build (sparc64 defconfig)
> > failed like this:
> >
> > mm/memory.c: In function 'insert_pages':
> > mm/memory.c:1523:56: error: macro "pte_index" requires 2 arguments, but only 1 given
> >    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
> >                                                         ^
> >
> > Caused by commit
> >
> >   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
> >
> > This is the first use of pte_index() outside arch specific code and the
> > sparc64 version of pte_index() nas an extra argument.
> >
> > I have reverted these commits for today:
> >
> >   219ae14a9686 ("net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fix")
> >   cb912fdf96bf ("net-zerocopy: use vm_insert_pages() for tcp rcv zerocopy")
> >   72c684430b94 ("add missing page_count() check to vm_insert_pages().")
> >   dbd9553775f3 ("mm-add-vm_insert_pages-fix")
> >   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
>
> This failure is now in the akpm tree (it was previously in the
> skpm-current tree) but I am still reverting the same patches (though
> they are now slightly different).
>

Ack, and they will continue to fail till my fixup patch for sparc64 is
merged (it's already out for review).

-Arjun

> --
> Cheers,
> Stephen Rothwell
