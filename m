Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7D15A9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 14:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBLNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 08:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLNWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:22:23 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E562086A;
        Wed, 12 Feb 2020 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581513743;
        bh=JFrjBxqFik1XAZG6UPC/UGZmlwLQaiFVmammY5sszzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5fLyrcn7extWiTcr0jq09MUXP917ebOLZdwcP3ZIP3+Z5UNKIkrQ/IgsZ12VClH3
         CmKBh4nk5Hhs2joZoGLgZUiHya4UcxU2+VR3rSfrGb0XNZGsqgTnWXGcvCrMCrjxUX
         09EyQ/nJRB4Fyj+hjGuoaHHnXqNKfKN4gGmaEEAY=
Date:   Wed, 12 Feb 2020 05:22:22 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [External] Re: [PATCH 1/1] usb: Add MA USB Host driver
Message-ID: <20200212132222.GD1789899@kroah.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
 <20200211163906.GA1931506@kroah.com>
 <742e4af7-ad70-6607-62b0-81d11cd5b04e@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742e4af7-ad70-6607-62b0-81d11cd5b04e@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:41:12AM +0000, Vladimir Stankovic wrote:
> On 11.2.20. 17:39, gregkh@linuxfoundation.org wrote:
> > On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
> >>    39 files changed, 8668 insertions(+)
> > 
> > This is a bit hard, if not impossible, to review all in one huge patch.
> > 
> > Can you resend this as a patch series, breaking it down into logical
> > chunks, like all other kernel patches have?
> > 
> > Also, why so many individual files?  For only 8k lines, 39 files seems
> > like a huge number.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Will break it down into patch series and resend.
> 
> In regards of the file count, our intention was to ease the 
> troubleshooting efforts during development and have a clear separation 
> between logical parts of MA-USB implementation (i.e data in/out, isoch 
> in/out, etc.; each source file representing logical chunk).

Yeah, but at the very least, only have a single .h "internal" file, you
have whole files for just 1 or 2 function prototypes, that's totally
overkill.

Simple is good, you don't want to have to bounce around through multiple
files for a simple 8k line driver, that's not a good idea.

thanks,

greg k-h
