Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60A64E082
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 08:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfFUG0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 02:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfFUG0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:26:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9915020673;
        Fri, 21 Jun 2019 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561098393;
        bh=XYbXweMpuaynOcY+nT1g0YPrH1Rpfi5GHw7WUdRg77s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTRHYMfgF0ipxXwUgC3S6fbt4sKSxVZMpRmn0VZOujrxh3Aa2r11A6d/nGGvHedCY
         +QuP7k2kHdXU48sZdzp/ISJfmgkxVXse4jrh1pwExfvi1WyWj92pQ+J0n0FyrIh1uD
         LTWmHrYTjnTuXLUyrg3oJD28j6dEwsz1xi5PeAFQ=
Date:   Fri, 21 Jun 2019 08:26:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: mtd-abi: Don't use C++ comments
Message-ID: <20190621062630.GC11084@kroah.com>
References: <20190620155505.27036-1-natechancellor@gmail.com>
 <CAKwvOdk7ZTcWEXPTBASPzk1SjOdnONawtQJkR-jU=REFSo1hVQ@mail.gmail.com>
 <20190620201549.GA65397@archlinux-epyc>
 <CAKwvOd=okFdfSfGpXTAUqyF=vfnaZFgdwHC-i+CnaFxGSh2Thg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=okFdfSfGpXTAUqyF=vfnaZFgdwHC-i+CnaFxGSh2Thg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:29:47PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 1:15 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Jun 20, 2019 at 12:56:58PM -0700, Nick Desaulniers wrote:
> > > Should there be a fixes by tag?
> >
> > Normally, I would have added one but this issue has been present since
> > the beginning of git history. According to Thomas Gleixner's pre-git
> > history tree, it would be:
> >
> > Fixes: 7df80b4c8964 ("MTD core include and device code cleanup")
> >
> > but since that hash doesn't exist in the normal git history, I don't
> > think it is worth adding. Of course, if the maintainers want to add it,
> > I won't object.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> 
> LOL good point; I wonder if the stable maintainers have thoughts on
> that or how they expect us to signal that case if we even need to do
> anything at all.

If you want it applied "since the beginning of time", then just do:

Cc: <stable@vger.kernel.org> # 2.6.0+

or some such marking.

thanks,

greg k-h
