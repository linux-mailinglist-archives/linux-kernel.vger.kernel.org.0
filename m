Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A67AF56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfG3RMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfG3RMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:12:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F448208E4;
        Tue, 30 Jul 2019 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564506722;
        bh=qSk9H3oF4s0bizd7mN3SIpZp4kHPDX9XVVk3ku3CDxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOYeijNJedp7Eav6TCAQAEoTVjDFt4NFw5s0DfXieoplWnotqr0sx12ES72J9aY6n
         lpdgNVIVJe5Nj0pf1EwXDynSvCWTNJxpC2KFtLCqfZvOguu5nwvJKEzP38ci/HP2KF
         OKcx4IYuHdRc+IQ0V9d1oRl35y7b57qljQyVTKxI=
Date:   Tue, 30 Jul 2019 19:11:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 2/2] devcoredump: fix typo in comment
Message-ID: <20190730171159.GB32124@kroah.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
 <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
 <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
 <20190730162320.GA28134@kroah.com>
 <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
 <20190730164553.GA14088@kroah.com>
 <a8e2b0673b982696e3e3a71abfd1f647f2bcb2b7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e2b0673b982696e3e3a71abfd1f647f2bcb2b7.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:49:12PM +0200, Johannes Berg wrote:
> On Tue, 2019-07-30 at 18:45 +0200, Greg KH wrote:
> 
> > > I mean, you take patches to devcoredump in general?
> > 
> > I have no idea, run 'scripts/get_maintainer.pl' to be sure :)
> 
> That actually points to me :-)
> 
> So really I guess the question is how I should send these upstream? It's
> to drivers/base/devcoredump.c and include/linux/devcoredump.h and I
> kinda figured you wanted to see these things.

Ah, sure, I can take them, I had no idea what devcoredump was.  Remember
my patch workload :)

So send them on please.

thanks,

greg k-h
