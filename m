Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A393884FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfHGPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 11:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388257AbfHGPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:22:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C833D2199C;
        Wed,  7 Aug 2019 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565191338;
        bh=fT682hdrISgNXZBslLUtKlTZkoUPbA02ONx4Yr2ztgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VotQQBsc3UrvBQjlUi2YgwRp+DsSfCbJclFfcF8tHQ2WamyGB7DQGoHr2EFjZJuIJ
         Am+K9sRBsnXPEpkBFc1AuyV9eOOKjUFY+ENhRNvHCUumqBo2VtoGdOeXMSRjMILiSU
         sRfB8VINE57EjSFue1lZmDmMvytu5nWzOMyFXtys=
Date:   Wed, 7 Aug 2019 17:22:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     palmer@sifive.com, arnd@arndb.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
Message-ID: <20190807152215.GA26690@kroah.com>
References: <20190807151009.31971-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807151009.31971-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 06:10:09PM +0300, Christoph Hellwig wrote:
> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way that doesn't fit the SiFive SOCs.
> 
> Move the file to drivers/misc and only build it when the EDAC_SIFIVE
> config option is selected.
> 
> Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/mm/Makefile                            | 1 -
>  drivers/misc/Makefile                             | 1 +
>  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)

Why isn't this in drivers/edac/ ?
why is this a misc driver?  Seems like it should sit next to the edac
stuff.

thanks,

greg k-h
