Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61EE3C83E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405223AbfFKKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404572AbfFKKLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:11:24 -0400
Received: from localhost (unknown [171.76.113.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EEE82089E;
        Tue, 11 Jun 2019 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560247884;
        bh=+ZDyPqWTovVVGCJsjzfmYX4FIQawCX/JqLFetsqmSfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgXAMefrK5tfJhn0TOTRwbPA3aPeRGKpC8Os+Rlcj+vtaJfBtA8lKezFqTP0zXHUX
         Ojr8Ehpv20U2ow20OElGsDZjlzZCcO16+7l8cyh9GMcNG5PK0X6dNgaNg/0oaZxqVi
         ppDUpsAnIv+BySPEPbCZ8YttALi0guNheJRr9KuI=
Date:   Tue, 11 Jun 2019 15:38:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20190611100815.GX9160@vkoul-mobl.Dlink>
References: <20190611163246.6f90fba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611163246.6f90fba6@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-19, 16:32, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the slave-dma tree got a conflict in:
> 
>   include/linux/sudmac.h
> 
> between commit:
> 
>   49833cbeafa4 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 311")
> 
> from Linus' tree and commit:
> 
>   9a0f780958bb ("dmaengine: sudmac: remove unused driver")
> 
> from the slave-dma tree.
> 
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any

Thanks Stephen,

I will keep this in mind before I send this to Linus

> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
