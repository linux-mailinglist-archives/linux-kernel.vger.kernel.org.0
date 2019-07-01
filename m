Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6403EB92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfD2UXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 16:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2UXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:23:33 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60703215EA;
        Mon, 29 Apr 2019 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556569411;
        bh=Hs9mqgcY7lE0xSnarreUwz/n/JdsQYDY7G8ezo/Lh4w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ovVVQ1J/x4ait4A2Klw/YevZ9tc7N5uYDpyonmlLyc5FBPVt/PMZIuFi+KJS+G5qj
         u0jvJ1K4qClpDHJAI/G275cHHP+eotaAbp31euomOgfatvcy7SfKM2n9/TQrQJM7iI
         ie5ecufH2go40XyRNzVkpM+ASTY9GODmuVKZnPmA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411082733.3736-2-paul.walmsley@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155656941055.168659.18136739282359756367@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 13:23:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-11 01:27:32)
> diff --git a/drivers/clk/analogbits/Kconfig b/drivers/clk/analogbits/Kcon=
fig
> new file mode 100644
> index 000000000000..b5fd60c7f136
> --- /dev/null
> +++ b/drivers/clk/analogbits/Kconfig
> @@ -0,0 +1,2 @@

Add SPDX for this file?

> +config CLK_ANALOGBITS_WRPLL_CLN28HPC
> +       bool
> diff --git a/drivers/clk/analogbits/Makefile b/drivers/clk/analogbits/Mak=
efile
> new file mode 100644
> index 000000000000..bb51a3ae77a7
> --- /dev/null
> +++ b/drivers/clk/analogbits/Makefile
> @@ -0,0 +1 @@

Add SPDX for this file?

> +obj-$(CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC)    +=3D wrpll-cln28hpc.o
> diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analog=
bits/wrpll-cln28hpc.c
> new file mode 100644
> index 000000000000..2027872719e1
> --- /dev/null
> +++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018-2019 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + *
> + * This library supports configuration parsing and reprogramming of
> + * the CLN28HPC variant of the Analog Bits Wide Range PLL.  The
> + * intention is for this library to be reusable for any device that
> + * integrates this PLL; thus the register structure and programming
> + * details are expected to be provided by a separate IP block driver.
> + *
> + * The bulk of this code is primarily useful for clock configurations
> + * that must operate at arbitrary rates, as opposed to clock configurati=
ons
> + * that are restricted by software or manufacturer guidance to a small,
> + * pre-determined set of performance points.
> + *
> + * References:
> + * - Analog Bits "Wide Range PLL Datasheet", version 2015.10.01
> + * - SiFive FU540-C000 Manual v1p0, Chapter 7 "Clocking and Reset"
> + *   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/err.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/clk/analogbits-wrpll-cln28hpc.h>
> +
> +/* MIN_INPUT_FREQ: minimum input clock frequency, in Hz (Fref_min) */
> +#define MIN_INPUT_FREQ                 7000000
> +
> +/* MAX_INPUT_FREQ: maximum input clock frequency, in Hz (Fref_max) */
> +#define MAX_INPUT_FREQ                 600000000
> +
> +/* MIN_POST_DIVIDE_REF_FREQ: minimum post-divider reference frequency, i=
n Hz */
> +#define MIN_POST_DIVR_FREQ             7000000
> +
> +/* MAX_POST_DIVIDE_REF_FREQ: maximum post-divider reference frequency, i=
n Hz */
> +#define MAX_POST_DIVR_FREQ             200000000
> +
> +/* MIN_VCO_FREQ: minimum VCO frequency, in Hz (Fvco_min) */
> +#define MIN_VCO_FREQ                   2400000000UL
> +
> +/* MAX_VCO_FREQ: maximum VCO frequency, in Hz (Fvco_max) */
> +#define MAX_VCO_FREQ                   4800000000ULL
> +
> +/* MAX_DIVQ_DIVISOR: maximum output divisor.  Selected by DIVQ =3D 6 */
> +#define MAX_DIVQ_DIVISOR               64
> +
> +/* MAX_DIVR_DIVISOR: maximum reference divisor.  Selected by DIVR =3D 63=
 */
