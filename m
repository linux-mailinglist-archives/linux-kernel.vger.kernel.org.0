Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290057DE8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfHAPOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfHAPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:14:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EBE206B8;
        Thu,  1 Aug 2019 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564672451;
        bh=abPguqKEOMLTrCcU2P2/jVixA9k9aQ63IoisxRSIwBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z49Q/dNnsW4m/Vs0lHcUASw5PJAlp8W6hfuITfIg0qpsCoo61kxziMx4EKLRiS8Y+
         MzLxDr4ItWUbUotJgD6iWxhOa5FrJouUedzlKPOyoBj6bJ08i9j1APCM3tx22vGWBP
         MqFH5lmLUbfbU13MnZ/Ik45s4tAkr37DSNfI2PcU=
Date:   Thu, 1 Aug 2019 17:14:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/23] LPUART fixes and improvements
Message-ID: <20190801151409.GA4508@kroah.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
 <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:59:59PM -0300, Fabio Estevam wrote:
> Hi Andrey,
> 
> On Wed, Jul 31, 2019 at 2:53 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Everyone:
> >
> > This series contains fixes/improvements to LPUART dirver I came up
> > with recently as well as fixes picked up from Toradex and NXP Vybrid
> > repos.
> >
> > Feedback is welcome!
> >
> > Changes since [v1]:
> 
> Greg has already applied some of these patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing
> 
> Please rebase on his tree and send the remaining ones.

Yes, I can't drop patches I have already applied.  Andrey, just resend
the ones that I have not applied.

thanks,

greg k-h
