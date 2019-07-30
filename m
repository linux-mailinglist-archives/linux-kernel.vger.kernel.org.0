Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED17AE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfG3QtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:49:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36536 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3QtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:49:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsVJK-0002Mu-Nz; Tue, 30 Jul 2019 18:49:14 +0200
Message-ID: <a8e2b0673b982696e3e3a71abfd1f647f2bcb2b7.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] devcoredump: fix typo in comment
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date:   Tue, 30 Jul 2019 18:49:12 +0200
In-Reply-To: <20190730164553.GA14088@kroah.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
         <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
         <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
         <20190730162320.GA28134@kroah.com>
         <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
         <20190730164553.GA14088@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 18:45 +0200, Greg KH wrote:

> > I mean, you take patches to devcoredump in general?
> 
> I have no idea, run 'scripts/get_maintainer.pl' to be sure :)

That actually points to me :-)

So really I guess the question is how I should send these upstream? It's
to drivers/base/devcoredump.c and include/linux/devcoredump.h and I
kinda figured you wanted to see these things.

johannes

