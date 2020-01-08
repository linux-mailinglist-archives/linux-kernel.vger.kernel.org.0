Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFDF1344E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgAHOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 09:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgAHOWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:22:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97AE20692;
        Wed,  8 Jan 2020 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578493372;
        bh=J8i3km5c1S1vDwkAR9EfgL+HAWOrIMumVpDV8kFc4ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drxq+7UWVIMSpeR2A0RV+zoFkkPhWQrLSW92+B3CsY64iZ9QVw6nw2MsWKRdsugnj
         mzEcHSa9sg8d/PTpay+I/5iRelRxHlw97ooO+tni3iqt5L8tYbxmq4ipGQEwUB3LH8
         HFSSA32kKTYBoUvAyU/CLORJPfsVXC/OIP0RUWME=
Date:   Wed, 8 Jan 2020 15:22:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     felipe.balbi@linux.intel.com, rogerq@ti.com, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, kurahul@cadence.com, sparmar@cadence.com,
        Peter Chan <peter.chan@nxp.com>
Subject: Re: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Message-ID: <20200108142250.GA2383861@kroah.com>
References: <20200108113719.21551-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108113719.21551-1-pawell@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 12:37:18PM +0100, Pawel Laszczak wrote:
> The ARM core hang when access USB register after tens of thousands
> connect/disconnect operation.
> 
> The issue was observed on platform with android system and is not easy
> to reproduce. During test controller works at HS device mode with host
> connected.
> 
> The test is based on continuous disabling/enabling USB device function
> what cause continuous setting DEVDS/DEVEN bit in USB_CONF register.
> 
> For testing was used composite device consisting from ADP and RNDIS
> function.
> 
> Presumably the problem was caused by DMA transfer made after setting
> DEVDS bit. To resolve this issue fix stops all DMA transfer before
> setting DEVDS bit.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Peter Chan <peter.chan@nxp.com>
> Reported-by: Peter Chan <peter.chan@nxp.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/gadget.c | 84 ++++++++++++++++++++++++++------------
>  drivers/usb/cdns3/gadget.h |  1 +
>  2 files changed, 58 insertions(+), 27 deletions(-)

Any reason to forget linux-usb@vger.kernel.org for usb patches?

thanks,

greg k-h
