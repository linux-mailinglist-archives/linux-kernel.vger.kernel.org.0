Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC6174C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCAJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 04:02:49 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52389 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCAJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 04:02:49 -0500
X-Originating-IP: 172.58.43.63
Received: from localhost (unknown [172.58.43.63])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9D74920006;
        Sun,  1 Mar 2020 09:02:43 +0000 (UTC)
Date:   Sun, 1 Mar 2020 01:02:39 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200301090239.GC216567@localhost>
References: <20200229025228.GA203607@localhost>
 <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 02:01:05AM +0000, Chaitanya Kulkarni wrote:
> Nit:- please have a look at the patch subject line and make
> sure it is not exceeding the required length.

Documentation/process/submitting-patches.rst says "no more than 70-75
characters,", and the summary here is 61. Checkpatch similarly says 75.
Is there somewhere I missed that gives a different number?

> One question though, have you seen similar kind of performance 
> improvements when system is booted ?

I tested with nvme compiled in, both with one NVMe device and two NVMe
devices, and in both cases it provided a *substantial* speedup. I didn't
test nvme compiled as a module, but in general I'd expect that if you're
trying to optimize initialization time you'd want to build it in.

> I took some numbers and couldn't see similar benefit. See [1] :-
> 
> Without :-
> 
> 714.532560-714.456099 = .076461
> 721.189886-721.110845 = .079041
> 727.836938-727.765572 = .071366
> 734.589886-734.519779 = .070107
> 741.244296-741.173503 = .070793

With numbers in this range, I don't see how you could be hitting the
100ms msleep at all, even once, which means this patch shouldn't have
any effect on the timing you're measuring.

- Josh Triplett
