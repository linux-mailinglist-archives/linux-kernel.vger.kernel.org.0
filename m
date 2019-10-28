Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181DBE782E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 19:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404350AbfJ1SOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 14:14:47 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:59369 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfJ1SOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:14:47 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K6El210025TFNlm036Ele0; Mon, 28 Oct 2019 19:14:45 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 19:14:45 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/46] ARM: pxa: make mach/regs-uart.h private
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-3-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 19:14:44 +0100
In-Reply-To: <20191018154201.1276638-3-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 18 Oct 2019 17:41:18 +0200")
Message-ID: <87lft4ohyj.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> This is not used by any drivers, so make it private to the
> platform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Too bad I don't have that board, because a more zealous change would be to use :
pxa_set_ffuart_info(NULL), pxa_set_btuart_info(NULL) and
pxa_set_stuart_info(NULL), and kill regs-uart.h ...

But anyway :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
