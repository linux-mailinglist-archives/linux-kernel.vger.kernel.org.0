Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4AEEA59E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 22:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfJ3Vkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 17:40:36 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:40413 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:40:36 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d15 with ME
        id KxgY2100E5TFNlm03xgYfx; Wed, 30 Oct 2019 22:40:34 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 22:40:34 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 46/46] ARM: pxa: move plat-pxa to drivers/soc/
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-46-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 30 Oct 2019 22:40:32 +0100
In-Reply-To: <20191018154201.1276638-46-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:42:01 +0200")
Message-ID: <87wocllxnz.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> There are two drivers in arch/arm/plat-pxa: mfp and ssp. Both
> of them should ideally not be needed at all, as there are
> proper subsystems to replace them.
>
> OTOH, they are self-contained and can simply be normal
> SoC drivers, so move them over there to eliminate one more
> of the plat-* directories.
>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
For the pxa part :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
