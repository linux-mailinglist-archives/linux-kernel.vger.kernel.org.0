Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33359882D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfHUX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:59:21 -0400
Received: from verein.lst.de ([213.95.11.211]:41874 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfHUX7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:59:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2757568C7B; Thu, 22 Aug 2019 01:59:17 +0200 (CEST)
Date:   Thu, 22 Aug 2019 01:59:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190821235916.GE9511@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu> <20190816131606.GA26191@lst.de> <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu> <20190819144922.GC6883@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819144922.GC6883@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:49:22AM -0600, Keith Busch wrote:
> On Mon, Aug 19, 2019 at 12:06:23AM -0700, Marta Rybczynska wrote:
> > ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
> > > Sorry for not replying to the earlier version, and thanks for doing
> > > this work.
> > > 
> > > I wonder if instead of using our own structure we'd just use
> > > a full nvme SQE for the input and CQE for that output.  Even if we
> > > reserve a few fields that means we are ready for any newly used
> > > field (at least until the SQE/CQE sizes are expanded..).
> > 
> > We could do that, nvme_command and nvme_completion are already UAPI.
> > On the other hand that would mean not filling out certain fields like
> > command_id. Can do an approach like this.
> 
> Well, we need to pass user space addresses and lengths, which isn't
> captured in struct nvme_command.

Well, the address would fit into the data pointer.  But yes, the lack
of a command length concept in nvme makes this idea a mess and not
really workable.
