Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0254574DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfGYMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:16:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38978 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGYMQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:16:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so34177097wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qs1aAu41zoW26CjgOOHRgDBblEEN+sirOIuSdx2Qjmw=;
        b=p11unN5mAIl6E/k8+BL+FL8i7hVlZcpFd0ltqnqKXQv88NUJ4TBugxdzqriPo4RPu1
         FqYFCb6jQHxwXwE01qi+zrVjvz9FMsE5sxJJtHjAaadBhoiLRFxiUck3pF/0wiHSvknd
         MwF2GNYx/0Vrxwc20WbyGSwvJ7/u46rfw0xFzoOyOhuRLiETXgQAJNLOdEMBeOoAPejp
         Qnw7UPxf/vHBt3kmOS+T9HJToCG3E5w4tCqw42CgEaYPnpoT/gY/K+9Rb8SzgATSZRdl
         +vm6hEpxNDA8JLnrUBkunmsLoFgw5bF9myLnjG0IVjK/w9H+DraPpIV7GKuX9gEABWHO
         dTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qs1aAu41zoW26CjgOOHRgDBblEEN+sirOIuSdx2Qjmw=;
        b=NgVj+rYKuo2FSAJzSxk/KfiICaLSkRF0TYLOj4GVo57vFVmHPwOOYjb3NdOUq6U5L0
         OJfLpfbaRmS7iIBAy5HSOq3AmTkfJMc/QkXecPbkKX6MPo+WcCPTY9vTWamkizDhYwWY
         TV4m4OIkZzeC63FcxdbCzn3L5CH7hP+IYQqmxzxnui1QWBegdIjrQN3/CGswugkfBm8M
         iOWDTBM5rZxLdVcpIVDYuEB037Ok9rxT6MBSFlDFWAzzQtKckXIQPRB13+8phGpAxzPj
         4Y0k8+Xf+I0Jp832d0vBIE3qh4GcpuA6650IUgBG4giCLt6W4U8vozoz0fRdG5e0y2Ca
         M4Dg==
X-Gm-Message-State: APjAAAWi9u1/t4Bqb4nrL3O4GuUFaApbXXYpjLeyKv1hDwgvLTXqOUv7
        5JWnWKmY4D93dDYddWyLBTAsY6Fx0O0=
X-Google-Smtp-Source: APXvYqxklzcEZdillbl8vOXs4v6DuegWy+CFi2t0wxe6mIA4plVhRhDElR3mL05JuymkvVzS8td/Eg==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr77135030wmj.174.1564056962149;
        Thu, 25 Jul 2019 05:16:02 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id r123sm45524482wme.7.2019.07.25.05.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:16:01 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:15:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Add of_node_put() before return
Message-ID: <20190725121552.GG23883@dell>
References: <20190709173132.13886-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709173132.13886-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jul 2019, Nishka Dasgupta wrote:

> Each iteration of for_each_child_of_node puts the previous node, but in
> the case of a return from the middle of the loop, there is no put, thus
> causing a memory leak. Hence add an of_node_put before the return.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/mfd/max77620.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Ah, I've just seen that you didn't send this to the list.

When submitting patches upstream, you must CC at least one list.

Usually people CC LKML as a matter of course.

I've CC'ed LMKL here and applied the patch.

> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index 0c28965fcc6a..a851ff473a44 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -416,8 +416,10 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
>  
>  	for_each_child_of_node(fps_np, fps_child) {
>  		ret = max77620_config_fps(chip, fps_child);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(fps_child);
>  			return ret;
> +		}
>  	}
>  
>  	config = chip->enable_global_lpm ? MAX77620_ONOFFCNFG2_SLP_LPM_MSK : 0;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