> +#define MAX_DIVR_DIVISOR               64
> +
> +/* MAX_LOCK_US: maximum PLL lock time, in microseconds (tLOCK_max) */
> +#define MAX_LOCK_US                    70
> +
> +/*
> + * ROUND_SHIFT: number of bits to shift to avoid precision loss in the r=
ounding
> + *              algorithm
> + */
> +#define ROUND_SHIFT                    20
> +
> +/*
> + * Private functions
> + */
> +
> +/**
> + * __wrpll_calc_filter_range() - determine PLL loop filter bandwidth
> + * @post_divr_freq: input clock rate after the R divider
> + *
> + * Select the value to be presented to the PLL RANGE input signals, based
> + * on the input clock frequency after the post-R-divider @post_divr_freq.
> + * This code follows the recommendations in the PLL datasheet for filter
> + * range selection.
> + *
> + * Return: The RANGE value to be presented to the PLL configuration inpu=
ts,
> + *         or -1 upon error.
> + */
> +static int __wrpll_calc_filter_range(unsigned long post_divr_freq)
> +{
> +       u8 range;
> +
> +       if (post_divr_freq < MIN_POST_DIVR_FREQ ||
> +           post_divr_freq > MAX_POST_DIVR_FREQ) {
> +               WARN(1, "%s: post-divider reference freq out of range: %l=
u",
> +                    __func__, post_divr_freq);
> +               return -1;
> +       }
> +
> +       if (post_divr_freq < 11000000)
> +               range =3D 1;
> +       else if (post_divr_freq < 18000000)
> +               range =3D 2;
> +       else if (post_divr_freq < 30000000)
> +               range =3D 3;
> +       else if (post_divr_freq < 50000000)
> +               range =3D 4;
> +       else if (post_divr_freq < 80000000)
> +               range =3D 5;
> +       else if (post_divr_freq < 130000000)
> +               range =3D 6;
> +       else
> +               range =3D 7;

Nitpick: This might be easier to read with a switch statement:

	switch (post_divr_freq) {
	case 0 ... 11000000:
		return 1;
	case 11000001 ... 18000000:
		return 2;
	case 18000001 ... 30000000:
		return 3;
	case 30000001 ... 50000000:
		return 4;
	case 50000000 ... 80000000:
		return 5;
	case 80000001 ... 130000000:
		return 6;
	}

	return 7;

> +
> +       return range;
> +}
> +
> +/**
> + * __wrpll_calc_fbdiv() - return feedback fixed divide value
> + * @c: ptr to a struct analogbits_wrpll_cfg record to read from
> + *
> + * The internal feedback path includes a fixed by-two divider; the
> + * external feedback path does not.  Return the appropriate divider
> + * value (2 or 1) depending on whether internal or external feedback
> + * is enabled.  This code doesn't test for invalid configurations
> + * (e.g. both or neither of WRPLL_FLAGS_*_FEEDBACK are set); it relies
> + * on the caller to do so.
> + *
> + * Context: Any context.  Caller must protect the memory pointed to by
> + *          @c from simultaneous modification.
> + *
> + * Return: 2 if internal feedback is enabled or 1 if external feedback
> + *         is enabled.
> + */
> +static u8 __wrpll_calc_fbdiv(struct analogbits_wrpll_cfg *c)

const c?

