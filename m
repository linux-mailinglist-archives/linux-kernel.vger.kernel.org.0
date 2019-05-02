Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6711B8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBOfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 10:35:30 -0400
Received: from muru.com ([72.249.23.125]:47968 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:35:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 501FD809B;
        Thu,  2 May 2019 14:35:46 +0000 (UTC)
Date:   Thu, 2 May 2019 07:35:25 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <a0230074@ti.com>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com
Subject: Re: [PATCH] ARM: dts: am57xx-idk: Remove support for voltage
 switching for SD card
Message-ID: <20190502143525.GP8007@atomide.com>
References: <20190502084748.22518-1-faiz_abbas@ti.com>
 <20190502142016.GO8007@atomide.com>
 <50559611-a501-4331-c88b-5d05f6e756e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50559611-a501-4331-c88b-5d05f6e756e9@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <a0230074@ti.com> [190502 14:30]:
> Hi Tony,
> 
> On 02/05/19 7:50 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [190502 01:48]:
> >> If UHS speed modes are enabled, a compatible SD card switches down to
> >> 1.8V during enumeration. If after this a software reboot/crash takes
> >> place and on-chip ROM tries to enumerate the SD card, the difference in
> >> IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.
> >>
> >> The fix for this is to have support for power cycling the card in
> >> hardware (with a PORz/soft-reset line causing a power cycle of the
> >> card). Since am571x-, am572x- and am574x-idk don't have this
> >> capability, disable voltage switching for these boards.
> >>
> >> The major effect of this is that the maximum supported speed
> >> mode is now high speed(50 MHz) down from SDR104(200 MHz).
> > 
> > This sounds a bit urgent, does it also need a stable tag or is
> > it safe to apply against any earlier kernels?
> > 
> 
> This should be good to apply on any previous releases.

OK applying both your MMC patches into fixes today.

Thanks,

Tony
