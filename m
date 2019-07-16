Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB26A6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfGPK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 06:58:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:53105 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733037AbfGPK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:58:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6GAwSFL022497;
        Tue, 16 Jul 2019 05:58:30 -0500
Message-ID: <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Tue, 16 Jul 2019 20:58:28 +1000
In-Reply-To: <20190716093301.GA32562@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
         <20190716004649.17799-2-benh@kernel.crashing.org>
         <20190716060430.GB29414@lst.de>
         <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
         <20190716093301.GA32562@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 11:33 +0200, Christoph Hellwig wrote:
> > >    So back to the version
> > > you circulated to me in private mail that just sets q->sqes and has a
> > > comment that this is magic for The Apple controller.  If/when we get
> > > standardized large SQE support we'll need to discover that earlier or
> > > do a disable/enable dance.  Sorry for misleading you down this road and
> > > creating the extra work.  
> > 
> > I think it's still ok, let me know...
> 
> Ok, let's go with this series then unless the other maintainers have
> objections.
> 
> I'm still not sure if we want to queue this up for 5.3 (new hardware
> enablement) or wait a bit, though.

The main risk is if existing controllers return crap in SQES and we try
to then use that crap. The rest should essentially be NOPs.

Maybe I should add some kind of printk to warn in case we use/detect a
non-standard size. That would help diagnosing issues.

Cheers,
Ben.