> +{
> +       return (c->flags & WRPLL_FLAGS_INT_FEEDBACK_MASK) ? 2 : 1;
> +}
> +
> +/**
> + * __wrpll_calc_divq() - determine DIVQ based on target PLL output clock=
 rate
> + * @target_rate: target PLL output clock rate
> + * @vco_rate: pointer to a u64 to store the computed VCO rate into
> + *
> + * Determine a reasonable value for the PLL Q post-divider, based on the
> + * target output rate @target_rate for the PLL.  Along with returning the
> + * computed Q divider value as the return value, this function stores the
> + * desired target VCO rate into the variable pointed to by @vco_rate.
> + *
> + * Context: Any context.  Caller must protect the memory pointed to by
> + *          @vco_rate from simultaneous access or modification.
> + *
> + * Return: a positive integer DIVQ value to be programmed into the hardw=
are
> + *         upon success, or 0 upon error (since 0 is an invalid DIVQ val=
ue)

Why are we doing that? Can't we return a normal error code and test for
it being negative and then consider the number if its greater than 0 to
be valid?

> + */
> +static u8 __wrpll_calc_divq(u32 target_rate, u64 *vco_rate)

Why does target_rate need to be u32? Can it be unsigned long?

> +{
> +       u64 s;
> +       u8 divq =3D 0;
> +
> +       if (!vco_rate) {
> +               WARN_ON(1);
> +               goto wcd_out;
> +       }
> +
> +       s =3D div_u64(MAX_VCO_FREQ, target_rate);
> +       if (s <=3D 1) {
> +               divq =3D 1;
> +               *vco_rate =3D MAX_VCO_FREQ;
> +       } else if (s > MAX_DIVQ_DIVISOR) {
> +               divq =3D ilog2(MAX_DIVQ_DIVISOR);
> +               *vco_rate =3D MIN_VCO_FREQ;
> +       } else {
> +               divq =3D ilog2(s);
> +               *vco_rate =3D target_rate << divq;
> +       }
> +
> +wcd_out:
> +       return divq;
> +}
> +
> +/**
> + * __wrpll_update_parent_rate() - update PLL data when parent rate chang=
es
> + * @c: ptr to a struct analogbits_wrpll_cfg record to write PLL data to
> + * @parent_rate: PLL input refclk rate (pre-R-divider)
> + *
> + * Pre-compute some data used by the PLL configuration algorithm when
> + * the PLL's reference clock rate changes.  The intention is to avoid
> + * computation when the parent rate remains constant - expected to be
> + * the common case.
> + *
> + * Returns: 0 upon success or -1 if the reference clock rate is out of r=
ange.
> + */
> +static int __wrpll_update_parent_rate(struct analogbits_wrpll_cfg *c,
> +                                     unsigned long parent_rate)
> +{
> +       u8 max_r_for_parent;

Why not just unsigned long or unsigned int?

> +
> +       if (parent_rate > MAX_INPUT_FREQ || parent_rate < MIN_POST_DIVR_F=
REQ)
> +               return -1;
> +
> +       c->parent_rate =3D parent_rate;
> +       max_r_for_parent =3D div_u64(parent_rate, MIN_POST_DIVR_FREQ);
> +       c->max_r =3D min_t(u8, MAX_DIVR_DIVISOR, max_r_for_parent);

Then this min_t can be min() which is simpler to reason about.

> +
> +       /* Round up */
> +       c->init_r =3D div_u64(parent_rate + MAX_POST_DIVR_FREQ - 1,
> +                           MAX_POST_DIVR_FREQ);

Don't we have DIV_ROUND_UP_ULL() for this?

> +
> +       return 0;
> +}
> +
> +/**
> + * analogbits_wrpll_configure() - compute PLL configuration for a target=
 rate
> + * @c: ptr to a struct analogbits_wrpll_cfg record to write into
> + * @target_rate: target PLL output clock rate (post-Q-divider)
> + * @parent_rate: PLL input refclk rate (pre-R-divider)
> + *
> + * Given a pointer to a PLL context @c, a desired PLL target output
> + * rate @target_rate, and a reference clock input rate @parent_rate,
> + * compute the appropriate PLL signal configuration values.  PLL

I don't know if we need to repeat the arguments and their description
again in kernel-doc's first sentence. Maybe just "Compute the
appropriate PLL signal configuration values and store in PLL context
@c. PLL reprogramming is not ..."

> + * reprogramming is not glitchless, so the caller should switch any
> + * downstream logic to a different clock source or clock-gate it
> + * before presenting these values to the PLL configuration signals.
> + *
> + * The caller must pass this function a pre-initialized struct
> + * analogbits_wrpll_cfg record: either initialized to zero (with the
> + * exception of the .name and .flags fields) or read from the PLL.
> + *
> + * Context: Any context.  Caller must protect the memory pointed to by @c
> + *          from simultaneous access or modification.
> + *
> + * Return: 0 upon success; anything else upon failure.
> + */
> +int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg *c,
> +                                       u32 target_rate,

