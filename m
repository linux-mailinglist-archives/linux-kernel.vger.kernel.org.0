Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562EE15B4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgBLXcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:12 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5F82168B;
        Wed, 12 Feb 2020 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550331;
        bh=yGxWmnU0+bJf4NtlQJ8vSgLa6xFdajfDlMYE/Tc3ORA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XmU58SVU3TWs/JJizkYx4X758sgRAxYgmTw5/2yQ1GlXVwnoGphaIIvsop8FS5caf
         g3JQ3pkxzxf5+b56xR93ObzS3hVxNjirI9uEgi4hJR0OkYYsoMmSTC/KzyAfAHSwsM
         /aG6ZlcexKl7ajVJWjX1NrLR/Dz9gDvdum1W+tTQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579261009-4573-3-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com> <1579261009-4573-3-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 2/4] clk: at91: sam9x60: fix usb clock parents
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:32:11 -0800
Message-ID: <158155033113.184098.17218232086067316238@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-17 03:36:47)
> SAM9X60's USB clock has 3 parents: plla, upll and main_osc.
>=20
> Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
