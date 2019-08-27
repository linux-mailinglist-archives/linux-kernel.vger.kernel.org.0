Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9011C9F33E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfH0TXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0TXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:23:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DF72186A;
        Tue, 27 Aug 2019 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566933795;
        bh=5GxRaYQpsSrEY18mLerEygSRglUTGisH5Sdlxt/e3IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V243k2QO+b40dDubu8XwwTHzTNajGBUZhsyLCkTboNIWG6tBP4djyWm0E5VtwzUU/
         x4JV6jAhWnaHFBOHxJykvw+eaut4fdEXcdOB/o425WK/Kbj/nLXK85Un3yahVLyyIu
         LDFNqxZoqOipVy+8lXY5xdj7pbNBxfnWJQ7+XQOE=
Date:   Tue, 27 Aug 2019 21:23:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] USB: storage: ums-realtek: Whitelist auto-delink
 support
Message-ID: <20190827192313.GA6750@kroah.com>
References: <20190827173450.13572-2-kai.heng.feng@canonical.com>
 <Pine.LNX.4.44L0.1908271454110.1545-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908271454110.1545-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:56:36PM -0400, Alan Stern wrote:
> On Wed, 28 Aug 2019, Kai-Heng Feng wrote:
> 
> > Auto-delink requires writing special registers to ums-realtek devices.
> > Unconditionally enable auto-delink may break newer devices.
> > 
> > So only enable auto-delink by default for the original three IDs,
> > 0x0138, 0x0158 and 0x0159.
> > 
> > Realtek is working on a patch to properly support auto-delink for other
> > IDs.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1838886
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> > - Whitelisting instead of adding new module parameter.
> > v2:
> > - Use auto_delink_support instead of auto_delink_enable.
> > 
> >  drivers/usb/storage/realtek_cr.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> > index beaffac805af..1d9ce9cbc831 100644
> > --- a/drivers/usb/storage/realtek_cr.c
> > +++ b/drivers/usb/storage/realtek_cr.c
> > @@ -996,12 +996,15 @@ static int init_realtek_cr(struct us_data *us)
> >  			goto INIT_FAIL;
> >  	}
> >  
> > -	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> > -	    CHECK_FW_VER(chip, 0x5901))
> > -		SET_AUTO_DELINK(chip);
> > -	if (STATUS_LEN(chip) == 16) {
> > -		if (SUPPORT_AUTO_DELINK(chip))
> > +	if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
> > +	    CHECK_PID(chip, 0x0159)) {
> > +		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> > +				CHECK_FW_VER(chip, 0x5901))
> >  			SET_AUTO_DELINK(chip);
> > +		if (STATUS_LEN(chip) == 16) {
> > +			if (SUPPORT_AUTO_DELINK(chip))
> > +				SET_AUTO_DELINK(chip);
> > +		}
> >  	}
> >  #ifdef CONFIG_REALTEK_AUTOPM
> >  	if (ss_en)
> 
> For both patches in this series:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Shouldn't this patch go into the -stable kernels as well?

Yes, I can do that.

thanks,

greg k-h
