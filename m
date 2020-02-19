Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82036164862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 16:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBSPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 10:21:24 -0500
Received: from verein.lst.de ([213.95.11.211]:44874 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgBSPVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:21:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4536968B20; Wed, 19 Feb 2020 16:21:20 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:21:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
Message-ID: <20200219152120.GA18253@lst.de>
References: <20200107214215.935781-1-arnd@arndb.de> <20200130150451.GA25427@infradead.org> <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com> <20200130154815.GA2463@infradead.org> <20200213195106.GA8256@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213195106.GA8256@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:51:06AM +0900, Keith Busch wrote:
> On Thu, Jan 30, 2020 at 07:48:15AM -0800, Christoph Hellwig wrote:
> > On Thu, Jan 30, 2020 at 04:36:48PM +0100, Arnd Bergmann wrote:
> > > > This one is just gross.  I think we'll need to find some other fix
> > > > that doesn't obsfucate the code as much.
> > > 
> > > Initializing the nvme_result in nvme_features() would do it, as would
> > > setting it in the error path in __nvme_submit_sync_cmd() -- either
> > > way the compiler cannot be confused about whether it is initialized
> > > later on.
> > 
> > Given that this is outside the hot path we can just zero the whole
> > structure before submitting the I/O.
> 
> I think this should be okay:

This looks good.  Can you send a formal patch?
