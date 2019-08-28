Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6985A0BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfH1Ulu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 16:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1Ulu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:41:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C040020828;
        Wed, 28 Aug 2019 20:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567024909;
        bh=79HWdPBNBYF5I/cWJfXDP0h0nsh+4uutZ+ovvson+AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuSQNE5RfzUZo75l7c9bzZCZZmskGhv/Pr9mf/twYV6+m8jmnVeCJIA2sJ5ObHPpv
         tUIkJEBjmgJWy1ttOVGKFm2O63hnDE8bP67mtP9fXcCRroPumTfZ4B3tlL3sL3HMuh
         Sug+LhRHKjbnlk5csHapLzDv0fs9Z/V/9ADta3Uc=
Date:   Wed, 28 Aug 2019 22:41:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 1/2 RESEND] usb: core: phy: add support for PHY
 calibration
Message-ID: <20190828204146.GA21235@kroah.com>
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
 <CGME20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5@eucas1p2.samsung.com>
 <20190808094128.27213-2-m.szyprowski@samsung.com>
 <a380a635-e036-1a18-bc0f-947931f8735c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a380a635-e036-1a18-bc0f-947931f8735c@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:55:33AM +0200, Marek Szyprowski wrote:
> Hi Greg
> 
> On 2019-08-08 11:41, Marek Szyprowski wrote:
> > Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
> > done after every USB HCD reset. Generic PHY framework has been already
> > extended with phy_calibrate() function in commit 36914111e682 ("drivers:
> > phy: add calibrate method"). This patch adds support for it to generic
> > PHY handling code in USB HCD core.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> 
> Greg: any chance to give it this a try in -next? If not, maybe You can 
> point someone whose review will help?

Ah crap, this is me, not the PHY maintainer :(

Can you resend this and I will be glad to review it.  But it would also
be good to get Felipe's review as well.

thanks,

greg k-h
