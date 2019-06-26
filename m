Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83E357048
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfFZSGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 14:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfFZSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:06:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC94208E3;
        Wed, 26 Jun 2019 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561572406;
        bh=2AI6vfXRA9shlQqJsOONaBOLJB2mY6s1tLqu+00O3F0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=Spp9kx2SEGbyBvjRg7Rp8spfvABoWi0hW76zUYOM3FD6kqNq++B2bm2kKQRidP1z0
         qbLDeSCNP/lRY/2juCiLRkpXT4YSb6yqvqCgP6zTHA4HD4gWppy9wOI3qThityAkRa
         01Dxm3PzcYD9reVtw4Q1xhoPmvwMf05PC91C/YSU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ceca0ca-8f8e-78a8-df39-67a763f28f30@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com> <20190620150013.13462-6-narmstrong@baylibre.com> <20190625202702.B9A9B208CB@mail.kernel.org> <2ceca0ca-8f8e-78a8-df39-67a763f28f30@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC/RFT 05/14] soc: amlogic: meson-clk-measure: protect measure with a mutex
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:06:45 -0700
Message-Id: <20190626180646.9CC94208E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-06-26 01:24:47)
> On 25/06/2019 22:27, Stephen Boyd wrote:
> > Quoting Neil Armstrong (2019-06-20 08:00:04)
> >> In order to protect clock measuring when multiple process asks for
> >> a mesure, protect the main measure function with mutexes.

s/mesure/measure/

> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/soc/amlogic/meson-clk-measure.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/aml=
ogic/meson-clk-measure.c
> >> index 19d4cbc93a17..c470e24f1dfa 100644
> >> --- a/drivers/soc/amlogic/meson-clk-measure.c
> >> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> >> @@ -11,6 +11,8 @@
> >>  #include <linux/debugfs.h>
> >>  #include <linux/regmap.h>
> >> =20
> >> +static DEFINE_MUTEX(measure_lock);
> >> +
> >>  #define MSR_CLK_DUTY           0x0
> >>  #define MSR_CLK_REG0           0x4
> >>  #define MSR_CLK_REG1           0x8
> >> @@ -360,6 +362,10 @@ static int meson_measure_id(struct meson_msr_id *=
clk_msr_id,
> >>         unsigned int val;
> >>         int ret;
> >> =20
> >> +       ret =3D mutex_lock_interruptible(&measure_lock);
> >=20
> > Why interruptible?
>=20
>=20
> I supposed _interruptible was needed since it's called from userspace via
> debugfs, locking indefinitely isn't wanted, no ? or maybe I missed someth=
ing...
>=20

Sounds plausible to me.

