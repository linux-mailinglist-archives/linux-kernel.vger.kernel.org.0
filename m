Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F30CF946
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfJHMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfJHMGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:06:54 -0400
Received: from localhost (92-111-67-33.static.v4.ziggozakelijk.nl [92.111.67.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2C3206C2;
        Tue,  8 Oct 2019 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570536412;
        bh=Uj5x6J2gH97vDiZFnRpH5rNfDhiBDOr6x+X7q7iJ0jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5WIB6Znd6MmUFiZe7cgph9CBc1fO+biOlU76MaIEDNoUNutRckaP5t2Mm/TuJqDL
         hZEp9E9sM4a0nfrAhj/SvTFS+aWmGcwUdO7KNlJL+H6BYWG0F7pX61N9N98tq/NcQi
         KU49X+7gCqZLnPY/GrThfiKaOrzaW1+JYR1bKFuc=
Date:   Tue, 8 Oct 2019 14:06:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shuming Fan <shumingf@realtek.com>,
        sathya.prakash.m.r@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        dgreid@chromium.org, tzungbi@chromium.org
Subject: Re: [PATCH v2] firmware: vpd: Add an interface to read VPD value
Message-ID: <20191008120649.GC2761030@kroah.com>
References: <20191008101144.39342-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008101144.39342-1-cychiang@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:11:44PM +0800, Cheng-Yi Chiang wrote:
> Add an interface for other driver to query VPD value.
> This will be used for ASoC machine driver to query calibration
> data stored in VPD for smart amplifier speaker resistor
> calibration.
> 
> The example usage in ASoC machine driver is like:
> 
> #define DSM_CALIB_KEY "dsm_calib"
> static int load_calibration_data(struct cml_card_private *ctx) {
>     char *data = NULL;
>     int ret;
>     u32 value_len;
> 
>     /* Read calibration data from VPD. */
>     ret = vpd_attribute_read(1, DSM_CALIB_KEY,
>                             (u8 **)&data, &value_len);
> 
>     /* Parsing of this string...*/
> }
> 
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---

I can't take this patch without a real user of this function in the
kernel tree at the same time.  Please submit it as part of a patch
series with that change as well.

thanks,

greg k-h
