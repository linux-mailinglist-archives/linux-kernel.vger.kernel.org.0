Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25E437EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfFFUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 16:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfFFUfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:35:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A80208C3;
        Thu,  6 Jun 2019 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559853312;
        bh=FE9dK512c/wFHKFGlAS3dfE+HoQTVyNtrTLC+af8DVY=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=dBymB7Od4RlRir+NZNAly+YJeKeeWhTcLO7PIwfJDdVQvTdgIzADoTqU1q/tnjhAG
         cNQ147DwvQMdwjB+8gN9O4AlKn/F/JV05mYih8RRvaocE2Q/XqDry8OuERh5EqRbB+
         ULLY5j+iTLOrUOKXApW5wrsOTkB/c1Rs7YlFFn6U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190509202956.6320-2-f.fainelli@gmail.com>
References: <20190509202956.6320-1-f.fainelli@gmail.com> <20190509202956.6320-2-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: bcm: Make BCM2835 clock drivers selectable
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        eric@anholt.net, stefan.wahren@i2se.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 13:35:11 -0700
Message-Id: <20190606203512.96A80208C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Fainelli (2019-05-09 13:29:55)
> Make the BCM2835 clock driver selectable by other
> architectures/platforms. ARCH_BRCMSTB will be selecting that driver in
> the next commit since new chips like 7211 use the same CPRMAN clock
> controller that this driver supports.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/clk/bcm/Kconfig  | 9 +++++++++
>  drivers/clk/bcm/Makefile | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 4c4bd85f707c..0b873e23f128 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -1,3 +1,12 @@
> +config CLK_BCM2835
> +       bool "Broadcom BCM2835 clock support"
> +       depends on ARCH_BCM2835 || COMPILE_TEST
> +       depends on COMMON_CLK

This whole thing is inside the COMMON_CLK menu so this line probably
doesn't matter. Anyway, I'm just going to apply this to clk-next.

> +       default ARCH_BCM2835
> +       help
> +         Enable common clock framework support for Broadcom BCM2835
> +         SoCs.
