Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9953E7DFD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfHAQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbfHAQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:13:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0A9206A3;
        Thu,  1 Aug 2019 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564676001;
        bh=3I7L+wpEzIsxZD6Kyy6kCTKsUQJ4euk1NDIJbKWiRoY=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=1nhxxbnLcnskcAVqC4YIxl9Zlzm6HYIppo9xEMeDqlctUgUQ4+9bQPVJWe0aGrIZT
         5Ylgsbj1nORQmJlhGbmFOpKwxDedMZw33bkCyyYdptmEaUwwcDvHQ7UJMb090ts9jE
         prtJYH6/ipangD4uylz1ASsLyoMr7DDOx6Uze7/o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <74912a84-fb5a-a539-5ab4-c3f00727c413@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-7-sboyd@kernel.org> <74912a84-fb5a-a539-5ab4-c3f00727c413@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 6/9] clk: socfpga: Don't reference clk_init_data after registration
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 09:13:20 -0700
Message-Id: <20190801161321.4D0A9206A3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-08-01 08:12:58)
> Hi Stephen,
>=20
> On 7/31/19 2:35 PM, Stephen Boyd wrote:
> > A future patch is going to change semantics of clk_register() so that
> > clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> > referencing this member here so that we don't run into NULL pointer
> > exceptions.
> >=20
> > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >=20
> > Please ack so I can take this through clk tree
> >=20
> >  drivers/clk/socfpga/clk-gate.c       | 21 +++++++++++----------
> >  drivers/clk/socfpga/clk-periph-a10.c |  7 ++++---
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-g=
ate.c
> > index 3966cd43b552..b3c8143909dc 100644
> > --- a/drivers/clk/socfpga/clk-gate.c
> > +++ b/drivers/clk/socfpga/clk-gate.c
> > @@ -31,20 +31,20 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwc=
lk)
> >       u32 l4_src;
> >       u32 perpll_src;
>=20
> You need this line here:
>=20
>         const char *name =3D clk_hw_get_name(hwclk);
>=20
> Otherwise, it fails to build. With the above change:
>=20
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Awesome thanks!=20

