Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32FC112B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 13:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfLDMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 07:21:16 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:43763 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbfLDMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:21:16 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icTeU-0002F5-09; Wed, 04 Dec 2019 13:21:06 +0100
To:     <anarsoul@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/2] arm64:  =?UTF-8?Q?arch=5Ftimer=3A=20Workaround=20for=20Allwinner=20A=36=34=20time?=  =?UTF-8?Q?r=20instability?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Dec 2019 12:21:05 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <marc.zyngier@arm.com>, Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
In-Reply-To: <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
References: <20190113021719.46457-1-samuel@sholland.org>
 <20190113021719.46457-2-samuel@sholland.org>
 <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com>
 <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
Message-ID: <4b922079aeed04f31ff67b3e7fb78022@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: anarsoul@gmail.com, marc.zyngier@arm.com, samuel@sholland.org, catalin.marinas@arm.com, will.deacon@arm.com, maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[please note that my email address has changed]

On 2019-12-04 04:18, Vasily Khoruzhick wrote:

[...]

> Unfortunately this patch doesn't completely eliminate the jumps. 
> There
> have been reports from users who still saw 95y jump even with the
> patch applied.
>
> Personally I've seen it once or twice on my Pine64-LTS.
>
> Looks like we need bigger hammer. Does anyone have any idea what it 
> could be?

Which kernel version did you see this happening on?

         M.
-- 
Jazz is not dead. It just smells funny...
