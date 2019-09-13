Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBCB2258
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfIMOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 10:37:14 -0400
Received: from verein.lst.de ([213.95.11.211]:54549 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfIMOhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:37:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A3AB68B05; Fri, 13 Sep 2019 16:37:10 +0200 (CEST)
Date:   Fri, 13 Sep 2019 16:37:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robert Baldyga <robert.baldyga@intel.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.rakowski@intel.com
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190913143709.GA8525@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913111610.9958-1-robert.baldyga@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 01:16:08PM +0200, Robert Baldyga wrote:
> Hello,
> 
> This patchset adds two functions providing kernel to kernel API
> for submiting NVMe admin commands. This is for use of NVMe-aware
> block device drivers stacking on top of NVMe drives. An example of
> such driver is Open CAS Linux [1] which uses NVMe extended LBA
> formats and thus needs to issue commands like nvme_admin_identify.

We never add functionality for out of tree crap.  And this shit really
is a bunch of crap, so it is unlikely to ever be merged. 

Why can't intel sometimes actually do something useful for a change
instead of piling junk over junk?
