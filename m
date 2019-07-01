Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E4F96A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfD3NA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 09:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:00:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9370121670;
        Tue, 30 Apr 2019 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556629225;
        bh=6uyo25WyDxBB8idcqXt73kqZXjeBFFDDZvVdaT5bDMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wel7tJuOeiyFnNUE3BPYWvgK9s8ruu2/VD+nDgGsh+EsOXnnm95LB0h/cAUEwXQFY
         MnWzOly0L5CudBtd68+KHPcjGiRz1EDNdInSGLmKUJ/1AU4E0oNs1u1MEHdmhAN5Md
         midzc5ngvzeBG1Waf+MFTp4fCE20h5SEnFVTklbQ=
Date:   Tue, 30 Apr 2019 15:00:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vatsala Narang <vatsalanarang@gmail.com>
Cc:     stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
        f.fainelli@gmail.com, sbranden@broadcom.com, julia.lawall@lip6.fr,
        rjui@broadcom.com, linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vc04_services: bcm2835-camera: Modify return
 statement.
Message-ID: <20190430130022.GA4565@kroah.com>
References: <20190429073658.32009-1-vatsalanarang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429073658.32009-1-vatsalanarang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 01:06:58PM +0530, Vatsala Narang wrote:
> Modify return statement and remove the respective assignment.
> 
> Issue found by coccinelle.
> 
> Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

You sent two different patches that did different things with the same
exact subject: line :(

Please make them more unique.

thanks,

greg k-h
