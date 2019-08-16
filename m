Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A239042D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfHPOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 10:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPOu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:50:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82726206C1;
        Fri, 16 Aug 2019 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565967056;
        bh=5bjMuPNKlGhcpAlzNw9BbBUAmfscWvJrM/Ab4JVnF/I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P13FrS9B+WOoVno+4GbcAPulL6EukbeVd816XDzOuycGgZnycNBf1x4SDcWUA+s24
         VyiuQo1CKkM8Ege4hJPlwBDJSv7LMzH2ogHsduzAsiy0NvPqTPPmB51hMj2pgaInN1
         Vs59tFL0fgkG99thDSJiaeRp7kP5MYEJg759rZ5A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816112210.GA27094@mani>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-2-sboyd@kernel.org> <20190816112210.GA27094@mani>
Subject: Re: [PATCH 1/9] clk: actions: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 07:50:55 -0700
Message-Id: <20190816145056.82726206C1@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-08-16 04:22:10)
> On Wed, Jul 31, 2019 at 12:35:09PM -0700, Stephen Boyd wrote:
> > A future patch is going to change semantics of clk_register() so that
> > clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> > referencing this member here so that we don't run into NULL pointer
> > exceptions.
> >=20
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >=20
> > Please ack so I can take this through clk tree
> >=20
> >  drivers/clk/actions/owl-common.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl=
-common.c
> > index 32dd29e0a37e..71b683c4e643 100644
> > --- a/drivers/clk/actions/owl-common.c
> > +++ b/drivers/clk/actions/owl-common.c
> > @@ -68,6 +68,7 @@ int owl_clk_probe(struct device *dev, struct clk_hw_o=
necell_data *hw_clks)
> >       struct clk_hw *hw;
> > =20
> >       for (i =3D 0; i < hw_clks->num; i++) {
> > +             const char *name =3D hw->init->name;
> > =20
>=20
> This should come after below statement and hence the warning is generated
> in linux-next. Sorry for missing!
>=20

Oh right. Will fix it.

