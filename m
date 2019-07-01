Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7EA4EA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:08:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD02208C3;
        Fri, 21 Jun 2019 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126128;
        bh=6jsH4MTy4+zhq/u0QzG9YpnTVIAk57iiJmEsRHSE4WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcL2TF8so2lJ/+I3uRM52dOgBUlATa9vuW/GRWD5Xsk5zLhz2aGSeQL+0SJImUqq0
         DX8zvGnKW0tGNuNR8hQ3XNFWCFLsLy8UGFZyrcHi+ZzRNkdp/aCI8KfqWr0c0mIE2w
         b9UvVvbZ4AMCpd4fWmIg47o1pDcfGDBgU9KiYiA4=
Date:   Fri, 21 Jun 2019 16:08:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Rob Herring <robh@kernel.org>
Subject: Re: [RE-RESEND PATCH v3 1/4] dt-bindings: memory: jz4780: Add
 compatible string for JZ4740 SoC
Message-ID: <20190621140845.GA26434@kroah.com>
References: <20190604143018.11644-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604143018.11644-1-paul@crapouillou.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:30:15PM +0200, Paul Cercueil wrote:
> Add a compatible string to support the memory controller built into the
> JZ4740 SoC from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v2: No change
>     
>     v3: Change compatible string for jz4740 instead of j4725b
> 
>  .../bindings/memory-controllers/ingenic,jz4780-nemc.txt          | 1 +
>  1 file changed, 1 insertion(+)

I guess I'll take this series...

Is there really no maintainer for drivers/memory/ anymore?


greg k-h
