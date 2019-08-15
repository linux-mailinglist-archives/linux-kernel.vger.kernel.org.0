Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E528EF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfHOPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 11:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfHOPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:18:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA999206C1;
        Thu, 15 Aug 2019 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565882327;
        bh=emtmpN8koXyGRnpKRd+goYJhZ3VVizKGLhWaG2eElpw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CgTdZg7C4TKnbBcwJyBIKQohYSn3rP7ceSj4iWdoGWybsqCHWcLT6u2zkbpHNS+mY
         ni5KaAhohoeBCsJtfd6ldxVNfg9im9mNK9+B88A95VgPPp4NupMoQ4oVVL5gef2+Kl
         eV/3sQ1uQdH+8uoIYqY05sSrG8Hn7BAY9r5DYpqo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815080146.4tkudfzus7uryoe6@flea>
References: <20190815041037.3470-1-sboyd@kernel.org> <20190815080146.4tkudfzus7uryoe6@flea>
Subject: Re: [PATCH] clk: sunxi: Don't call clk_hw_get_name() on a hw that isn't registered
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
User-Agent: alot/0.8.1
Date:   Thu, 15 Aug 2019 08:18:46 -0700
Message-Id: <20190815151846.DA999206C1@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2019-08-15 01:01:46)
> On Wed, Aug 14, 2019 at 09:10:37PM -0700, Stephen Boyd wrote:
> > The implementation of clk_hw_get_name() relies on the clk_core
> > associated with the clk_hw pointer existing. If of_clk_hw_register()
> > fails, there isn't a clk_core created yet, so calling clk_hw_get_name()
> > here fails. Extract the name first so we can print it later.
> >
> > Fixes: 1d80c14248d6 ("clk: sunxi-ng: Add common infrastructure")
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Do you want to apply it yourself, or should I merge this and send you
> a PR later?
>=20

I can apply it myself. Thanks! Now to figure out the real problem...
