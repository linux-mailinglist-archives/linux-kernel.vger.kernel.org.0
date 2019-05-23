Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6234527CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfEWMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 08:31:06 -0400
Received: from verein.lst.de ([213.95.11.211]:46548 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfEWMbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:31:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 97A7A68AFE; Thu, 23 May 2019 14:30:41 +0200 (CEST)
Date:   Thu, 23 May 2019 14:30:41 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Message-ID: <20190523123041.GB15685@lst.de>
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065400.BD9EB68B05@newverein.lst.de> <20190523090540.nhxrjpz3scx6jt23@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523090540.nhxrjpz3scx6jt23@flea>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:05:40AM +0200, Maxime Ripard wrote:
> > +Optional properties:
> > +
> > + - Video ports for RGB input and eDP output using the DT bindings
> > +   defined in [1]
> 
> The output node can be optional, but the input one is probably going
> to be needed all the time, since otherwise you won't be able to fill
> the output port of the upstream device in the graph.

I guess so. A sibling product brief (anx9804)
https://www.analogix.com/en/ttlconvertersbridges
references it as
| LVTTL to DisplayPort 1.2 _transmitter_
so it will probably always be used on the output side.

	Torsten

