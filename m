Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21A989F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 05:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfHVDsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 23:48:46 -0400
Received: from verein.lst.de ([213.95.11.211]:43326 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfHVDsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:48:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F4D568C4E; Thu, 22 Aug 2019 05:48:42 +0200 (CEST)
Date:   Thu, 22 Aug 2019 05:48:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, josh@joshtriplett.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: don't include <linux/ktime.h> in rcutiny.h
Message-ID: <20190822034841.GA13668@lst.de>
References: <20190822015343.4058-1-hch@lst.de> <20190822030200.GX28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822030200.GX28441@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:02:00PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 22, 2019 at 10:53:43AM +0900, Christoph Hellwig wrote:
> > The kbuild reported a built failure due to a header loop when RCUTINY is
> > enabled with my pending riscv-nommu port.  Switch rcutiny.h to only
> > include the minimal required header to get HZ instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Queued for review and testing, thank you!
> 
> Do you need this in v5.4?  My normal workflow would put it into v5.5.

I hope the riscv-nommu coe gets merges for 5.4, so if we could queue
it up for that I'd appreciate it.
