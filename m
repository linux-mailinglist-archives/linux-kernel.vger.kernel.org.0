Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF0E7BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfJ1VpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:45:11 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:48767 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbfJ1VpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:45:11 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K9l82100U5TFNlm039l89N; Mon, 28 Oct 2019 22:45:09 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 22:45:09 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 30/46] SoC: pxa: use pdev resource for FIFO regs
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-30-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 22:45:08 +0100
In-Reply-To: <20191018154201.1276638-30-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:45 +0200")
Message-ID: <87pnigk0ij.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The driver currently takes the hardwired FIFO address from
> a header file that we want to eliminate. Change it to use
> the mmio resource instead and stop including the heare.
What is a "heare" ? I hear something like "including it here" maybe ...

Otherwise : Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
