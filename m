Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8915E9B21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJ3LvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 07:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:51:09 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED9920874;
        Wed, 30 Oct 2019 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572436269;
        bh=rlcndvnVGEnLCgirhge887TBNRINVI5atNmAzUyijMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zu2vSxu3X77BFUc82evYsrKClmS5lWteyuo2a1QDC421l6ngfp5mMZzqlJXb8u4Fh
         PX4ZMPOEqA8diG2CjfceHR63/DxU0V+o3xxG7uzNQrUeuoSw304WnnypvJOw80b+Tg
         OzC9hd1un7/7CwPOWajtABTuUL9XjXFQkf/GB96E=
Date:   Wed, 30 Oct 2019 12:51:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Roger Quadros <rogerq@ti.com>, pawell@cadence.com,
        peter.chen@nxp.com, nsekhar@ti.com, kurahul@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected
 to Super-Speed host
Message-ID: <20191030115106.GA701802@kroah.com>
References: <20191029151514.28495-1-rogerq@ti.com>
 <87y2x2e9s0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2x2e9s0.fsf@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 01:46:07PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
> > Take into account gadget driver's speed limit when programming
> > controller speed.
> >
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> > Hi Greg,
> >
> > Please apply this for -rc.
> 
> if you want this in -rc, you should have a Fixes line there.

I agree, I can't take this for -rc as-is :(

