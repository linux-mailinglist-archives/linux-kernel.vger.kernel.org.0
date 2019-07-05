Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6198B6008D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGEFWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 01:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfGEFWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:22:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229A4218A0;
        Fri,  5 Jul 2019 05:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562304131;
        bh=zPc/hFZDW3NZGoz+XDtC9wzD4pBipQw9CknQFsQjFDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOAmi0Hewyo2Fwp1kPTVZ8hoRC73tFr4syJEaZfLdpAZ8Hkv3+NPtCWYZ9n0L2zN2
         KW82P4tH5C11zKMhmFZyKzgNSmTlOhplfCJemZHMSsKECRm3vjAnhgSeqoS7zxvaxI
         v0j86Xy8SGDNvL/2QrYL/3Fo8couT3SCW88hHyO0=
Date:   Fri, 5 Jul 2019 07:22:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ryan Kennedy <ryan5544@gmail.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: pci-quirks: Correct AMD PLL quirk detection
Message-ID: <20190705052208.GE15821@kroah.com>
References: <20190704153529.9429-1-ryan5544@gmail.com>
 <20190704153529.9429-2-ryan5544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704153529.9429-2-ryan5544@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:35:28AM -0400, Ryan Kennedy wrote:
> The AMD PLL USB quirk is incorrectly enabled on newer Ryzen
> chipsets. The logic in usb_amd_find_chipset_info currently checks
> for unaffected chipsets rather than affected ones. This broke
> once a new chipset was added in e788787ef. It makes more sense
> to reverse the logic so it won't need to be updated as new
> chipsets are added. Note that the core of the workaround in
> usb_amd_quirk_pll does correctly check the chipset.
> 
> Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
> ---
>  drivers/usb/host/pci-quirks.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Should this be backported to stable kernels?

thanks,

greg k-h
