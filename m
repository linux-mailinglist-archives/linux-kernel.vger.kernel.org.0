Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CAB141495
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 00:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgAQXBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 18:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:01:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6D0206D7;
        Fri, 17 Jan 2020 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579302064;
        bh=n2T1I9uSX1jfpz37HUkEr7sn2rp2COIeRV/1I+Er+NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRZFhaZxvCKs39XEV6J1s2Ht0TemnQ+ftJfs+MAuZn44Iaist4kEglY7YdwVAT1vd
         Up53JhM0g5FLHcHPy+m/8BjdiXqyqtmt0VxOqIt5/pzZx3K3sADW65tWF3baQVOeZM
         KpZVVO7bLLieD4ajQtjcq2MiMJl+9zN1r0dPiXa0=
Date:   Sat, 18 Jan 2020 00:01:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH] phy: ti: j721e-wiz: Fix build error without
 CONFIG_OF_ADDRESS
Message-ID: <20200117230102.GB2093057@kroah.com>
References: <20200117212310.2864-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117212310.2864-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 02:53:10AM +0530, Kishon Vijay Abraham I wrote:
> From: Hongbo Yao <yaohongbo@huawei.com>
> 
> If CONFIG_OF_ADDRESS is not set and COMPILE_TEST=y, the following
> error is seen while building phy-j721e-wiz.c
> 
> drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
> phy-j721e-wiz.c:(.text+0x1a): undefined reference to
> `of_platform_device_destroy'
> 
> Fix the config dependency for PHY_J721E_WIZ here.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Want me to just take this directly in my tree so the build error goes
away?

thanks,

greg k-h
