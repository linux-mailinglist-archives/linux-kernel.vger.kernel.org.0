Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B06374BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfFFNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfFFNBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:01:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C5120868;
        Thu,  6 Jun 2019 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826100;
        bh=EN9zUwAcL3AXZP3QZtJEGsMjw/tRawYug3D5+1DDlKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xQj7et+FOev/L/1N883bSb2+xDQH2aqHmYkJnJ7pu7qL559seDX/VlO1QSWv0mZ4B
         NirBpBDcuA4qYGEWYeXfJl7huSpF+7OjDVcS8kdtLVajr3u81cJKvgWMBiQqEyzpG8
         xWAaUEmGp9besWEjN8i0/RKV9xk7hsXRTA4wV5Fs=
Date:   Thu, 6 Jun 2019 15:01:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com
Subject: Re: [PATCH v3 4/4] staging: rtl8712: Fixed CamelCase wkFilterRxFF0
 and lockRxFF0Filter
Message-ID: <20190606130137.GD1140@kroah.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
 <da04945b71fd7909fb03edd2c4d188588cb172fe.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da04945b71fd7909fb03edd2c4d188588cb172fe.1559615579.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:51:36AM +0530, Deepak Mishra wrote:
> This patch renames CamelCase variable wkFilterRxFF0 to wk_filter_rx_ff0
> in drv_types.h and related files rtl871x_xmit.c and xmit_linux.c as
> reported by checkpatch.pl
> 
> This patch renames CamelCase variable lockRxFF0Filter to lock_rx_ff0_filter
> in drv_types.h and related files usb_intf.c and xmit_linux.c as
> reported by checkpatch.pl

Again, two different patches please.

Please fix up this whole series and resend.

thanks,

greg k-h