Why does it need to be u32? Why not unsigned long?

> +                                       unsigned long parent_rate)
> +{
> +       unsigned long ratio;
> +       u64 target_vco_rate, delta, best_delta, f_pre_div, vco, vco_pre;
> +       u32 best_f, f, post_divr_freq;
> +       u8 fbdiv, divq, best_r, r;
> +
> +       if (c->flags =3D=3D 0) {
> +               WARN(1, "%s called with uninitialized PLL config", __func=
__);
> +               return -1;

Please return linux error codes instead of -1. -EINVAL?

> +       }
> +
> +       /* Initialize rounding data if it hasn't been initialized already=
 */
> +       if (parent_rate !=3D c->parent_rate) {
> +               if (__wrpll_update_parent_rate(c, parent_rate)) {
> +                       pr_err("%s: PLL input rate is out of range\n",
> +                              __func__);
> +                       return -1;
> +               }
> +       }
> +
> +       c->flags &=3D ~WRPLL_FLAGS_RESET_MASK;
> +
> +       /* Put the PLL into bypass if the user requests the parent clock =
rate */
> +       if (target_rate =3D=3D parent_rate) {
> +               c->flags |=3D WRPLL_FLAGS_BYPASS_MASK;
> +               return 0;
> +       }
> +       c->flags &=3D ~WRPLL_FLAGS_BYPASS_MASK;

Nitpick: Detach this from the above if so that we can more clearly see
the return 0 in the if statement.

> +
> +       /* Calculate the Q shift and target VCO rate */
> +       divq =3D __wrpll_calc_divq(target_rate, &target_vco_rate);
> +       if (divq =3D=3D 0)

It's more normal style to write this as if (!divq)

> +               return -1;
> +       c->divq =3D divq;
> +
> +       /* Precalculate the pre-Q divider target ratio */
> +       ratio =3D div64_u64((target_vco_rate << ROUND_SHIFT), parent_rate=
);
> +
> +       fbdiv =3D __wrpll_calc_fbdiv(c);
> +       best_r =3D 0;
> +       best_f =3D 0;
> +       best_delta =3D MAX_VCO_FREQ;
> +
> +       /*
> +        * Consider all values for R which land within
> +        * [MIN_POST_DIVR_FREQ, MAX_POST_DIVR_FREQ]; prefer smaller R
> +        */
> +       for (r =3D c->init_r; r <=3D c->max_r; ++r) {
> +               /* What is the best F we can pick in this case? */

Is this a TODO?

> +               f_pre_div =3D ratio * r;
> +               f =3D (f_pre_div + (1 << ROUND_SHIFT)) >> ROUND_SHIFT;
> +               f >>=3D (fbdiv - 1);
> +
> +               post_divr_freq =3D div_u64(parent_rate, r);
> +               vco_pre =3D fbdiv * post_divr_freq;
> +               vco =3D vco_pre * f;
> +
> +               /* Ensure rounding didn't take us out of range */
> +               if (vco > target_vco_rate) {
> +                       --f;
> +                       vco =3D vco_pre * f;
> +               } else if (vco < MIN_VCO_FREQ) {
> +                       ++f;
> +                       vco =3D vco_pre * f;
> +               }
> +
> +               delta =3D abs(target_rate - vco);
> +               if (delta < best_delta) {
> +                       best_delta =3D delta;
> +                       best_r =3D r;
> +                       best_f =3D f;
> +               }
> +       }
> +
> +       c->divr =3D best_r - 1;
> +       c->divf =3D best_f - 1;
> +
> +       post_divr_freq =3D div_u64(parent_rate, best_r);
> +
> +       /* Pick the best PLL jitter filter */
> +       c->range =3D __wrpll_calc_filter_range(post_divr_freq);

This can return -1 (really should be an error code). Check the return
value and then assign?

> +
> +       return 0;
> +}
> +
> +/**
> + * analogbits_wrpll_calc_output_rate() - calculate the PLL's target outp=
ut rate
> + * @c: ptr to a struct analogbits_wrpll_cfg record to read from
> + * @parent_rate: PLL refclk rate
> + *
> + * Given a pointer to the PLL's current input configuration @c and the
> + * PLL's input reference clock rate @parent_rate (before the R
> + * pre-divider), calculate the PLL's output clock rate (after the Q
> + * post-divider)
> + *
> + * Context: Any context.  Caller must protect the memory pointed to by @c
> + *          from simultaneous modification.
> + *
> + * Return: the PLL's output clock rate, in Hz.
> + */
> +unsigned long analogbits_wrpll_calc_output_rate(struct analogbits_wrpll_=
cfg *c,

Can c be const?

> +                                               unsigned long parent_rate)
> +{
> +       u8 fbdiv;
> +       u64 n;
> +
> +       WARN(c->flags & WRPLL_FLAGS_EXT_FEEDBACK_MASK,
> +            "external feedback mode not yet supported");

Should we return then?

> +
> +       fbdiv =3D __wrpll_calc_fbdiv(c);
> +       n =3D parent_rate * fbdiv * (c->divf + 1);
> +       n =3D div_u64(n, (c->divr + 1));

Drop useless parenthesis?

> +       n >>=3D c->divq;
> +
> +       return n;
> +}
> +
> +/**
> + * analogbits_wrpll_calc_max_lock_us() - return the time for the PLL to =
lock
> + * @c: ptr to a struct analogbits_wrpll_cfg record to read from
> + *
> + * Return the minimum amount of time (in microseconds) that the caller
> + * must wait after reprogramming the PLL to ensure that it is locked
> + * to the input frequency and stable.  This is likely to depend on the D=
IVR
> + * value; this is under discussion with the manufacturer.
> + *
> + * Return: the minimum amount of time the caller must wait for the PLL
> + *         to lock (in microseconds)
> + */
> +unsigned int analogbits_wrpll_calc_max_lock_us(struct analogbits_wrpll_c=
fg *c)

