Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D25EA512
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 22:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfJ3VAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 17:00:09 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:37270 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfJ3VAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:00:08 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d15 with ME
        id Kx06210075TFNlm03x06pi; Wed, 30 Oct 2019 22:00:07 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 22:00:07 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 37/46] ARM: pxa: move clk register definitions to driver
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-37-arnd@arndb.de>
        <20191028093421.4F5C120B7C@mail.kernel.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 30 Oct 2019 22:00:06 +0100
In-Reply-To: <20191028093421.4F5C120B7C@mail.kernel.org> (Stephen Boyd's
        message of "Mon, 28 Oct 2019 02:34:20 -0700")
Message-ID: <87lft2lzjd.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Arnd Bergmann (2019-10-18 08:41:52)
>> The clock register definitions are now used (almost) exclusively in the
>> clk driver, and that relies on no other mach/*.h header files any more.
>> 
>> Remove the dependency on mach/pxa*-regs.h by addressing the registers
>> as offsets from a void __iomem * pointer, which is either passed from
>> a board file, or (for the moment) ioremapped at boot time from a hardcoded
>> address in case of DT (this should be moved into the DT of course).
>> 
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: linux-clk@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
