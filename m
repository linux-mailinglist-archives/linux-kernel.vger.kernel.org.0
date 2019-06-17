Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE47647BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfFQIPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:15:52 -0400
Received: from verein.lst.de ([213.95.11.211]:33798 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQIPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:15:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A0D1768AFE; Mon, 17 Jun 2019 10:15:20 +0200 (CEST)
Date:   Mon, 17 Jun 2019 10:15:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20190617081520.GA7310@lst.de>
References: <20190617181439.42cf10e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617181439.42cf10e5@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:14:39PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   kernel/dma/remap.c
> 
> between commit:
> 
>   4b4b077cbd0a ("dma-remap: Avoid de-referencing NULL atomic_pool")
> 
> from the dma-mapping tree and commit:
> 
>   14de8ba3fa2e ("lib/genalloc.c: rename addr_in_gen_pool to gen_pool_has_addr")

I really wish we could drop this pointless rename, and also the export
until we have actual users.