Can c be const?

> +{
> +       return MAX_LOCK_US;
> +}
> diff --git a/include/linux/clk/analogbits-wrpll-cln28hpc.h b/include/linu=
x/clk/analogbits-wrpll-cln28hpc.h
> new file mode 100644
> index 000000000000..f8dc732086fc
> --- /dev/null
> +++ b/include/linux/clk/analogbits-wrpll-cln28hpc.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

We don't need this boiler plate now that we have SPDX. Please remove it.

> + */
> +
> +#ifndef __LINUX_CLK_ANALOGBITS_WRPLL_CLN28HPC_H
> +#define __LINUX_CLK_ANALOGBITS_WRPLL_CLN28HPC_H
> +
> +#include <linux/types.h>
> +
> +/* DIVQ_VALUES: number of valid DIVQ values */
> +#define DIVQ_VALUES                            6
> +
> +/*
> + * Bit definitions for struct analogbits_wrpll_cfg.flags
> + *
> + * WRPLL_FLAGS_BYPASS_FLAG: if set, the PLL is either in bypass, or shou=
ld be
> + *     programmed to enter bypass
> + * WRPLL_FLAGS_RESET_FLAG: if set, the PLL is in reset
> + * WRPLL_FLAGS_INT_FEEDBACK_FLAG: if set, the PLL is configured for inte=
rnal
> + *     feedback mode
> + * WRPLL_FLAGS_EXT_FEEDBACK_FLAG: if set, the PLL is configured for exte=
rnal
> + *     feedback mode (not yet supported by this driver)
> + *
> + * The flags WRPLL_FLAGS_INT_FEEDBACK_FLAG and WRPLL_FLAGS_EXT_FEEDBACK_=
FLAG are

These flags aren't defined anywhere though? Instead they're shifts and
masks below?

> + * mutually exclusive.  If both bits are set, or both are zero, the stru=
ct
> + * analogbits_wrpll_cfg record is uninitialized or corrupt.
> + */
> +#define WRPLL_FLAGS_BYPASS_SHIFT               0
> +#define WRPLL_FLAGS_BYPASS_MASK                BIT(WRPLL_FLAGS_BYPASS_SH=
IFT)
> +#define WRPLL_FLAGS_RESET_SHIFT                1
> +#define WRPLL_FLAGS_RESET_MASK         BIT(WRPLL_FLAGS_RESET_SHIFT)
> +#define WRPLL_FLAGS_INT_FEEDBACK_SHIFT 2
> +#define WRPLL_FLAGS_INT_FEEDBACK_MASK  BIT(WRPLL_FLAGS_INT_FEEDBACK_SHIF=
T)
> +#define WRPLL_FLAGS_EXT_FEEDBACK_SHIFT 3
> +#define WRPLL_FLAGS_EXT_FEEDBACK_MASK  BIT(WRPLL_FLAGS_EXT_FEEDBACK_SHIF=
T)

