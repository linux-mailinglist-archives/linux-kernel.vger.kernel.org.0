Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93C190C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCXL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 07:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCXL30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:29:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD77C2070A;
        Tue, 24 Mar 2020 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585049366;
        bh=Q7xJEGXoZpQ72BugiShJ9/tytzW/LsLezeR1V01a8PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhZiwneR9c0fKNJJtEFPClnXbwkopybQJtFH2tb8WtrL08DO9Vx3u5jbJ2g7yHrav
         VyP/u67h3WWJSTjrxC+C2H+akkx5aLH8OTg14wFvA4sVgJ6NvHS/coUTtUPhbg2CER
         SAGZmeI9KkUJhLlp0zKDpBX1j4vIcjvJuaiD3vUo=
Date:   Tue, 24 Mar 2020 12:29:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
Message-ID: <20200324112923.GA2275821@kroah.com>
References: <20200324064949.23697-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324064949.23697-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:49:49PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> kbuild-test reported an error:
> 
>   config: mips-randconfig-a001-20200321 ...
>   >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
>   to `clk_set_parent'
> 
> Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
> so it's probably that clk_set_parent is missed for those configs.
> 
> To fix this error, this patch adds dependence on ARM || ARM64
> for SERIAL_SPRD.
> 
> Fixes: 7ba87cfec71a ("tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index b43dce785a58..417f7e45a3f8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1444,6 +1444,7 @@ config SERIAL_MEN_Z135
>  config SERIAL_SPRD
>  	tristate "Support for Spreadtrum serial"
>  	select SERIAL_CORE
> +	depends on ARM || ARM64 || COMPILE_TEST

Why not just depend on the proper CLK config option instead?

thanks,

greg k-h
