Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6454F70B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfGVVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbfGVVb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:31:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8829E21900;
        Mon, 22 Jul 2019 21:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831116;
        bh=6+/sxagahL+li6jU6ojcB6SqYd6K9O6P+akg/i4q2+0=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=BfaltBBaR63zw809ajWmqfGQDl/yVbLLDWguStR5cYjWJ/GgzUzhXBEZgQklIYe5v
         fyrtKZIvR7r6glea1WEmEK1XwPkZnPsKrbq4rytKZgyDLKVhQTIYVDHistTPyuxI9U
         ycHtK1Mcc4LGRHW4fgBSqIZvVxVQHjs3kGuHabuM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <af07c26e-cef3-f0ff-48ff-68f99ccf4de9@microchip.com>
References: <20190625091002.27567-1-codrin.ciubotariu@microchip.com> <af07c26e-cef3-f0ff-48ff-68f99ccf4de9@microchip.com>
Subject: Re: [RESEND][PATCH] clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV + 1
To:     Codrin.Ciubotariu@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:31:55 -0700
Message-Id: <20190722213156.8829E21900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas.Ferre@microchip.com (2019-07-03 08:05:24)
> On 25/06/2019 at 11:10, Codrin Ciubotariu wrote:
> > In clk_generated_determine_rate(), if the divisor is greater than
> > GENERATED_MAX_DIV + 1, then the wrong best_rate will be returned.
> > If clk_generated_set_rate() will be called later with this wrong
> > rate, it will return -EINVAL, so the generated clock won't change
> > its value. Do no let the divisor be greater than GENERATED_MAX_DIV + 1.
> >=20
> > Fixes: 8c7aa6328947 ("clk: at91: clk-generated: remove useless divisor =
loop")
> > Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > ---
> >=20
> > - The email-server was converting my patches to base64, so I resend it
> >    using another server;
> > - Added acked-bys from Nicolas and Ludovic;
>=20
> Stephen,
>=20
> I don't see this patch in linux-next and we're already late in the=20
> development cycle: aka ping...
>=20

Sorry. I dropped this one. Will pick it up into fixes.


