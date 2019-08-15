Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF17E8F2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfHOSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 14:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbfHOSCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:02:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C962083B;
        Thu, 15 Aug 2019 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565892137;
        bh=BbtRPnMkM9TNtxVrVxsMohoElU+idLbQFe4saSIy6Ik=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ax4rW/7WCUnTx5GNowUJ0KaB+J6qyHReQ7Jn1AOE8qCzD74+Pq30930f343q4K7IA
         7hAVkHU/2jaM+U+sD3FJZCz5FvmWGKs24jnXnjZiK0NuBSvAksZjVJbdntsxW1bWDR
         X7/DjE55PUjqaLukWb+mfqaeEDSMBdyAENIBq+Y8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815112614.GA4841@sirena.co.uk>
References: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com> <20190815040221.DE28F2067D@mail.kernel.org> <20190815112614.GA4841@sirena.co.uk>
Subject: Re: clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libretech-all-h3-cc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        enric.balletbo@collabora.com, guillaume.tucker@collabora.com,
        khilman@baylibre.com, matthew.hart@linaro.org,
        mgalka@collabora.com, tomeu.vizoso@collabora.com,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 15 Aug 2019 11:02:16 -0700
Message-Id: <20190815180216.D6C962083B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2019-08-15 04:26:14)
> On Wed, Aug 14, 2019 at 09:02:20PM -0700, Stephen Boyd wrote:
> > Quoting kernelci.org bot (2019-08-14 20:35:25)
>=20
> > > clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-li=
bretech-all-h3-cc
>=20
> > If this is the only board that failed, great! Must be something in a
> > sun8i driver that uses the init structure after registration.
>=20
> The infrastructure suppresses duplicate-seeming bisections so I'd not
> count on it, check the reports on the web site.

And there's something wrong with the OMAP4 panda board and tegra nyan.
Maybe Tony has seen it.

