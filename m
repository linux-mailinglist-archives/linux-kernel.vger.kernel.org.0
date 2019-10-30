Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6CE9D65
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ3OYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfJ3OYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:24:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7372920656;
        Wed, 30 Oct 2019 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445461;
        bh=Kz0IT5UaT8gLAAfRWmhaV6j3O6NdS/ROd/IujVWkGVE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Z13SX6ZjaZruwkFG9gPRQOnp0DYWXrLzo722ret5nAfOi4ywm2QPXrTL8Iqn1b0OQ
         HG9p406cNxZ2wU+lrcTprSrTDE/3zfgdda4AUxlXEZsZ3BjhWchx6zwFsHtAXnjhdC
         upQvfFWx3jgixJub/DrHTlwj+WMPpju63SGMK7Ys=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97cb0b95-72e9-7aff-28de-637310d66caa@rasmusvillemoes.dk>
References: <20191004094826.8320-1-linux@rasmusvillemoes.dk> <CAMuHMdXSb0mgsqJgNFWqJXywQJLsqvasj7P_bUj4MBvyrAUgVw@mail.gmail.com> <97cb0b95-72e9-7aff-28de-637310d66caa@rasmusvillemoes.dk>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: mark clk_disable_unused() as __init
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 30 Oct 2019 07:24:20 -0700
Message-Id: <20191030142421.7372920656@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2019-10-29 15:20:22)
> On 07/10/2019 14.02, Geert Uytterhoeven wrote:
> > On Fri, Oct 4, 2019 at 12:30 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >> clk_disable_unused is only called once, as a late_initcall, so reclaim
> >> a bit of memory by marking it (and the functions and data it is the
> >> sole user of) as __init/__initdata. This moves ~1900 bytes from .text
> >> to .init.text for a imx_v6_v7_defconfig.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >=20
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Friendly ping. Will this be picked up?
>=20

Friendly reply. Yes.

