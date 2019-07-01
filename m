Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064D94E1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfFUITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 04:19:07 -0400
Received: from verein.lst.de ([213.95.11.211]:36563 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfFUITG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:19:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 92F8868C4E; Fri, 21 Jun 2019 10:18:36 +0200 (CEST)
Date:   Fri, 21 Jun 2019 10:18:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20190621081836.GB17718@lst.de>
References: <20190621135616.20299058@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621135616.20299058@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:56:16PM +1000, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "css_next_descendant_pre" [block/bfq.ko] undefined!

I think the culprit is "bfq-iosched: move bfq_stat_recursive_sum into the only
caller" as that starts using css_next_descendant_pre in bfq.

I'll send a patch to export it.
