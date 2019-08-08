Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F759858E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfHHEIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 00:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfHHEIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:08:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430582186A;
        Thu,  8 Aug 2019 04:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565237302;
        bh=SfXPd4T/iPy4yFm0+4ZpSrVXDIPE9kIwjlBq5hF2ehY=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=CfdXw7P8r0bazXOgVEoU4sj5id7e63Ixa7qQkRBbWZmUmyjLhQ4AIbq9puLL7q1wQ
         2Hca7iKaiSGh4SQBFdqoEyAO7bFlR0MXdDQ+Ll4rVR2SGGsIiZMTwvXv+kGZErZEMj
         pduBIcnT6XrIpAzYYiAeJNXS3kqucc6k3M5dAxi8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565220490.15188.0@crapouillou.net>
References: <20190701113606.4130-1-paul@crapouillou.net> <20190807213358.A62002186A@mail.kernel.org> <1565220490.15188.0@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/jz4740: Fix "pll half" divider not read/written properly
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 21:08:21 -0700
Message-Id: <20190808040822.430582186A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-08-07 16:28:10)
>=20
>=20
> Le mer. 7 ao=C3=BBt 2019 =C3=A0 23:33, Stephen Boyd <sboyd@kernel.org> a =
=C3=A9crit=20
> :
> > Quoting Paul Cercueil (2019-07-01 04:36:06)
> >>  The code was setting the bit 21 of the CPCCR register to use a=20
> >> divider
> >>  of 2 for the "pll half" clock, and clearing the bit to use a divider
> >>  of 1.
> >>=20
> >>  This is the opposite of how this register field works: a cleared bit
> >>  means that the /2 divider is used, and a set bit means that the=20
> >> divider
> >>  is 1.
> >>=20
> >>  Restore the correct behaviour using the newly introduced .div_table
> >>  field.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >=20
> > Applied to clk-next. Does this need a fixes tag?
>=20
> It depends on commit a9fa2893fcc6 ("clk: ingenic: Add support for
> divider tables") which was sent without a fixes tag, so it'd be
> a bit difficult. Probably not worth the trouble.
>=20

Does it need to go in as a fix for this -rc series then? Or is it not
causing issues for you so it's ok to wait until next merge window?


