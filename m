Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC2A8BCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbfIDQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 12:05:48 -0400
Received: from verein.lst.de ([213.95.11.211]:40471 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbfIDQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D7DC227A8C; Wed,  4 Sep 2019 18:02:36 +0200 (CEST)
Date:   Wed, 4 Sep 2019 18:02:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904160235.GA20691@lst.de>
References: <20190831000139.7662-1-logang@deltatee.com> <20190831152910.GA29439@localhost.localdomain> <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com> <20190903164620.GA20847@localhost.localdomain> <20190904060558.GA10849@lst.de> <20190904144426.GB21302@localhost.localdomain> <20190904154215.GA20422@lst.de> <20190904155445.GD21302@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904155445.GD21302@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:54:45AM -0600, Keith Busch wrote:
> Can we just ensure there is never a matching controller then? This
> patch will accomplish that and simpler than wrapping the instance in a
> refcount'ed object:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html

I guess that is fine to.  Btw, what happened to the plan for udev
rules in that thread?

