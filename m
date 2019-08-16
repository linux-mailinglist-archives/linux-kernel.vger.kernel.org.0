Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB689068D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfHPROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfHPROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:14:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8F720665;
        Fri, 16 Aug 2019 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565975681;
        bh=ot/VoK7SzXGUiep2Vy6bFaPwYqrXiyT6n/eRu/dYOgM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cKYYyS7qWaTtI2NLZacAPbwJwrDpfsBzi6adtIrrUu8Qap7pI05FsVr5nuQ21Z4gQ
         rYBs/yfKzxEUdqCBIjkjuC55LHnT5fdjgTiUQFLkV3QKK+KXR9z+Hb9OvESAjaPD4R
         lLxqc+wPGIOicaRA9Gj/cpcFKlFY3ka4BnLtGbS0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816155806.22869-3-joel@jms.id.au>
References: <20190816155806.22869-1-joel@jms.id.au> <20190816155806.22869-3-joel@jms.id.au>
Subject: Re: [PATCH 2/2] clk: Add support for AST2600 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:14:40 -0700
Message-Id: <20190816171441.3B8F720665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-08-16 08:58:06)
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> new file mode 100644
> index 000000000000..083d5299238c
> --- /dev/null
> +++ b/drivers/clk/clk-ast2600.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright IBM Corp
> +// Copyright ASPEED Technology
> +
[...]
> +#define ASPEED_DPLL_PARAM              0x260
> +
> +#define ASPEED_G6_STRAP1               0x500
> +
> +/* Globally visible clocks */
> +static DEFINE_SPINLOCK(aspeed_clk_lock);

I guess we can be guaranteed that the two drivers aren't compiled into
the same image? Otherwise this will alias with clk-aspeed.c and make
kallsyms annoying to use.

