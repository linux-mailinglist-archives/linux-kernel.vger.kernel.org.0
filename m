Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD8E27A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392237AbfJXBRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 21:17:47 -0400
Received: from verein.lst.de ([213.95.11.211]:43070 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfJXBRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:17:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 281F768BE1; Thu, 24 Oct 2019 03:17:44 +0200 (CEST)
Date:   Thu, 24 Oct 2019 03:17:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Message-ID: <20191024011743.GC5190@lst.de>
References: <20191023163545.4193-1-logang@deltatee.com> <20191023163545.4193-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163545.4193-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:35:41AM -0600, Logan Gunthorpe wrote:
> Instead of picking the sub-command handler to execute in a nested
> switch statement introduce a landing functions that calls out
> to the appropriate sub-command handler.
> 
> This will allow us to have a common place in the handler to check
> the transfer length in a future patch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [logang@deltatee.com: separated out of a larger draft patch from hch]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

First signoff needs to be the From line picked up by git.  I don't really
care if you keep my attribution or not, but if you do it needs From
line for me as the first theing in the mail body, and if not it
should drop by signoff and just say based on a patch from me.

Otherwise the series looks fine.
