Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA1A2F35
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 07:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfH3FzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 01:55:18 -0400
Received: from verein.lst.de ([213.95.11.211]:52523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfH3FzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:55:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D70C68B20; Fri, 30 Aug 2019 07:55:14 +0200 (CEST)
Date:   Fri, 30 Aug 2019 07:55:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190830055514.GC8492@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me> <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de> <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me> <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me> <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com> <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:21:02AM -0700, Sagi Grimberg wrote:
>> Yes we do, userspace should use it to order events.  Does udev not
>> handle that properly today?
>
> The problem is not ordering of events, its really about the fact that
> the chardev can be removed and reallocated for a different controller
> (could be a completely different discovery controller) by the time
> that userspace handles the event.

The same is generally true for lot of kernel devices.  We could reduce
the chance by using the idr cyclic allocator.
