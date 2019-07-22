Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7678570C10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbfGVVxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbfGVVxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:53:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4F121951;
        Mon, 22 Jul 2019 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563832394;
        bh=N/aG7525RXZijdwbJGyunKRAEhR9IYfXPRMh+ImE0p0=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=0YGM3auUNRWmWMAPu/v1w+jKC4qRGTLk5dziMHVPpoADcDlUxpDe/c2XaUgo82zCS
         erm45DJexo99LqTONLo/8jZbPJtGKhtEDUCCabdGxcf0EV0XV+Ow4DBTEgRCUyeVLr
         paPF8H1gVDBzIAzrUqcPSNq6aAuqYEV1iVkn+A7I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d1cd2b10-8fd4-f224-3bcd-5b938f72d249@wanadoo.fr>
References: <20190701165020.19840-1-colin.king@canonical.com> <20190722212414.6EF8D21900@mail.kernel.org> <d1cd2b10-8fd4-f224-3bcd-5b938f72d249@wanadoo.fr>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to n_den
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin King <colin.king@canonical.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:53:13 -0700
Message-Id: <20190722215314.9F4F121951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2019-07-22 14:43:32)
> Le 22/07/2019 =C3=A0 23:24, Stephen Boyd a =C3=A9crit=C2=A0:
> > Please Cc authors of drivers so they can ack/review.
> >
> > Adding Mike to take a look.
> >
> > Quoting Colin King (2019-07-01 09:50:20)
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The variable n_den is initialized however that value is never read
> >> as n_den is re-assigned a little later in the two paths of a
> >> following if-statement.  Remove the redundant assignment.
> >>
> >> Addresses-Coverity: ("Unused value")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>   drivers/clk/clk-si5341.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> >> index 72424eb7e5f8..6e780c2a9e6b 100644
> >> --- a/drivers/clk/clk-si5341.c
> >> +++ b/drivers/clk/clk-si5341.c
> >> @@ -547,7 +547,6 @@ static int si5341_synth_clk_set_rate(struct clk_hw=
 *hw, unsigned long rate,
> >>          bool is_integer;
> >>  =20
> >>          n_num =3D synth->data->freq_vco;
> >> -       n_den =3D rate;
> >>  =20
> >>          /* see if there's an integer solution */
> >>          r =3D do_div(n_num, rate);
> >
> Hi,
>=20
> I got the same advise from some else no later than yesterday (i.e. email =

> the author...)
> Maybe 'get_maintainer.pl' could be improved to search for it and propose =

> the mail automatically?
>=20
> just my 2c.
>=20

Use --git option of get_maintainer.pl?

