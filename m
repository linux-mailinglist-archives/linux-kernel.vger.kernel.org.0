Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED034CDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfFTM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 08:28:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45944 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfFTM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:28:22 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hdwAp-0003Td-BK; Thu, 20 Jun 2019 14:28:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yakir Yang <ykk@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] ARM: dts: rockchip: add startup delay to rk3288-veyron panel-regulators
Date:   Thu, 20 Jun 2019 14:28:14 +0200
Message-ID: <2226970.BAPq4liE1j@diego>
In-Reply-To: <CAD=FV=U23+5pcze=6zDTx0dAYF8HTmbR8s8zem93VhgYgaZeGQ@mail.gmail.com>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de> <1458265206-15733-5-git-send-email-heiko@sntech.de> <CAD=FV=U23+5pcze=6zDTx0dAYF8HTmbR8s8zem93VhgYgaZeGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Am Donnerstag, 20. Juni 2019, 03:27:55 CEST schrieb Doug Anderson:
> On Wed, Fri, 18 Mar 2016 Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > The panels need a bit of time to actually turn on. If this isn't
> > observed, this results in problems when trying talk to the panels
> > and thus produces detection errors. 100ms seem to be a safe value
> > for the time being.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 +
> >  arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 +
> >  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 +
> >  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 +
> >  4 files changed, 4 insertions(+)
> 
> I know it was 3 years ago, but any idea how to reproduce the problems
> you were seeing without this patch?  I believe the downstream kernel
> never had any delay like this and I'm not aware of any issues.
>
> I wonder if the need for this extra 100 ms delay is no longer there
> now that we have:
> 
> 3157694d8c7f pwm-backlight: Add support for PWM delays proprieties.
> 5fb5caee92ba pwm-backlight: Enable/disable the PWM before/after LCD
> enable toggle.
> 6d5922dd0d60 ARM: dts: rockchip: set PWM delay backlight settings for Veyron

I just did a non-scientific test on my jerry+minnie and yes, simply
reverting that patch does not seem to affect display bringup and I still
get a prompt.

So I guess we could just revert that patch in light of the changes.
[patches welcome ;-) ]

Heiko


