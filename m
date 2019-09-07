Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C871AC451
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 06:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfIGEBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 00:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfIGEBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 00:01:20 -0400
Received: from localhost (unknown [194.251.198.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082902070C;
        Sat,  7 Sep 2019 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567828879;
        bh=XlHMzdxEhCU8TNX/JZPcZ4hHgdKXexPwcQhZPxEgtMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+7P3y/LZpSbeOzfqFEfzeCra5uDxJmaJM5SFdpbqIllO05qVgI9X8WtwtG6rsmun
         KffS7FdNpFbVTZXwUMWL3GPgi6E/Wuhpxe761/2CfMNmMiVCfhXTHoHJIh+ltQ1r8S
         eFiXZe7lAI7xVOTHo/Av1l2SP6qf/5GT86OXUq7o=
Date:   Sat, 7 Sep 2019 06:54:53 +0300
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/9] crypto: Add allwinner subdirectory
Message-ID: <20190907035453.urfqmdg3kg4kbtgc@flea>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-2-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906184551.17858-2-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:45:43PM +0200, Corentin Labbe wrote:
> Since a second Allwinner crypto driver will be added, it is better to
> create a dedicated subdirectory.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  MAINTAINERS                      | 6 ++++++
>  drivers/crypto/Kconfig           | 2 ++
>  drivers/crypto/Makefile          | 1 +
>  drivers/crypto/allwinner/Kconfig | 6 ++++++

I guess it would make sense to move the sun4i driver there too?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
