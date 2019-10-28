Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49BE7920
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 20:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfJ1TVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 15:21:37 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:24089 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfJ1TVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:21:37 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K7MZ2100Q5TFNlm037Mak1; Mon, 28 Oct 2019 20:21:35 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 20:21:35 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 07/46] ARM: pxa: move mach/sound.h to linux/platform_data/
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-7-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 20:21:33 +0100
In-Reply-To: <20191018154201.1276638-7-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 18 Oct 2019 17:41:22 +0200")
Message-ID: <874kzsoev6.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> This is a basically a platform_data file, so move it out of
> the mach/* header directory.
>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Tomas Cech <sleep_walker@suse.com>
> Cc: Sergey Lapin <slapin@ossfans.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
