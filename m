Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7980659E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF1PM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfF1PM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:12:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26901208E3;
        Fri, 28 Jun 2019 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561734748;
        bh=+ZbXIcvRp5Qmho+u63VDjM/Qf/GfS2IXDAt3/rMml+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uf3fQtJGO0vrZZnYpQ0n7anY7cN+9C39YrTwd9tYSPpgd8Kf2Mm9p2ap3elUABous
         DeTCsB03QbHbgnfV0GIoYupeJXZdNKxjSD4O53FlFKt6FO25kyVbfTsLIIqyFFg9SB
         96615WCgmGVzA3BwqpSo4yCwtN/iUJzIjX8czr0Q=
Date:   Fri, 28 Jun 2019 17:12:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enrico Weigelt <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devres: allow const resource arguments
Message-ID: <20190628151226.GA14736@kroah.com>
References: <20190628150049.1108048-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628150049.1108048-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:59:45PM +0200, Arnd Bergmann wrote:
> devm_ioremap_resource() does not currently take 'const' arguments,
> which results in a warning from the first driver trying to do it
> anyway:
> 
> drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
> drivers/gpio/gpio-amd-fch.c:171:49: error: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
>                                                  ^~~~~~~~~~~~~~~~~~~
> 
> Change the prototype to allow it, as there is no real reason not to.
> 
> Fixes: 9bb2e0452508 ("gpio: amd: Make resource struct const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The warning is currently in Linus Walleij's gpio tree, so I would
> suggest he can queue up this fix as well, if Greg (or whoever
> feels responsible for devres) agrees.

That's fine with me if Linus takes it:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
