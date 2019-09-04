Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D26A88F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfIDOqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:46:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:3453 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbfIDOp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:45:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 07:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="334232146"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2019 07:45:58 -0700
Date:   Wed, 4 Sep 2019 08:44:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904144426.GB21302@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904060558.GA10849@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:05:58AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 10:46:20AM -0600, Keith Busch wrote:
> > Could we possibly make /dev/nvmeX be a subsystem handle without causing
> > trouble for anyone? This would essentially be the same thing as today
> > for non-CMIC controllers with a device-per-controller and only affects
> > the CMIC ones.
> 
> A per-subsyste character device doesn't make sense, as a lot of admin
> command require a specific controller.

Yeah, I was hoping to provide something special for CMIC controllers
so you can do path specific admin, but that looks sure to break user
space.

> If this really is an isue for people we'll just need to refcount the
> handle allocation.  That is:
> 
>  - nvme_init_ctrl allocates a new nvme_instance or so object, which
>    does the ida_simple_get.
>  - we allocate a new subsystem that reuses the handle and grabs
>    a reference in nvme_init_subsystem, then if we find an existing
>    subsystem we drop that reference again.
>  - last free of a ctrl or subsystem also drops a reference, with
>    the final free releasing the ida

Let me step through an example:

  Ctrl A gets instance 0.

  Its subsystem gets the same instance, and takes ref count on it:
  all namespaces in this subsystem will use '0'.

  Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
  no new subsytem is allocated.

  Ctrl A is disconnected, dropping its ref on instance 0, but the
  subsystem still has its refcount, making it unavailable.

  Ctrl A is reconnected, and allocates instance 2 because 0 is still in
  use.

Now all the namespaces in this subsystem are prefixed with nvme0, but no
controller exists with the same prefix. We still have inevitable naming
mismatch, right?
