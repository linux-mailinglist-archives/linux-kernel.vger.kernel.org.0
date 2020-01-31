Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68714E897
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 07:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgAaGKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 01:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAaGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:10:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB748206A2;
        Fri, 31 Jan 2020 06:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580451040;
        bh=srVyp4ewW6yDHowNu+cBWrJB9jCJtH5Y2UsZLRs86AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIPX8dIwcXfDKhElNA+pfcSeqoal/q/6dYz3hQbD74alWh35EdLBseocTFTMyI2tg
         biuiZIOQlWgNfWymuUNL5bYeGfQbeN+kVpMf0DdFg21D9zNu+RVzahBH1UUgBCvpaT
         MfmnzoqJky8PExbvKp4+rS0HkVV5wafiTNpXaE18=
Date:   Fri, 31 Jan 2020 07:10:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200131061038.GA2180358@kroah.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:59:03PM +0000, Jolly Shah wrote:
> Hi Greg,
> 
> ﻿On 1/27/20, 10:28 PM, "linux-kernel-owner@vger.kernel.org on behalf of Greg KH" <linux-kernel-owner@vger.kernel.org on behalf of gregkh@linuxfoundation.org> wrote:
> 
>     On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
>     >     > > > +	ret = kstrtol(tok, 16, &value);
>     >     > > > +	if (ret) {
>     >     > > > +		ret = -EFAULT;
>     >     > > > +		goto err;
>     >     > > > +	}
>     >     > > > +
>     >     > > > +	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
>     >     > > 
>     >     > > This feels "tricky", if you tie this to the device you have your driver
>     >     > > bound to, will this make it easier instead of having to go through the
>     >     > > ioctl callback?
>     >     > > 
>     >     > 
>     >     > GGS(general global storage) registers are in PMU space and linux doesn't have access to it 
>     >     > Hence ioctl is used.
>     >     
>     >     Why not just a "real" call to the driver to make this type of reading?
>     >     You don't have ioctls within the kernel for other drivers to call,
>     >     that's not needed at all.
>     > 
>     > these registers are for users  and for special needs where users wants
>     > to retain values over resets. but as they belong to PMU address space,
>     > these interface APIs are provided. They don’t allow access to any
>     > other registers.
>     
>     That's not the issue here.  The issue is you are using an "internal"
>     ioctl, instead just make a "real" call.
> 
> Sorry I am not clear. Do you mean that we should use linux standard
> ioctl interface instead of internal ioctl by mentioning "real" ?

No, you should just make a "real" function call to the exact thing you
want to do.  Not have an internal multi-plexor ioctl() call that others
then call.  This isn't a microkernel :)

thanks,

greg k-h
