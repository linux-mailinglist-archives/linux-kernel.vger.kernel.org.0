Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4002485991
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 07:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfHHFB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 01:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfHHFB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:01:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3DA52186A;
        Thu,  8 Aug 2019 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565240489;
        bh=AHNJVKPnI8TPzXlCehwNhKSlQ8JsSzT7dmoWdcLEXYI=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=unMwFYPEpX5n/FTzHQhYC3ZDi50tVE5xXE1YnBj+0CofrN5KgWqXJBPd96qDefB3m
         II6qNG81HqA8oTHXOOM14vCWS7nzLnaUrHVIwLFJ9DlHlOk5OK2o1h+n7v3DvUyBem
         /PARBCuOWRdDahKgrA08VasYJevhmfmGM+zQQ/Yk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org> <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add Bitmain BM1880 SoC clock controller binding
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 22:01:28 -0700
Message-Id: <20190808050128.E3DA52186A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-07-05 08:14:36)
> Add devicetree binding for Bitmain BM1880 SoC clock controller.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/bitmain,bm1880-clk.txt     | 47 +++++++++++

Can you convert this to YAML? It's all the rage right now.

>  include/dt-bindings/clock/bm1880-clock.h      | 82 +++++++++++++++++++
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm188=
0-clk.txt
>  create mode 100644 include/dt-bindings/clock/bm1880-clock.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.t=
xt b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
> new file mode 100644
> index 000000000000..9c967095d430
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
> @@ -0,0 +1,47 @@
> +* Bitmain BM1880 Clock Controller
> +
> +The Bitmain BM1880 clock controler generates and supplies clock to
> +various peripherals within the SoC.
> +
> +Required Properties:
> +
> +- compatible: Should be "bitmain,bm1880-clk"
> +- reg :        Register address and size of PLL and SYS control domains
> +- reg-names : Register domain names: "pll" and "sys"
> +- clocks : Phandle of the input reference clock.
> +- #clock-cells: Should be 1.
> +
> +Each clock is assigned an identifier, and client nodes can use this iden=
tifier
> +to specify the clock which they consume.
> +
> +All available clocks are defined as preprocessor macros in corresponding
> +dt-bindings/clock/bm1880-clock.h header and can be used in device tree s=
ources.
> +
> +External clocks:
> +
> +The osc clock used as the input for the plls is generated outside the So=
C.
> +It is expected that it is defined using standard clock bindings as "osc".
> +
> +Example:=20
> +
> +        clk: clock-controller@800 {
> +                compatible =3D "bitmain,bm1880-clk";
> +                reg =3D <0xe8 0x0c>,<0x800 0xb0>;

It looks weird still. What hardware module is this actually part of?
Some larger power manager block?

> +                reg-names =3D "pll", "sys";
> +                clocks =3D <&osc>;
> +                #clock-cells =3D <1>;
> +        };
> +
