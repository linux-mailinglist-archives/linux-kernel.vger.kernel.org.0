Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1301801C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCJP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 11:27:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgCJP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:27:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so11372575wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LjI4IW7CuuBnAiNN/wI4Y4tTmMxDl1C2yKa4O1GZZ8=;
        b=GR1hoSXSykV7wG3aWhZ3CvRrOrvKkE3Wph6GSdl9EAA8G3b8myYCdbp67ONYzc7e2C
         W6ITxdGZmpEgWLIHKTi4tZYpoWio+/UPk88nS+D1nX9ykCA7YozN1wfw6TU8Fs33mv3W
         4Q7Bu9/20ZIz7f9+o9wihVmfP/rUiuwcXMqzCFAD2K3GhChQm8bjkkFx61C6TZLc+Sqe
         48H3vto4AiO/NLQ8yyzWT2rrjEEL3E7h/9bRMYm+dpDvjW8fDzIJauWMaf5IeJxyypES
         eeHXTqg0BY+x+f4/b6ZwPOeYXAkTKP7SKzbvSRQO4SlDo/butMMgQ7NiGvk+KhwcIS3t
         5qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LjI4IW7CuuBnAiNN/wI4Y4tTmMxDl1C2yKa4O1GZZ8=;
        b=sA87WQAbWnvHIVIAzTMEGDu8LfTFYPcE8ifJj8uWMGbYFNYrbRt3zBvmSiEql9Zt0u
         L4AxtnKJUhLwUfvN7kF8dVD8py8Dn/1Dhv0rlR/c9CBucstT2KvOsFd07OMgOIWACkyZ
         buP7kvO5VjoGE9jm2qt4fN6t6FzOiRrqBk8Pc2LiW2q3IazSSd4e92SWoR3ae1oJT9gI
         OZByVIuY+dt+bkpAbi/gFejKO8J4niyTez4g76F1pY/4dSC2BCMFXpgDMIyJDGAkAIS3
         CCJApep5JS6mQeTQGL01RZVugQiodJQZb9baCL8QRy1bL3cJDY0+/yYIlouzZMQLvMS8
         rJRA==
X-Gm-Message-State: ANhLgQ2ZfuiI4gL1ydqEg9sWK0aqhXyUYC4nOnFXrRty0MxcswqGWmAv
        jSe6awy38Rd8Lvl9v4j4x+nsiw==
X-Google-Smtp-Source: ADFU+vsBBggc0x97WUZ6qoSZO8TvflomuxqqHU8axLnY+M4+YZhPfZvivjKVKcGlYgMIXbh9zjDycA==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr26644695wrx.14.1583854042426;
        Tue, 10 Mar 2020 08:27:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i204sm4374823wma.44.2020.03.10.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:27:21 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:27:19 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V3 2/4] backlight: qcom-wled: Add callback functions
Message-ID: <20200310152719.5hpzh6osq22y4qbn@holly.lan>
References: <1583760362-26978-1-git-send-email-kgunda@codeaurora.org>
 <1583760362-26978-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583760362-26978-3-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 06:56:00PM +0530, Kiran Gunda wrote:
> Add cabc_config, sync_toggle, wled_ovp_fault_status and wled_ovp_delay
> callback functions to prepare the driver for adding WLED5 support.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Overall this code would a lot easier to review if
> ---
>  drivers/video/backlight/qcom-wled.c | 196 +++++++++++++++++++++++-------------
>  1 file changed, 126 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3d276b3..b73f273 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -128,6 +128,7 @@ struct wled_config {
>  	bool cs_out_en;
>  	bool ext_gen;
>  	bool cabc;
> +	bool en_cabc;

Does this ever get set to true?

>  	bool external_pfet;
>  	bool auto_detection_enabled;
>  };
> @@ -147,14 +148,20 @@ struct wled {
>  	u32 max_brightness;
>  	u32 short_count;
>  	u32 auto_detect_count;
> +	u32 version;
>  	bool disabled_by_short;
>  	bool has_short_detect;
> +	bool cabc_disabled;
>  	int short_irq;
>  	int ovp_irq;
>  
>  	struct wled_config cfg;
>  	struct delayed_work ovp_work;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> +	int (*cabc_config)(struct wled *wled, bool enable);
> +	int (*wled_sync_toggle)(struct wled *wled);
> +	int (*wled_ovp_fault_status)(struct wled *wled, bool *fault_set);
> +	int (*wled_ovp_delay)(struct wled *wled);

Let's get some doc comments explaining what these callbacks do (and
which versions they apply to).

cabc_config() in particular appears to have a very odd interface for
wled4.  It looks like it relies on being initially called with enable
set a particular way and prevents itself from acting again. Therefore if
the comment you end up writing doesn't sound "right" then please also
fix the API!

Finally, why is everything except cabc_config() prefixed with wled?


Daniel.
