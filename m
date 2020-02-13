Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99C15B4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgBLXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:22 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F51320578;
        Wed, 12 Feb 2020 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550341;
        bh=Sx7mVuf/x+Km9lDwz5M4AufiDC+BvLCJ+/UJUAOLWB0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=S3BBEpAcBvWxAdUoD7YPP7WabTann2mJjeP9Y754XEJX02V3opsx8Dx5YARGKB4fM
         7i+3yjYCupX2cpNi/tZC31QgJV60/ltUZ6oQdvRf+IKqKs4KG6SBriSKxTVgdgoxTJ
         My01g0eaj6NyNMSxY/WCBu+E0uBLByYeAnOPx6tk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579261009-4573-4-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com> <1579261009-4573-4-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 3/4] clk: at91: usb: use proper usbs_mask
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:32:20 -0800
Message-ID: <158155034081.184098.1411951142774904787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-17 03:36:48)
> Use usbs_mask passed as argument. The usbs_mask is different for
> SAM9X60.
>=20
> Fixes: 2423eeaead6f8 ("clk: at91: usb: Add sam9x60 support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
