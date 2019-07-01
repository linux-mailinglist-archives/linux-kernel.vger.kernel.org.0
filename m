Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA727C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfEWLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:52:48 -0400
Received: from verein.lst.de ([213.95.11.211]:46327 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729863AbfEWLws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:52:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 79A4768AFE; Thu, 23 May 2019 13:52:24 +0200 (CEST)
Date:   Thu, 23 May 2019 13:52:24 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/bridge: extract some Analogix I2C DP common
 code
Message-ID: <20190523115224.GA15685@lst.de>
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065352.8FD7668B05@newverein.lst.de> <CAGb2v66+1+goJfnY7nWTGN2fupqMUm5o+gkPdUW6nxcwQEDwog@mail.gmail.com> <20190523075035.GA5971@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523075035.GA5971@pendragon.ideasonboard.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:50:35AM +0300, Laurent Pinchart wrote:
> On Thu, May 23, 2019 at 03:40:25PM +0800, Chen-Yu Tsai wrote:
> > 
> > If this was simple code movement, then the original copyright still applies.
> > A different copyright notice should not be used. I suppose the same applies
> > to the module author.
> 
> And likely to patch 2/6 too.

Absolutely correct. Wdiff does not lie.
Re-evaluating...

	Torsten