> +
> +/* Keeps track of all clocks */
> +static struct clk_hw_onecell_data *aspeed_g6_clk_data;
> +
> +static void __iomem *scu_g6_base;
> +
> +static const struct aspeed_gate_data aspeed_g6_gates[] =3D {
> +       /*                                  clk rst  name               p=
arent   flags */
> +       [ASPEED_CLK_GATE_MCLK]          =3D {  0, -1, "mclk-gate",       =
 "mpll",  CLK_IS_CRITICAL }, /* SDRAM */

Please document CLK_IS_CRITICAL usage. I guess it's memory so never turn
it off?

> +       [ASPEED_CLK_GATE_ECLK]          =3D {  1, -1, "eclk-gate",       =
 "eclk",  0 },   /* Video Engine */
> +       [ASPEED_CLK_GATE_GCLK]          =3D {  2,  7, "gclk-gate",       =
 NULL,    0 },   /* 2D engine */
> +       /* vclk parent - dclk/d1clk/hclk/mclk */
> +       [ASPEED_CLK_GATE_VCLK]          =3D {  3,  6, "vclk-gate",       =
 NULL,    0 },   /* Video Capture */
> +       [ASPEED_CLK_GATE_BCLK]          =3D {  4,  8, "bclk-gate",       =
 "bclk",  CLK_IS_CRITICAL }, /* PCIe/PCI */
> +       /* From dpll */
> +       [ASPEED_CLK_GATE_DCLK]          =3D {  5, -1, "dclk-gate",       =
 NULL,    CLK_IS_CRITICAL }, /* DAC */
> +       [ASPEED_CLK_GATE_REF0CLK]       =3D {  6, -1, "ref0clk-gate",    =
 "clkin", CLK_IS_CRITICAL },
> +       [ASPEED_CLK_GATE_USBPORT2CLK]   =3D {  7,  3, "usb-port2-gate",  =
 NULL,    0 },   /* USB2.0 Host port 2 */
> +       /* Reserved 8 */
> +       [ASPEED_CLK_GATE_USBUHCICLK]    =3D {  9, 15, "usb-uhci-gate",   =
 NULL,    0 },   /* USB1.1 (requires port 2 enabled) */
> +       /* From dpll/epll/40mhz usb p1 phy/gpioc6/dp phy pll */
> +       [ASPEED_CLK_GATE_D1CLK]         =3D { 10, 13, "d1clk-gate",      =
 "d1clk", 0 },   /* GFX CRT */
> +       /* Reserved 11/12 */
> +       [ASPEED_CLK_GATE_YCLK]          =3D { 13,  4, "yclk-gate",       =
 NULL,    0 },   /* HAC */
> +       [ASPEED_CLK_GATE_USBPORT1CLK]   =3D { 14, 14, "usb-port1-gate",  =
 NULL,    0 },   /* USB2 hub/USB2 host port 1/USB1.1 dev */
> +       [ASPEED_CLK_GATE_UART5CLK]      =3D { 15, -1, "uart5clk-gate",   =
 "uart",  0 },   /* UART5 */
> +       /* Reserved 16/19 */
> +       [ASPEED_CLK_GATE_MAC1CLK]       =3D { 20, 11, "mac1clk-gate",    =
 "mac12", 0 },   /* MAC1 */
> +       [ASPEED_CLK_GATE_MAC2CLK]       =3D { 21, 12, "mac2clk-gate",    =
 "mac12", 0 },   /* MAC2 */
> +       /* Reserved 22/23 */
> +       [ASPEED_CLK_GATE_RSACLK]        =3D { 24,  4, "rsaclk-gate",     =
 NULL,    0 },   /* HAC */
> +       [ASPEED_CLK_GATE_RVASCLK]       =3D { 25,  9, "rvasclk-gate",    =
 NULL,    0 },   /* RVAS */
> +       /* Reserved 26 */
> +       [ASPEED_CLK_GATE_EMMCCLK]       =3D { 27, 16, "emmcclk-gate",    =
 NULL,    0 },   /* For card clk */
> +       /* Reserved 28/29/30 */
> +       [ASPEED_CLK_GATE_LCLK]          =3D { 32, 32, "lclk-gate",       =
 NULL,    CLK_IS_CRITICAL }, /* LPC */
> +       [ASPEED_CLK_GATE_ESPICLK]       =3D { 33, -1, "espiclk-gate",    =
 NULL,    CLK_IS_CRITICAL }, /* eSPI */
> +       [ASPEED_CLK_GATE_REF1CLK]       =3D { 34, -1, "ref1clk-gate",    =
 "clkin", CLK_IS_CRITICAL },
> +       /* Reserved 35 */
> +       [ASPEED_CLK_GATE_SDCLK]         =3D { 36, 56, "sdclk-gate",      =
 NULL,    0 },   /* SDIO/SD */
> +       [ASPEED_CLK_GATE_LHCCLK]        =3D { 37, -1, "lhclk-gate",      =
 "lhclk", 0 },   /* LPC master/LPC+ */
> +       /* Reserved 38 RSA: no longer used */
> +       /* Reserved 39 */
> +       [ASPEED_CLK_GATE_I3C0CLK]       =3D { 40,  40, "i3c0clk-gate",   =
 NULL,    0 },   /* I3C0 */
> +       [ASPEED_CLK_GATE_I3C1CLK]       =3D { 41,  41, "i3c1clk-gate",   =
 NULL,    0 },   /* I3C1 */
> +       [ASPEED_CLK_GATE_I3C2CLK]       =3D { 42,  42, "i3c2clk-gate",   =
 NULL,    0 },   /* I3C2 */
> +       [ASPEED_CLK_GATE_I3C3CLK]       =3D { 43,  43, "i3c3clk-gate",   =
 NULL,    0 },   /* I3C3 */
> +       [ASPEED_CLK_GATE_I3C4CLK]       =3D { 44,  44, "i3c4clk-gate",   =
 NULL,    0 },   /* I3C4 */
> +       [ASPEED_CLK_GATE_I3C5CLK]       =3D { 45,  45, "i3c5clk-gate",   =
 NULL,    0 },   /* I3C5 */
> +       [ASPEED_CLK_GATE_I3C6CLK]       =3D { 46,  46, "i3c6clk-gate",   =
 NULL,    0 },   /* I3C6 */
> +       [ASPEED_CLK_GATE_I3C7CLK]       =3D { 47,  47, "i3c7clk-gate",   =
 NULL,    0 },   /* I3C7 */
> +       [ASPEED_CLK_GATE_UART1CLK]      =3D { 48,  -1, "uart1clk-gate",  =
 "uart",  0 },   /* UART1 */
> +       [ASPEED_CLK_GATE_UART2CLK]      =3D { 49,  -1, "uart2clk-gate",  =
 "uart",  0 },   /* UART2 */
> +       [ASPEED_CLK_GATE_UART3CLK]      =3D { 50,  -1, "uart3clk-gate",  =
 "uart",  0 },   /* UART3 */
> +       [ASPEED_CLK_GATE_UART4CLK]      =3D { 51,  -1, "uart4clk-gate",  =
 "uart",  0 },   /* UART4 */
> +       [ASPEED_CLK_GATE_MAC3CLK]       =3D { 52,  52, "mac3clk-gate",   =
 "mac34", 0 },   /* MAC3 */
> +       [ASPEED_CLK_GATE_MAC4CLK]       =3D { 53,  53, "mac4clk-gate",   =
 "mac34", 0 },   /* MAC4 */
> +       [ASPEED_CLK_GATE_UART6CLK]      =3D { 54,  -1, "uart6clk-gate",  =
 "uartx", 0 },   /* UART6 */
> +       [ASPEED_CLK_GATE_UART7CLK]      =3D { 55,  -1, "uart7clk-gate",  =
 "uartx", 0 },   /* UART7 */
> +       [ASPEED_CLK_GATE_UART8CLK]      =3D { 56,  -1, "uart8clk-gate",  =
 "uartx", 0 },   /* UART8 */
> +       [ASPEED_CLK_GATE_UART9CLK]      =3D { 57,  -1, "uart9clk-gate",  =
 "uartx", 0 },   /* UART9 */
> +       [ASPEED_CLK_GATE_UART10CLK]     =3D { 58,  -1, "uart10clk-gate", =
 "uartx", 0 },   /* UART10 */
> +       [ASPEED_CLK_GATE_UART11CLK]     =3D { 59,  -1, "uart11clk-gate", =
 "uartx", 0 },   /* UART11 */
> +       [ASPEED_CLK_GATE_UART12CLK]     =3D { 60,  -1, "uart12clk-gate", =
 "uartx", 0 },   /* UART12 */
> +       [ASPEED_CLK_GATE_UART13CLK]     =3D { 61,  -1, "uart13clk-gate", =
 "uartx", 0 },   /* UART13 */
> +       [ASPEED_CLK_GATE_FSICLK]        =3D { 62,  59, "fsiclk-gate",    =
 NULL,    0 },   /* FSI */
> +};
> +
> +static const char * const eclk_parent_names[] =3D { "mpll", "hpll", "dpl=
l" };
> +
> +static const struct clk_div_table ast2600_eclk_div_table[] =3D {
> +       { 0x0, 2 },
> +       { 0x1, 2 },
> +       { 0x2, 3 },
> +       { 0x3, 4 },
> +       { 0x4, 5 },
> +       { 0x5, 6 },
> +       { 0x6, 7 },
> +       { 0x7, 8 },
> +       { 0 }
> +};
> +
> +static const struct clk_div_table ast2600_mac_div_table[] =3D {
> +       { 0x0, 4 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 16 },
> +       { 0 }
> +};
> +
> +static const struct clk_div_table ast2600_div_table[] =3D {
> +       { 0x0, 4 },
> +       { 0x1, 8 },
> +       { 0x2, 12 },
> +       { 0x3, 16 },
> +       { 0x4, 20 },
> +       { 0x5, 24 },
> +       { 0x6, 28 },
> +       { 0x7, 32 },
> +       { 0 }
> +};
> +
> +/* For hpll/dpll/epll/mpll */
> +static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
> +{
> +       unsigned int mult, div;
> +
> +       if (val & BIT(24)) {
> +               /* Pass through mode */
> +               mult =3D div =3D 1;
> +       } else {
> +               /* F =3D 25Mhz * [(M + 2) / (n + 1)] / (p + 1) */
> +               u32 m =3D val  & 0x1fff;
> +               u32 n =3D (val >> 13) & 0x3f;
> +               u32 p =3D (val >> 19) & 0xf;
> +               mult =3D (m + 1) / (n + 1);
> +               div =3D (p + 1);
> +       }
> +       return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> +                       mult, div);
> +};
> +
> +static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
> +{
> +       unsigned int mult, div;
> +
> +       if (val & BIT(20)) {
> +               /* Pass through mode */
> +               mult =3D div =3D 1;
> +       } else {
> +               /* F =3D 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
> +               u32 m =3D (val >> 5) & 0x3f;
> +               u32 od =3D (val >> 4) & 0x1;
> +               u32 n =3D val & 0xf;
> +
> +               mult =3D (2 - od) * (m + 2);
> +               div =3D n + 1;
> +       }
> +       return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> +                       mult, div);
> +};
> +
> +static u32 get_bit(u8 idx)
> +{
> +       if (idx < 32)
> +               return BIT(idx);
> +       else
> +               return BIT(idx - 32);

Please remove else and deindent last return.

> +}
> +
> +static u32 get_reset_reg(struct aspeed_clk_gate *gate)
> +{
> +       if (gate->reset_idx < 32)
> +               return ASPEED_G6_RESET_CTRL;
> +       else
> +               return ASPEED_G6_RESET_CTRL2;

Same comment.

> +}
> +
> +static u32 get_clock_reg(struct aspeed_clk_gate *gate)
> +{
> +       if (gate->clock_idx < 32)
> +               return ASPEED_G6_CLK_STOP_CTRL;
> +       else
> +               return ASPEED_G6_CLK_STOP_CTRL2;

Same comment.

> +}
> +
> +static int aspeed_g6_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct aspeed_clk_gate *gate =3D to_aspeed_clk_gate(hw);
> +       u32 clk =3D get_bit(gate->clock_idx);
> +       u32 rst =3D get_bit(gate->reset_idx);
> +       u32 reg;
> +       u32 enval;
> +
> +       /*
> +        * If the IP is in reset, treat the clock as not enabled,
> +        * this happens with some clocks such as the USB one when
> +        * coming from cold reset. Without this, aspeed_clk_enable()
> +        * will fail to lift the reset.
> +        */
> +       if (gate->reset_idx >=3D 0) {
> +               regmap_read(gate->map, get_reset_reg(gate), &reg);
> +
> +               if (reg & rst)
> +                       return 0;
> +       }
> +
> +       regmap_read(gate->map, get_clock_reg(gate), &reg);
> +
> +       enval =3D (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
> +
> +       return ((reg & clk) =3D=3D enval) ? 1 : 0;
> +}
> +
> +static int aspeed_g6_clk_enable(struct clk_hw *hw)
> +{
> +       struct aspeed_clk_gate *gate =3D to_aspeed_clk_gate(hw);
> +       unsigned long flags;
> +       u32 clk =3D get_bit(gate->clock_idx);
> +       u32 rst =3D get_bit(gate->reset_idx);
> +
> +       spin_lock_irqsave(gate->lock, flags);
> +
> +       if (aspeed_g6_clk_is_enabled(hw)) {
> +               spin_unlock_irqrestore(gate->lock, flags);
> +               return 0;
> +       }
> +
> +       if (gate->reset_idx >=3D 0) {
> +               /* Put IP in reset */
> +               regmap_write(gate->map, get_reset_reg(gate), rst);
> +               /* Delay 100us */
> +               udelay(100);
> +       }
> +
> +       /* Enable clock */
> +       if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> +               regmap_write(gate->map, get_clock_reg(gate), clk);
> +       else
> +               /* Use set to clear register */
> +               regmap_write(gate->map, get_clock_reg(gate) + 0x04, clk);

Nitpick: Add braces on this because the comment is making it two lines.

> +
> +       if (gate->reset_idx >=3D 0) {
> +               /* A delay of 10ms is specified by the ASPEED docs */
> +               mdelay(10);
> +               /* Take IP out of reset */
> +               regmap_write(gate->map, get_reset_reg(gate) + 0x4, rst);
> +       }
> +
> +       spin_unlock_irqrestore(gate->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void aspeed_g6_clk_disable(struct clk_hw *hw)
> +{
> +       struct aspeed_clk_gate *gate =3D to_aspeed_clk_gate(hw);
> +       unsigned long flags;
> +       u32 clk =3D get_bit(gate->clock_idx);
> +
> +       spin_lock_irqsave(gate->lock, flags);
> +
> +       if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> +               regmap_write(gate->map, get_clock_reg(gate), clk);
> +       else
> +               /* Use set to clear register */
> +               regmap_write(gate->map, get_clock_reg(gate) + 0x4, clk);

Same nitpick=20

> +
> +       spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static const struct clk_ops aspeed_g6_clk_gate_ops =3D {
> +       .enable =3D aspeed_g6_clk_enable,
> +       .disable =3D aspeed_g6_clk_disable,
> +       .is_enabled =3D aspeed_g6_clk_is_enabled,
> +};
> +
> +static int aspeed_g6_reset_deassert(struct reset_controller_dev *rcdev,
> +                                   unsigned long id)
> +{
> +       struct aspeed_reset *ar =3D to_aspeed_reset(rcdev);
> +       u32 rst =3D get_bit(id);
> +       u32 reg =3D id >=3D 32 ? ASPEED_G6_RESET_CTRL2 : ASPEED_G6_RESET_=
CTRL;
> +
> +       /* Use set to clear register */
> +       return regmap_write(ar->map, reg + 0x04, rst);
> +}
> +
> +static int aspeed_g6_reset_assert(struct reset_controller_dev *rcdev,
> +                                 unsigned long id)
> +{
> +       struct aspeed_reset *ar =3D to_aspeed_reset(rcdev);
> +       u32 rst =3D get_bit(id);
> +       u32 reg =3D id >=3D 32 ? ASPEED_G6_RESET_CTRL2 : ASPEED_G6_RESET_=
CTRL;
> +
> +       return regmap_write(ar->map, reg, rst);
> +}
> +
> +static int aspeed_g6_reset_status(struct reset_controller_dev *rcdev,
> +                                 unsigned long id)
> +{
> +       struct aspeed_reset *ar =3D to_aspeed_reset(rcdev);
> +       int ret;
> +       u32 val;
> +       u32 rst =3D get_bit(id);
> +       u32 reg =3D id >=3D 32 ? ASPEED_G6_RESET_CTRL2 : ASPEED_G6_RESET_=
CTRL;
> +
> +       ret =3D regmap_read(ar->map, reg, &val);
> +       if (ret)
> +               return ret;
> +
> +       return !!(val & rst);
> +}
> +
> +static const struct reset_control_ops aspeed_g6_reset_ops =3D {
> +       .assert =3D aspeed_g6_reset_assert,
> +       .deassert =3D aspeed_g6_reset_deassert,
> +       .status =3D aspeed_g6_reset_status,
> +};
> +
> +static struct clk_hw *aspeed_g6_clk_hw_register_gate(struct device *dev,
> +               const char *name, const char *parent_name, unsigned long =
flags,
> +               struct regmap *map, u8 clock_idx, u8 reset_idx,
> +               u8 clk_gate_flags, spinlock_t *lock)
> +{
> +       struct aspeed_clk_gate *gate;
> +       struct clk_init_data init;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &aspeed_g6_clk_gate_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D parent_name ? &parent_name : NULL;
> +       init.num_parents =3D parent_name ? 1 : 0;
> +
> +       gate->map =3D map;
> +       gate->clock_idx =3D clock_idx;
> +       gate->reset_idx =3D reset_idx;
> +       gate->flags =3D clk_gate_flags;
> +       gate->lock =3D lock;
> +       gate->hw.init =3D &init;
> +
> +       hw =3D &gate->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(gate);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static const char * const vclk_parent_names[] =3D {

Can you use the new way of specifying clk parents instead of just using
strings?

> +       "dpll",
> +       "d1pll",
> +       "hclk",
> +       "mclk",
> +};
> +
> +static const char * const d1clk_parent_names[] =3D {
> +       "dpll",
> +       "epll",
> +       "usb-phy-40m",
> +       "gpioc6_clkin",
> +       "dp_phy_pll",
> +};
> +
> +static int aspeed_g6_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct aspeed_reset *ar;
> +       struct regmap *map;
> +       struct clk_hw *hw;
> +       u32 val, rate;
> +       int i, ret;
> +
> +       map =3D syscon_node_to_regmap(dev->of_node);
> +       if (IS_ERR(map)) {
> +               dev_err(dev, "no syscon regmap\n");
> +               return PTR_ERR(map);
> +       }
> +
> +       ar =3D devm_kzalloc(dev, sizeof(*ar), GFP_KERNEL);
> +       if (!ar)
> +               return -ENOMEM;
> +
> +       ar->map =3D map;
> +
> +       ar->rcdev.owner =3D THIS_MODULE;
> +       ar->rcdev.nr_resets =3D 64;
> +       ar->rcdev.ops =3D &aspeed_g6_reset_ops;
> +       ar->rcdev.of_node =3D dev->of_node;
> +
> +       ret =3D devm_reset_controller_register(dev, &ar->rcdev);
> +       if (ret) {
> +               dev_err(dev, "could not register reset controller\n");
> +               return ret;
> +       }
> +
> +       /* UART clock div13 setting */
> +       regmap_read(map, ASPEED_G6_MISC_CTRL, &val);
> +       if (val & UART_DIV13_EN)
> +               rate =3D 24000000 / 13;
> +       else
> +               rate =3D 24000000;
> +       hw =3D clk_hw_register_fixed_rate(dev, "uart", NULL, 0, rate);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_UART] =3D hw;
> +
> +       /* UART6~13 clock div13 setting */
> +       regmap_read(map, 0x80, &val);
> +       if (val & BIT(31))
> +               rate =3D 24000000 / 13;
> +       else
> +               rate =3D 24000000;
> +       hw =3D clk_hw_register_fixed_rate(dev, "uartx", NULL, 0, rate);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_UARTX] =3D hw;
> +
> +       /* EMMC ext clock divider */
> +       hw =3D clk_hw_register_gate(dev, "emmc_extclk_gate", "hpll", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 15, 0,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       hw =3D clk_hw_register_divider_table(dev, "emmc_extclk", "emmc_ex=
tclk_gate", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 12, 3, 0,
> +                       ast2600_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] =3D hw;
> +
> +       /* SD/SDIO clock divider and gate */
> +       hw =3D clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION4, 31, 0,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       hw =3D clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk=
_gate",
> +                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3,=
 0,
> +                       ast2600_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] =3D hw;
> +
> +       /* MAC1/2 AHB bus clock divider */
> +       hw =3D clk_hw_register_divider_table(dev, "mac12", "hpll", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 16, 3, 0,
> +                       ast2600_mac_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_MAC12] =3D hw;
> +
> +       /* MAC3/4 AHB bus clock divider */
> +       hw =3D clk_hw_register_divider_table(dev, "mac34", "hpll", 0,
> +                       scu_g6_base + 0x310, 24, 3, 0,
> +                       ast2600_mac_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_MAC34] =3D hw;
> +
> +       /* LPC Host (LHCLK) clock divider */
> +       hw =3D clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
> +                       ast2600_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_LHCLK] =3D hw;
> +
> +       /* gfx d1clk : use dp clk */
> +       regmap_update_bits(map, ASPEED_G6_CLK_SELECTION1, GENMASK(10, 8),=
 BIT(10));
> +       /* SoC Display clock selection */
> +       hw =3D clk_hw_register_mux(dev, "d1clk", d1clk_parent_names,
> +                       ARRAY_SIZE(d1clk_parent_names), 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 8, 3, 0,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_D1CLK] =3D hw;
> +
> +       //d1 clk div 0x308[17:15] x [14:12] - 8,7,6,5,4,3,2,1
> +       regmap_write(map, 0x308, 0x12000); //3x3 =3D 9
> +
> +       /* P-Bus (BCLK) clock divider */
> +       hw =3D clk_hw_register_divider_table(dev, "bclk", "hpll", 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
> +                       ast2600_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_BCLK] =3D hw;
> +
> +       /* Video Capture clock selection */
> +       hw =3D clk_hw_register_mux(dev, "vclk", vclk_parent_names,
> +                       ARRAY_SIZE(vclk_parent_names), 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION2, 12, 3, 0,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_VCLK] =3D hw;
> +
> +       /* Video Engine clock divider */
> +       hw =3D clk_hw_register_divider_table(dev, "eclk", NULL, 0,
> +                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 28, 3, 0,
> +                       ast2600_eclk_div_table,
> +                       &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_ECLK] =3D hw;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(aspeed_g6_gates); i++) {
> +               const struct aspeed_gate_data *gd =3D &aspeed_g6_gates[i];
> +               u32 gate_flags;
> +
> +               /* Special case: the USB port 1 clock (bit 14) is always

/*
 * Please make multi-line comments like this
 */

> +                * working the opposite way from the other ones.
> +                */
> +               gate_flags =3D (gd->clock_idx =3D=3D 14) ? 0 : CLK_GATE_S=
ET_TO_DISABLE;
> +               hw =3D aspeed_g6_clk_hw_register_gate(dev,
> +                               gd->name,
> +                               gd->parent_name,
> +                               gd->flags,
> +                               map,
> +                               gd->clock_idx,
> +                               gd->reset_idx,
> +                               gate_flags,
> +                               &aspeed_clk_lock);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +               aspeed_g6_clk_data->hws[i] =3D hw;
> +       }
> +
> +       return 0;
> +};
> +
> +static const struct of_device_id aspeed_g6_clk_dt_ids[] =3D {
> +       { .compatible =3D "aspeed,ast2600-scu" },
> +       { }
> +};
> +
> +static struct platform_driver aspeed_g6_clk_driver =3D {
> +       .probe  =3D aspeed_g6_clk_probe,
> +       .driver =3D {
> +               .name =3D "ast2600-clk",
> +               .of_match_table =3D aspeed_g6_clk_dt_ids,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(aspeed_g6_clk_driver);
> +
> +static u32 ast2600_a0_axi_ahb_div_table[] =3D {
> +       2, 2, 3, 5,
> +};
> +
> +static u32 ast2600_a1_axi_ahb_div_table[] =3D {
> +       4, 6, 2, 4,
> +};
> +
> +static void __init aspeed_g6_cc(struct regmap *map)
> +{
> +       struct clk_hw *hw;
> +       u32 val, div, chip_id, axi_div, ahb_div;
> +
> +       clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, 25000000);

Shouldn't this come from DT?

> +
> +       /*
> +        * High-speed PLL clock derived from the crystal. This the CPU cl=
ock,
> +        * and we assume that it is enabled
> +        */
> +       regmap_read(map, ASPEED_HPLL_PARAM, &val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_HPLL] =3D ast2600_calc_pll("hp=
ll", val);
> +
> +       regmap_read(map, ASPEED_MPLL_PARAM, &val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_MPLL] =3D ast2600_calc_pll("mp=
ll", val);
> +
> +       regmap_read(map, ASPEED_DPLL_PARAM, &val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_DPLL] =3D ast2600_calc_pll("dp=
ll", val);
> +
> +       regmap_read(map, ASPEED_EPLL_PARAM, &val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_EPLL] =3D ast2600_calc_pll("ep=
ll", val);
> +
> +       regmap_read(map, ASPEED_APLL_PARAM, &val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_APLL] =3D ast2600_calc_apll("a=
pll", val);
> +
> +       /* Strap bits 12:11 define the AXI/AHB clock frequency ratio (aka=
 HCLK)*/
> +       regmap_read(map, ASPEED_G6_STRAP1, &val);
> +       if (val & BIT(16))
> +               axi_div =3D 1;
> +       else
> +               axi_div =3D 2;
> +
> +       regmap_read(map, ASPEED_G6_SILICON_REV, &chip_id);
> +       if (chip_id & BIT(16))
> +               ahb_div =3D ast2600_a1_axi_ahb_div_table[(val >> 11) & 0x=
3];
> +       else
> +               ahb_div =3D ast2600_a0_axi_ahb_div_table[(val >> 11) & 0x=
3];
> +
> +       hw =3D clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, ax=
i_div * ahb_div);

There aren't checks for if these things fail. I guess it doesn't matter
and just let it fail hard?

> +       aspeed_g6_clk_data->hws[ASPEED_CLK_AHB] =3D hw;
> +
> +       regmap_read(map, ASPEED_G6_CLK_SELECTION1, &val);
> +       val =3D (val >> 23) & 0x7;
> +       div =3D 4 * (val + 1);
> +       hw =3D clk_hw_register_fixed_factor(NULL, "apb1", "hpll", 0, 1, d=
iv);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_APB1] =3D hw;
> +
> +       regmap_read(map, ASPEED_G6_CLK_SELECTION4, &val);
> +       val =3D (val >> 9) & 0x7;
> +       div =3D 2 * (val + 1);
> +       hw =3D clk_hw_register_fixed_factor(NULL, "apb2", "ahb", 0, 1, di=
v);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_APB2] =3D hw;
> +
> +       /* USB 2.0 port1 phy 40MHz clock */
> +       hw =3D clk_hw_register_fixed_rate(NULL, "usb-phy-40m", NULL, 0, 4=
0000000);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_USBPHY_40M] =3D hw;
> +};
> +
> +static void __init aspeed_g6_cc_init(struct device_node *np)
> +{
> +       struct regmap *map;
> +       int ret;
> +       int i;
> +
> +       scu_g6_base =3D of_iomap(np, 0);
> +       if (!scu_g6_base)
> +               return;
> +
> +       aspeed_g6_clk_data =3D kzalloc(struct_size(aspeed_g6_clk_data, hw=
s,
> +                                     ASPEED_G6_NUM_CLKS), GFP_KERNEL);
> +       if (!aspeed_g6_clk_data)
> +               return;
> +
> +       /*
> +        * This way all clocks fetched before the platform device probes,
> +        * except those we assign here for early use, will be deferred.
> +        */
> +       for (i =3D 0; i < ASPEED_G6_NUM_CLKS; i++)
> +               aspeed_g6_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> +
> +       /*
> +        * We check that the regmap works on this very first access,
> +        * but as this is an MMIO-backed regmap, subsequent regmap
> +        * access is not going to fail and we skip error checks from
> +        * this point.
> +        */
> +       map =3D syscon_node_to_regmap(np);
> +       if (IS_ERR(map)) {
> +               pr_err("no syscon regmap\n");
> +               return;
> +       }
> +
> +       aspeed_g6_cc(map);
> +       aspeed_g6_clk_data->num =3D ASPEED_G6_NUM_CLKS;
> +       ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, aspeed_=
g6_clk_data);
> +       if (ret)
> +               pr_err("failed to add DT provider: %d\n", ret);
> +};
> +CLK_OF_DECLARE_DRIVER(aspeed_cc_g6, "aspeed,ast2600-scu", aspeed_g6_cc_i=
nit);
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindi=
ngs/clock/ast2600-clock.h
> new file mode 100644
> index 000000000000..66567bd48d5b
> --- /dev/null
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

Is the parenthesis required? I don't think it is.

> +#ifndef DT_BINDINGS_AST2600_CLOCK_H
> +#define DT_BINDINGS_AST2600_CLOCK_H
> +
> +#define ASPEED_CLK_GATE_ECLK           0
> +#define ASPEED_CLK_GATE_GCLK           1
> +
> +#define ASPEED_CLK_GATE_MCLK           2
> +
> +#define ASPEED_CLK_GATE_VCLK           3
> +#define ASPEED_CLK_GATE_BCLK           4
