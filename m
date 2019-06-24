Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5450536
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfFXJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:49894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfFXJKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:10:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63E10AB87;
        Mon, 24 Jun 2019 09:10:33 +0000 (UTC)
Message-ID: <1561366612.2846.10.camel@suse.com>
Subject: Re: [RFC] deadlock with flush_work() in UAS
From:   Oliver Neukum <oneukum@suse.com>
To:     Tejun Heo <tj@kernel.org>, Alan Stern <stern@rowland.harvard.edu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Mon, 24 Jun 2019 10:56:52 +0200
In-Reply-To: <20190620140937.GJ657710@devbig004.ftw2.facebook.com>
References: <1560871774.3184.16.camel@suse.com>
         <Pine.LNX.4.44L0.1906181156370.1659-100000@iolanthe.rowland.org>
         <20190620140937.GJ657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 20.06.2019, 07:10 -0700 schrieb Tejun Heo:
> Hello,
> 
> On Tue, Jun 18, 2019 at 11:59:39AM -0400, Alan Stern wrote:
> > > > Even if you disagree, perhaps we should have a global workqueue with a
> > > > permanently set noio flag.  It could be shared among multiple drivers
> > > > such as uas and the hub driver for purposes like this.  (In fact, the 
> > > > hub driver already has its own dedicated workqueue.)
> > > 
> > > That is a good idea. But does UAS need WQ_MEM_RECLAIM?
> > 
> > These are good questions, and I don't have the answers.  Perhaps Tejun 
> > or someone else on LKML can help.
> 
> Any device which may host a filesystem or swap needs to use
> WQ_MEM_RECLAIM workqueues on anything which may be used during normal
> IOs including e.g. error handling which may be invoked.  One
> WQ_MEM_RECLAIM workqueue guarantees one level of concurrency for all
> its tasks regardless of memory situation, so as long as there's no
> interdependence between work items, the workqueue can be shared.

Ouch.

Alan, in that case anything doing a reset, suspend or resume needs
to use WQ_MEM_RECLAIM, it looks to me. What do we do?

	Regards
		Oliver

