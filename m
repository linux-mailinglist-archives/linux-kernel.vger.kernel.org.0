Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68FB169E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfEGSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 14:03:32 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36948 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfEGSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:03:31 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7EC71803E1;
        Tue,  7 May 2019 20:03:28 +0200 (CEST)
Date:   Tue, 7 May 2019 20:03:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] drm/panel: simple: Add FriendlyELEC HD702E
 800x1280 LCD panel
Message-ID: <20190507180327.GB15122@ravnborg.org>
References: <20190507130708.11255-1-jagan@amarulasolutions.com>
 <20190507130708.11255-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507130708.11255-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dTbK6rJxFaEA:10
        a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
        a=iP-xVBlJAAAA:8 a=GLhCdgaH8IlrsrkRQw4A:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=AjGcO6oz07-iQ99wixmX:22 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 06:37:07PM +0530, Jagan Teki wrote:
> HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> resolution. It has built in Goodix, GT9271 captive touchscreen
> with backlight adjustable via PWM.
> 
> Add support for it.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Patch applied to drm-misc-next

	Sam
