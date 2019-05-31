Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A5530911
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 02:58:17 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51235 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:58:17 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1EA1060004;
        Fri, 31 May 2019 06:58:07 +0000 (UTC)
Date:   Fri, 31 May 2019 08:58:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com
Subject: Re: [PATCH v9 0/9] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20190531065806.fl4y2kex427qtysz@flea>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 29, 2019 at 04:26:06PM +0530, Jagan Teki wrote:
> This is v9 version for Allwinner A64 MIPI-DSI support
> and here is the previous version set[1].
>
> This depends on dsi host controller fixes which were
> supported in this series[2].
>
> All these changes are tested in Allwinner A64 with
> 2, 4 lanes devices and whose pixel clocks are 27.5 MHz,
> 30MHz, 55MHz and 147MHz.

I wanted to apply this, but it wouldn't apply, can you send it without
dependencies?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
