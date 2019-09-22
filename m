Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95591BA30D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfIVQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 12:13:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46422 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfIVQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:13:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 63E0381096; Sun, 22 Sep 2019 18:12:59 +0200 (CEST)
Date:   Sun, 22 Sep 2019 18:13:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     bleung@chromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org
Subject: Re: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
Message-ID: <20190922161306.GA1999@bug>
References: <20190916181215.501-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916181215.501-1-ncrews@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-16 12:12:15, Nick Crews wrote:
> The tm_yday and tm_wday fields are not used by userspace,
> so since they aren't needed within the driver, don't
> bother calculating them. This is especially needed since
> the rtc_year_days() call was crashing if the HW returned
> an invalid time.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/rtc/rtc-wilco-ec.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> index 8ad4c4e6d557..e84faa268caf 100644
> --- a/drivers/rtc/rtc-wilco-ec.c
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -110,10 +110,6 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>  	tm->tm_mday	= rtc.day;
>  	tm->tm_mon	= rtc.month - 1;
>  	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
> -	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> -
> -	/* Don't compute day of week, we don't need it. */
> -	tm->tm_wday = -1;
>  
>  	return 0;

Are you sure? It would be bad to pass unititialized memory to userspace...

If userspace does not need those fields, why are they there?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
