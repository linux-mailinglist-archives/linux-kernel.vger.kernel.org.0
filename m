Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664735F965
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfGDNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 09:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfGDNxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:53:32 -0400
Received: from localhost (unknown [89.205.128.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285AE21852;
        Thu,  4 Jul 2019 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562248411;
        bh=mecZjwh3Y89aOPTjx4iFFL4wJwUA+rb6dpnDwYt/0/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XK9LOPv1ZgpIW+3zZD6azf/8CzfDRdzGsySHQiqFXxWVUcx8EuZwDW1mlf1+ywByb
         IfiE5HJmHTFOoWc6Xmhr8z5J+Kz0OEsDRvfloTGhpZt/tB03zSnsrR48QKCtDooowc
         gYxudayXSvGCXB6kWDP1PFoLEMmeWOTm3iwgYBxs=
Date:   Thu, 4 Jul 2019 15:53:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     fugang.duan@nxp.com
Cc:     linux-serial@vger.kernel.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, u.kleine-koenig@pengutronix.de,
        daniel.baluta@nxp.com
Subject: Re: [PATCH RESEND tty/serial 1/1] tty: serial: fsl_lpuart: add
 imx8qxp support
Message-ID: <20190704135327.GA27565@kroah.com>
References: <20190704134007.2316-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704134007.2316-1-fugang.duan@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:40:07PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> The lpuart of imx8ulp is basically the same as imx7ulp, but it
> has new feature support based on imx7ulp, like it can assert a
> DMA request on EOP(end-of-packet). imx8ulp lpuart use two clocks,
> one is ipg bus clock that is used to access registers, the other
> is baud clock that is used to transmit-receive data.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 106 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 86 insertions(+), 20 deletions(-)

You need to list what changed from the last version below the --- line.

Anyway, I'll take this as-is, next time :)

thanks,

greg k-h
