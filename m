Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC94A70F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfICQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:47:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:46235 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICQrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:47:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="207151406"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2019 09:47:53 -0700
Date:   Tue, 3 Sep 2019 10:46:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190903164620.GA20847@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:08:01AM -0600, Logan Gunthorpe wrote:
> On 2019-08-31 9:29 a.m., Keith Busch wrote:
> > On Fri, Aug 30, 2019 at 06:01:39PM -0600, Logan Gunthorpe wrote:
> >> To fix this, assign the subsystem's instance based on the instance
> >> number of the controller's instance that first created it. There should
> >> always be fewer subsystems than controllers so the should not be a need
> >> to create extra subsystems that overlap existing controllers.
> > 
> > The subsystem's lifetime is not tied to the controller's. When the
> > controller is removed and releases its instance, the next controller
> > to take that available instance will create naming collisions with the
> > subsystem still using it.
> > 
> 
> Hmm, yes, ok.
> 
> So perhaps we can just make the subsystem prefer the ctrl's instance
> when allocating the ID? Then at least, in the common case, the
> controller numbers will match the subsystem numbers. Only when there's
> random hot-plugs would the numbers get out of sync.

I really don't know about a patch that works only on static
configurations. Connects and disconnects do happen on live systems,
so the numerals will inevitably get out of sync.

Could we possibly make /dev/nvmeX be a subsystem handle without causing
trouble for anyone? This would essentially be the same thing as today
for non-CMIC controllers with a device-per-controller and only affects
the CMIC ones.
