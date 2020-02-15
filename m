Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D515FBD6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBOA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBOA6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:38 -0500
Received: from localhost (unknown [38.98.37.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFF720726;
        Sat, 15 Feb 2020 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581728318;
        bh=epAipassIVTXLEk61xbPswQ/wJFZR8JeHH7+aNFL18w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ7VCwPEWnIEAj+lS8iPopr8Gi5FgFwj1wdOvOdgCLWp/8gK/V4Ij8yF6l734w1Cf
         n0D+VkC39CWrj1swmFEjR1TCM2g9XODsAG9y930H/cSJzSGIvYyyXCTw1obME+cKus
         SU8s68S+0oKLyV1ne3cxnSsHAmp0LQX5c6pSXhaE=
Date:   Fri, 14 Feb 2020 19:52:35 -0500
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     Rajan Vaja <RAJANV@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200215005235.GA32359@kroah.com>
References: <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
 <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
 <20200214171005.GB4034785@kroah.com>
 <c2914eae-bf95-ad51-79a4-07f199f37e27@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2914eae-bf95-ad51-79a4-07f199f37e27@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:37:16PM -0800, Jolly Shah wrote:
> > Just make the direct call to the firmware driver, no need to muck around
> > with tables of function pointers.  In fact, with the spectre changes,
> > you just made things slower than needed, and you can get back a bunch of
> > throughput by removing that whole middle layer.
> > 
> 
> arm,scpi is doing the same way and we thought this approach will be more
> acceptable than direct function calls but happy to change as suggested.

Just because one random tiny thing does it the wrong way does not mean
to focus on that design pattern and ignore the thousands of other
apis/interfaces in the kernel that do not do it that way :)

> > So go do that first please, before adding any new stuff.
> > 
> > Now for the ioctl, yeah, that's not a "normal" pattern either.  But
> > right now you only have 2 "different" ioctls that you call.  So why not
> > just turn those 2 into real function calls as well that then makes the
> > "ioctl" call to the hardware?  That makes things a lot more obvious on
> > the kernel driver side exactly what is going on.
> > 
> 
> Sure as i understand firmware driver will provide real function calls to be
> used by user drivers and underneath it will call ioctl for desired
> operation. Please correct if I misunderstood.

You do not misunderstand.

thanks,

greg k-h
