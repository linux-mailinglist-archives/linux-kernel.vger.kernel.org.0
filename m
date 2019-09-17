Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7EB5712
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfIQUj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfIQUj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:39:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F75C2054F;
        Tue, 17 Sep 2019 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568752797;
        bh=t7XSIVvuIrJr+dTFLwJdB0q0iDWxPt3F88Tk1jyyAP8=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=g19ToDQBV751yjIEYkLnsdhOeu+FbOMz4i9GlEvIDjacEF61ADydYtjS3jv4EbPQK
         yuSedeuNiovoGkvFB2FoQ9Z/GOLlOG7GVDqXUq3zucvTxcc9MPx+72WE3CRQyXtexi
         61n3o6OxehKUpmjDJ/QK50ACQS/HKJ6xld5MF0QY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190916161447.32715-2-manivannan.sadhasivam@linaro.org>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org> <20190916161447.32715-2-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/8] clk: Zero init clk_init_data in helpers
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 13:39:56 -0700
Message-Id: <20190917203957.9F75C2054F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-09-16 09:14:40)
> The clk_init_data struct needs to be initialized to zero for the new
> parent_map implementation to work correctly. Otherwise, the member which
> is available first will get processed.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/clk-composite.c  | 2 +-
>  drivers/clk/clk-divider.c    | 2 +-
>  drivers/clk/clk-fixed-rate.c | 2 +-
>  drivers/clk/clk-gate.c       | 2 +-
>  drivers/clk/clk-mux.c        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index b06038b8f658..4d579f9d20f6 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -208,7 +208,7 @@ struct clk_hw *clk_hw_register_composite(struct devic=
e *dev, const char *name,
>                         unsigned long flags)
>  {
>         struct clk_hw *hw;
> -       struct clk_init_data init;
> +       struct clk_init_data init =3D { NULL };

I'd prefer { } because then we don't have to worry about ordering the
struct to have a pointer vs. something else first.

>         struct clk_composite *composite;
>         struct clk_ops *clk_composite_ops;
>         int ret;
