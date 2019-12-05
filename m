Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2F114448
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfLEQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 11:01:45 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48849 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLEQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:01:45 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ictZR-0000MW-0W; Thu, 05 Dec 2019 17:01:37 +0100
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Subject: Re: [PATCH] irqchip: define =?UTF-8?Q?EXYNOS=5FIRQ=5FCOMBINER?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 16:01:36 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, <tglx@linutronix.de>,
        Hyunki Koo <hyunki00.koo@samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <aa416a22-590d-e6df-ea99-4fe1fa3be388@gmail.com>
References: <20191205151319.22981-1-hyunki00.koo@gmail.com>
 <CAJKOXPeiJ-_w_=q+5Tk=X+LKzc+cCZzF_R5zHezrgQNDwLSucg@mail.gmail.com>
 <aa416a22-590d-e6df-ea99-4fe1fa3be388@gmail.com>
Message-ID: <439a4d91787deaff44d2203e32b74ea3@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: hyunki00.koo@gmail.com, krzk@kernel.org, tglx@linutronix.de, hyunki00.koo@samsung.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-05 15:44, Hyunki Koo wrote:
> there is no new driver
>
> I just want remove direct dependency between ARCH_EXYNOS and
> exynos-combiner.c
>
> because all exynos device is not needed the exynos-combiner
>
> only used in aarch32 devices.

So breaking all existing configurations (that will rely on this
driver to be selected by ARCH_EXYNOS) is absolutely fine, as long
as your pet machine is not "polluted" by an unnecessary driver?

I'm sorry, but that's not acceptable.

         M.
-- 
Jazz is not dead. It just smells funny...
