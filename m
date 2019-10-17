Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06BDB211
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406499AbfJQQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:13:54 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:40971 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404522AbfJQQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:13:54 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iL8PM-0000EA-01; Thu, 17 Oct 2019 18:13:48 +0200
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] coccinelle: =?UTF-8?Q?api/devm=5Fplatform=5Fioremap?=  =?UTF-8?Q?=5Fresource=3A=20remove=20useless=20script?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Oct 2019 17:13:47 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        <kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
Message-ID: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: alexandre.belloni@bootlin.com, julia.lawall@lip6.fr, himanshujha199640@gmail.com, torvalds@linuxfoundation.org, kernel-janitors@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-17 15:22, Alexandre Belloni wrote:
> While it is useful for new drivers to use 
> devm_platform_ioremap_resource,
> this script is currently used to spam maintainers, often updating 
> very old
> drivers. The net benefit is the removal of 2 lines of code in the 
> driver
> but the review load for the maintainers is huge. As of now, more that 
> 560
> patches have been sent, some of them obviously broken, as in:
>
> 
> https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
>
> Remove the script to reduce the spam.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I think part of the issue is that the script reports a WARNING for 
something
that is definitely correct code, and could instead be simply toned 
down.

Anyway, FWIW:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
