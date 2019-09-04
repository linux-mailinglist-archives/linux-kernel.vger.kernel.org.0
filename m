Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5EA89C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfIDP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 11:56:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:10024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIDP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:56:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="199059841"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 08:56:16 -0700
Date:   Wed, 4 Sep 2019 09:54:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904155445.GD21302@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904154215.GA20422@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:42:15PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2019 at 08:44:27AM -0600, Keith Busch wrote:
> > Let me step through an example:
> > 
> >   Ctrl A gets instance 0.
> > 
> >   Its subsystem gets the same instance, and takes ref count on it:
> >   all namespaces in this subsystem will use '0'.
> > 
> >   Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
> >   no new subsytem is allocated.
> > 
> >   Ctrl A is disconnected, dropping its ref on instance 0, but the
> >   subsystem still has its refcount, making it unavailable.
> > 
> >   Ctrl A is reconnected, and allocates instance 2 because 0 is still in
> >   use.
> > 
> > Now all the namespaces in this subsystem are prefixed with nvme0, but no
> > controller exists with the same prefix. We still have inevitable naming
> > mismatch, right?
> 
> I think th major confusion was that we can use the same handle for
> and unrelated subsystem vs controller, and that would avoid it.
>
> I don't see how we can avoid the controller is entirely different
> from namespace problem ever.

Can we just ensure there is never a matching controller then? This
patch will accomplish that and simpler than wrapping the instance in a
refcount'ed object:

http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