Maybe you can use FIELD_GET/FIELD_SET?

> +
> +/**
> + * struct analogbits_wrpll_cfg - WRPLL configuration values
> + * @divr: reference divider value (6 bits), as presented to the PLL sign=
als
> + * @divf: feedback divider value (9 bits), as presented to the PLL signa=
ls
> + * @divq: output divider value (3 bits), as presented to the PLL signals
> + * @flags: PLL configuration flags.  See above for more information
> + * @range: PLL loop filter range.  See below for more information
> + * @output_rate_cache: cached output rates, swept across DIVQ
> + * @parent_rate: PLL refclk rate for which values are valid
> + * @max_r: maximum possible R divider value, given @parent_rate
> + * @init_r: initial R divider value to start the search from
> + *
> + * @divr, @divq, @divq, @range represent what the PLL expects to see
> + * on its input signals.  Thus @divr and @divf are the actual divisors
> + * minus one.  @divq is a power-of-two divider; for example, 1 =3D
> + * divide-by-2 and 6 =3D divide-by-64.  0 is an invalid @divq value.
> + *
> + * When initially passing a struct analogbits_wrpll_cfg record, the
> + * record should be zero-initialized with the exception of the @flags
> + * field.  The only flag bits that need to be set are either
> + * WRPLL_FLAGS_INT_FEEDBACK or WRPLL_FLAGS_EXT_FEEDBACK.
> + *
> + * Field names beginning with an underscore should be considered
> + * private to the wrpll-cln28hpc.c code.

This sentence can be removed.

> + */
> +struct analogbits_wrpll_cfg {
> +       u8 divr;
> +       u8 divq;
> +       u8 range;
> +       u8 flags;
> +       u16 divf;
> +/* private: */
> +       u32 output_rate_cache[DIVQ_VALUES];
> +       unsigned long parent_rate;
> +       u8 max_r;
> +       u8 init_r;
> +};
> +
> +int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg *c,
> +                                       u32 target_rate,
> +                                       unsigned long parent_rate);
> +
> +unsigned int analogbits_wrpll_calc_max_lock_us(struct analogbits_wrpll_c=
fg *c);
> +
> +unsigned long analogbits_wrpll_calc_output_rate(struct analogbits_wrpll_=
cfg *c,
> +                                               unsigned long parent_rate=
);

I wonder if it may be better to remove analogbits_ from all these
exported functions. I suspect that it wouldn't conflict if it was
prefixed with wrpll_ and it's shorter this way. Up to you.
=20
