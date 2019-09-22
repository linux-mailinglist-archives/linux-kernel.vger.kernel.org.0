Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6686FBABB7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbfIVUn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 16:43:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37899 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfIVUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:43:56 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E845F20006;
        Sun, 22 Sep 2019 20:43:53 +0000 (UTC)
Date:   Sun, 22 Sep 2019 22:43:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org
Subject: Re: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
Message-ID: <20190922204353.GD3185@piout.net>
References: <20190916181215.501-1-ncrews@chromium.org>
 <20190916181215.501-2-ncrews@chromium.org>
 <20190922202947.GA4421@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922202947.GA4421@bug>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2019 22:29:48+0200, Pavel Machek wrote:
> On Mon 2019-09-16 12:12:17, Nick Crews wrote:
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/rtc/rtc-wilco-ec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > index e84faa268caf..951268f5e690 100644
> > --- a/drivers/rtc/rtc-wilco-ec.c
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
> >  
> >  MODULE_ALIAS("platform:rtc-wilco-ec");
> >  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("Wilco EC RTC driver");
> 
> File spdx header says GPL-2.0, this change would make it inconsistent with that...
> 

Commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
bogosity") doesn't agree with you (but I was surprised too).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
