Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543E97AE52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfG3Qp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfG3Qp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:45:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA1E20693;
        Tue, 30 Jul 2019 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564505156;
        bh=J7zFUGayczWhSdYHnVQP9PCQACEDMyHwGZZixxltD5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cL4Y44LixVM0yhj1GztcsDtVHs0o1y3IckRBUOkQV0San/TdM22cxPf890Kvw/zuI
         5fQzhJsY28ulbQUpCGdJrPb9zNAz77sEgs1goNVO9ufBpfS8yoFoXDLPzO3tno57ZO
         ooVhxQ4FC7Ubm4nY6H0mJgcWgp72mCkqXU3PA9Bc=
Date:   Tue, 30 Jul 2019 18:45:53 +0200
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
Message-ID: <20190730164553.GA14088@kroah.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
 <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
 <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
 <20190730162320.GA28134@kroah.com>
 <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:37:56PM +0200, Johannes Berg wrote:
> On Tue, 2019-07-30 at 18:23 +0200, Greg KH wrote:
> > On Sat, Jul 27, 2019 at 08:43:21PM +0200, Johannes Berg wrote:
> > > On Sun, 2019-07-28 at 00:59 +0900, Akinobu Mita wrote:
> > > > s/dev_coredumpmsg/dev_coredumpsg/
> > > 
> > > Oops, thanks
> > > 
> > > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> > > 
> > > Greg, I think before you took these patches?
> > 
> > Took what patches?  I don't see anything here :(
> 
> I mean, you take patches to devcoredump in general?

I have no idea, run 'scripts/get_maintainer.pl' to be sure :)

> So need to resend with you included, I guess.

Please do so.

thanks,

greg k-h
