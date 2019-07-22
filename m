Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7155670B58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfGVV34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGVV3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:29:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8924D21900;
        Mon, 22 Jul 2019 21:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563830994;
        bh=uwW/oEQ+rIP16Of2YhnZmjQcbaZjB5O2kBkr+rxXs1U=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=vi+PFRFA1apzHXdVjo0FACtPiFs4OVaEL17wILxIWu1gRrdOwIjm8hBwZRC0KB4LC
         FL8NaVB/nJXJpgswnHzjueltqt4wsv0guwau4Ro1NDQ9KTA3+AtGQpx9EgA+OzgZ4X
         Kt0E/skGc+3ypSEy5Ub8MLMpHBWZFsVmWWWh7qOc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190708154730.16643-12-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-12-sudeep.holla@arm.com>
Subject: Re: [PATCH 11/11] firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:29:53 -0700
Message-Id: <20190722212954.8924D21900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2019-07-08 08:47:30)
> CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
> number of pending asynchronous clock rate changes supported by the
> platform. If it's non-zero, then we should be able to use asynchronous
> clock rate set for any clocks until the maximum limit is reached.
>=20
> Keeping the current count of pending asynchronous clock set rate
> requests, we can decide if we can you asynchronous request for the

This last part of the sentence doesn't read properly. Please rewrite.

> incoming/new request.
>=20
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scm=
i/clock.c
> index dd215bd11a58..70044b7c812e 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -221,21 +222,35 @@ static int scmi_clock_rate_set(const struct scmi_ha=
ndle *handle, u32 clk_id,
>                                u64 rate)
>  {
>         int ret;
> +       u32 flags =3D 0;
>         struct scmi_xfer *t;
>         struct scmi_clock_set_rate *cfg;
> +       struct clock_info *ci =3D handle->clk_priv;
> =20
>         ret =3D scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_=
CLOCK,
>                                  sizeof(*cfg), 0, &t);
>         if (ret)
>                 return ret;
> =20
> +       if (ci->max_async_req) {
> +               if (atomic_inc_return(&ci->cur_async_req) < ci->max_async=
_req)
> +                       flags |=3D CLOCK_SET_ASYNC;
> +               else
> +                       atomic_dec(&ci->cur_async_req);

Can this be combined with the atomic_dec() below and done after either
transfer?

> +       }
> +
>         cfg =3D t->tx.buf;
> -       cfg->flags =3D cpu_to_le32(0);
> +       cfg->flags =3D cpu_to_le32(flags);
>         cfg->id =3D cpu_to_le32(clk_id);
>         cfg->value_low =3D cpu_to_le32(rate & 0xffffffff);
>         cfg->value_high =3D cpu_to_le32(rate >> 32);
> =20
> -       ret =3D scmi_do_xfer(handle, t);
> +       if (flags & CLOCK_SET_ASYNC) {
> +               ret =3D scmi_do_xfer_with_response(handle, t);
> +               atomic_dec(&ci->cur_async_req);
> +       } else {
> +               ret =3D scmi_do_xfer(handle, t);
> +       }

I mean putting the atomic_dec() here.

> =20
>         scmi_xfer_put(handle, t);
>         return ret;
