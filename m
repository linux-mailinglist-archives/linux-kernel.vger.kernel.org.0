Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA523752E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfFFN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfFFN0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:26:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEAA520866;
        Thu,  6 Jun 2019 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559827592;
        bh=+YFE5KfxRqfYtx6rWWzBRcfeTGDL0h4C05kyoVGm8/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2TQ96GlbngiJ3UHV2MJizMMOMHTKuu8n0r9WABtfcnIaw3SsHmWEKeHcYck6Z0RpA
         ttXxBM44zNh+0vE0zX5s5CO3KrAj4B0NbxOBeU4p19sfHBxKUXPwFKHbn/tM2Vt/Qf
         rMegbanfCqBR641qvx9IOaLkNRj9FYuVpKos0x1o=
Date:   Thu, 6 Jun 2019 15:26:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190606132629.GB7943@kroah.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> Add char device interface per DT node present and support
> file operations:
> - open(),
> - close(),
> - unlocked_ioctl(),
> - compat_ioctl().
> 
> Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> ---
>  drivers/misc/xilinx_sdfec.c      | 57 +++++++++++++++++++++++++++++++++++++---
>  include/uapi/misc/xilinx_sdfec.h |  4 +++
>  2 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index ff32d29..740b487 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -51,7 +51,6 @@ struct xsdfec_clks {
>   * @regs: device physical base address
>   * @dev: pointer to device struct
>   * @config: Configuration of the SDFEC device
> - * @open_count: Count of char device being opened

Why is this removed here?  You don't add something in one patch and then
remove it in a later one if it's never needed :)

thanks,

greg k-h
