Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22213143D96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 14:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAUNDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 08:03:16 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51310 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MIW1a1CzdzcRBKcD9gTvgSedoGDPOuKCDCTKx1yi8/I=; b=tQtN4IdeDDjJluRJEDxx6qRjy
        aKKTYwoJ8e/flf0xfU9SX2MxmDxP4hyzo/wN4btmpSwSh2FWxqjT4yQLV2lP/ofnd7UsuXJpf7MxV
        by72E3J1keyyZ0e7pzurn9uXxSyHoEiSSPAyPKkegrxFHbLUyq6KBpoh8qsFN/BpuakdXG/FaqfON
        NL87FSdLt12y0mxnnFcXhhbMgNjsD7GVWeaV/HqICX0vYeOQxxkZTdlzMq4UQYbhwQsvWq0zESjKU
        LR3z0e1oMV+DQDDFRfd1c+mh+hIvqm2y/h8zPXXswSBb6mk/h1hmbAFOWR/7HZmA6dyTBvIgigr7D
        c1Lm4Qy/Q==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:57886)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ittB9-0004iM-8Q; Tue, 21 Jan 2020 13:02:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ittB4-0003qO-3m; Tue, 21 Jan 2020 13:02:42 +0000
Date:   Tue, 21 Jan 2020 13:02:42 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2
 seconds
Message-ID: <20200121130241.GG25745@shell.armlinux.org.uk>
References: <20200121114553.2667556-1-arnd@arndb.de>
 <20200121125546.GA71415@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121125546.GA71415@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 01:55:46PM +0100, Guido G�nther wrote:
> Hi,
> On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> > As Guido G�nther reported, get_abs_timeout() in the etnaviv user space
> > sometimes passes timeouts with nanosecond values larger than 1000000000,
> > which gets rejected after my first patch.
> > 
> > To avoid breaking this, while also not allowing completely arbitrary
> > values, set the limit to 1999999999 and use set_normalized_timespec64()
> > to get the correct format before comparing it.
> 
> I'm seeing values up to 5 seconds so I need
> 
>      if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))

I assume you're looking at 64-bit, but I suspect userspace needs
looking at considering 32-bit.  If userspace uses a 32-bit tv_nsec
anywhere in the path that it attempts to pass up to 5 seconds in
tv_nsec, then this will fail to pass the correct timeout.

If that is the case, userspace is buggy, and needs fixing not to
pass such large values through tv_nsec irrespective of this issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
