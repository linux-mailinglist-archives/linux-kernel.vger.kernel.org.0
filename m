Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A062713682F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 08:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAJHSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 02:18:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44061 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgAJHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:18:47 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoZ1-0002MZ-4M; Fri, 10 Jan 2020 08:18:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoZ0-0002Cm-5e; Fri, 10 Jan 2020 08:18:34 +0100
Date:   Fri, 10 Jan 2020 08:18:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200110071834.jewrtgqbwrpjdweq@pengutronix.de>
References: <20200109072735.GA22886@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109072735.GA22886@embeddedor>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> 
> The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
> Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patchwork seems to have missed my earlier reply with my Reviewed-by:.
(https://patchwork.ozlabs.org/patch/1220206/ only has Clément's reply
that still contains my quoted text, but obviously this wasn't picked up
by patchwork.)

So resending it in the hope this was a one-time miss:

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
