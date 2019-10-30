Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27987EA508
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 21:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfJ3U5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 16:57:18 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:29953 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfJ3U5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:57:17 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d15 with ME
        id KwxF210025TFNlm03wxFig; Wed, 30 Oct 2019 21:57:15 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 21:57:15 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 36/46] ARM: pxa: move smemc register access from clk to platform
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-36-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 30 Oct 2019 21:57:15 +0100
In-Reply-To: <20191018154201.1276638-36-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:51 +0200")
Message-ID: <87pnielzo4.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The get_sdram_rows() and get_memclkdiv() helpers need smemc
> register that are separate from the clk registers, move
> them out of the clk driver, and use an extern declaration
> instead.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
This patch bothers me a bit.

The idea behind generic.c is that it's a file common to all pxa2xx, pxa3xx
platforms. Yet with this patch, someone without history will believe that
calling pxa_smemc_get_sdram_rows() on a pxa3xx platform is perfectly valid,
while it is not, because DRAC2 doesn't exist on pxa3xx (bits are not defined in
MDCNFG).

At least I'll rename the function to pxa2xx_smemc_get_sdram_rows() if you don't
have a better idea.

Cheers.

--
Robert
