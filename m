Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D65130683
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 08:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAEHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 02:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:22:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5A4217F4;
        Sun,  5 Jan 2020 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578208928;
        bh=36YMIfds6bcjOeZrdHkRP5guH3R8Wyde9Xa7tDKb8pI=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=Y5pNq0reydLkdp82SHfKPQEDwJd7XZHJbQ4N8+70XSxR5RX0nrt+g1d7r2CQH5LSo
         F9xVK8on6mx2cKZ8ys9ezNjDWKdtJZ0TjUIaAK9bmB2nsPAl/J1u9hsSuiJ5URoooC
         9E4xYTSsfY6DWyMHj9u5D2js3Z2qHFmt6TTmrtmY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200102005503.71923-1-sboyd@kernel.org>
References: <20200102005503.71923-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] clk: Warn about critical clks that fail to enable
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:22:07 -0800
Message-Id: <20200105072208.0B5A4217F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-01 16:55:03)
> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's print a warning in that case so developers find these
> problems faster.
>=20
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

