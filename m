Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5717113AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEBHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 03:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfEBHHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:07:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9159208C4;
        Thu,  2 May 2019 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556780868;
        bh=R58soqJU4/GFbmzVt6nBZnewIAmHT909NOZ409AkhRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BO285Ep1LVasDMxvVq5Od9DRgRNO6bDWc1jYgn8yTtbgsFfHfewSjEVStJsT8NoOX
         JE3DiwPqAY24RWeqhUvVu5iPxDvrgLOBCG2FKR+EKtD88UumZ50usRkb0kDkqcvlR3
         fDbgLrJVG5TsOSfcOW6M3RP1qdznJtq2VvCZYhO4=
Date:   Thu, 2 May 2019 09:07:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH] clk: actions: Use the correct style for SPDX License
 Identifier
Message-ID: <20190502070746.GA16247@kroah.com>
References: <20190501070707.GA5619@nishad>
 <057d9b37-7475-1902-bce7-6d519c2e0fdf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <057d9b37-7475-1902-bce7-6d519c2e0fdf@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:20:44PM +0200, Andreas F�rber wrote:
> + linux-actions
> 
> Am 01.05.19 um 09:07 schrieb Nishad Kamdar:
> > This patch corrects the SPDX License Identifier style
> > in header files related to Clock Drivers for Actions Semi Socs.
> > For C header files Documentation/process/license-rules.rst
> > mandates C-like comments (opposed to C source files where
> > C++ style should be used)
> [...]
> >  drivers/clk/actions/owl-common.h       | 2 +-
> >  drivers/clk/actions/owl-composite.h    | 2 +-
> >  drivers/clk/actions/owl-divider.h      | 2 +-
> >  drivers/clk/actions/owl-factor.h       | 2 +-
> >  drivers/clk/actions/owl-fixed-factor.h | 2 +-
> >  drivers/clk/actions/owl-gate.h         | 2 +-
> >  drivers/clk/actions/owl-mux.h          | 2 +-
> >  drivers/clk/actions/owl-pll.h          | 2 +-
> >  drivers/clk/actions/owl-reset.h        | 2 +-
> >  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> Where's the practical benefit of this patch? These are all private
> headers used from C files, so they can handle C++ comments just fine,
> otherwise we would've seen build failures.

Please read Documentation/process/license-rules.rst, the section
entitled "Style", for what the documented formats are for SPDX lines,
depending on the file type.

thanks,

greg k-h
