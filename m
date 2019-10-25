Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698ABE41F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbfJYDJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 23:09:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2435 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729283AbfJYDJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:09:41 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 448C9DDE91490327202E;
        Fri, 25 Oct 2019 11:09:39 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 11:09:38 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 25 Oct 2019 11:09:38 +0800
Date:   Fri, 25 Oct 2019 11:12:29 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Guenter Roeck <groeck@google.com>
CC:     Philippe Liard <pliard@google.com>, <phillip@squashfs.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191025031229.GB210047@architecture4>
References: <20191018010846.186484-1-pliard@google.com>
 <20191025004531.89978-1-pliard@google.com>
 <20191025025334.GA210047@architecture4>
 <CABXOdTeQTapfvKqGrqZME8JACeJhaHram_ZWk7ZZX2VWvYORaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABXOdTeQTapfvKqGrqZME8JACeJhaHram_ZWk7ZZX2VWvYORaw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 08:02:14PM -0700, Guenter Roeck wrote:
> On Thu, Oct 24, 2019 at 7:51 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > On Fri, Oct 25, 2019 at 09:45:31AM +0900, Philippe Liard wrote:
> > > > Personally speaking, just for Android related use cases, I'd suggest
> > > > latest EROFS if you care more about system overall performance more
> > > > than compression ratio, even https://lkml.org/lkml/2017/9/22/814 is
> > > > applied (you can do benchmark), we did much efforts 3 years ago.
> > > >
> > > > And that is not only performance but noticable memory overhead (a lot
> > > > of extra memory allocations) and heavy page cache thrashing in low
> > > > memory scenarios (it's very common [1].)
> > >
> > > Thanks for the suggestion. EROFS is on our radar and we will
> > > (re)consider it once it goes out of staging. But we will most likely
> > > stay on squashfs until this happens.
> >
> > EROFS is already out of staging in mainline right now,
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/
> >
> > If you agree on that, I'd suggest you try it right now
> > since it's widely (200+ million devices on the market)
> > deployed for our Android smartphones and fully open source
> > and open community. I think this is not a regrettable
> > attempt and we can response any question.
> >
> > https://lore.kernel.org/r/20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1
> >
> > In my personal opinion, just for Android use cases,
> > I think it is worth taking some time.
> >
> > All well said. The question, though, is if that is a reason to reject
> squashfs performance improvements. I argue that it is not. The decision to
> switch to erofs or not is completely orthogonal to squashfs performance
> improvements, and one doesn't preclude the other.

Note that I have no objection on this patch. And I'm happy to see any
improvements for other compression filesystems. And we are keeping on
boosting up our overall performance as well but I think I can give
some personal suggestions on given specific scenario since we already
did other solutions before. Just FYI to you.

Thanks,
Gao Xiang

> 
> Guenter
