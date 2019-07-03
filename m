Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED185EA95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGCRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 13:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:37:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A350021881;
        Wed,  3 Jul 2019 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562175472;
        bh=oZ/gpRiCpn8yVQw6a+HAz6EIm0c0NOdplYkVDqMB1XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpVsSPEq+OiKvtAinPNI3YQFAuBe6jMBomeYY0qqdvKacMGrqzPR4Fs6J5Xi6uNoi
         zS/4PTd0SjlK7DW1b8MiJ+aff/2+zUSAbRisGTpPyw+BCNXUHLUGLCDYkinuA7kE65
         vnj3T3AfGom/yT2OvdyemZAB35+BJMS7+QhxWfG0=
Date:   Wed, 3 Jul 2019 19:37:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/usb/typec/tps6598x.c: fix portinfo width
Message-ID: <20190703173749.GA8298@kroah.com>
References: <20190628083417.GA21701@kuha.fi.intel.com>
 <f8daf204d49fff00db33e2b417a20afcc58ad56e.1561712364.git.nikolaus.voss@loewensteinmedical.de>
 <20190628095843.GB21701@kuha.fi.intel.com>
 <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
 <20190703163908.GB17160@kroah.com>
 <alpine.DEB.2.20.1907031924190.23225@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1907031924190.23225@fox.voss.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:25:53PM +0200, Nikolaus Voss wrote:
> On Wed, 3 Jul 2019, Greg Kroah-Hartman wrote:
> > On Fri, Jun 28, 2019 at 12:10:41PM +0200, Nikolaus Voss wrote:
> > > On Fri, 28 Jun 2019, Heikki Krogerus wrote:
> > > > On Fri, Jun 28, 2019 at 11:01:08AM +0200, Nikolaus Voss wrote:
> > > > > Portinfo bit field is 3 bits wide, not 2 bits. This led to
> > > > > a wrong driver configuration for some tps6598x configurations.
> > > > > 
> > > > > Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> > > > > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > > 
> > > > Shouldn't this be applied to the stable trees as well?
> > > 
> > > Oh, yes, forgot that again... Greg, could you...?
> > 
> > It's not like I have anything else to do... :)
> 
> I know. Sorry. I'll repost if you want, just say ick or something then...

Already merged, no worries.
