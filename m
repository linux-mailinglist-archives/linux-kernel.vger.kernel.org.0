Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A827C10CE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1Rxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 12:53:32 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33907 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1Rxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:53:31 -0500
Received: by mail-pj1-f65.google.com with SMTP id bo14so12169895pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdiyJnoIXW3HPN+NZ9TvpSYcuqNgzEMV8o501cdtSrw=;
        b=izajUY866oRtivMGERDSR3ecrfQd4tWez6XLwZVvgf3FmPMa5/0AO/NCXYS0DgOKsC
         x3VOrmIKk86sEz5tEVnEqFl16BSFwwl+tnD5MsGaypKq7Vtj+8FveuSFlJIPGcrVrQ0H
         s0Bl83JBlxrV/5CpQidl36sfAfJ1YjjiRGT9rH3T7Ub3TY3Bs3ADIK3nBZn+e/at0Lzp
         80Fe6uaybnuBKfMszoFoDVg/jgtP07L8GRMLfUhHcaQOmCtV0zSiBEjsZE5bHFsTVelT
         ZPfD4MWwnHkN8WiyYbbeUr7occi8M7UI0544lqSrxlZqUebBUU4bSkZ1f4Yujjmkp1R9
         GNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdiyJnoIXW3HPN+NZ9TvpSYcuqNgzEMV8o501cdtSrw=;
        b=IxT1Rf1vh5wl4RJBDYLfiwIS/VvxPWGO2K40oQz8E26Blj5d9a7SXsvk+d8qy0TFTh
         FWRpCHkMZoK0PCPYsA3IpyT1B8QT5YlUmN7doAP4P9Xf8rsKlluA0bUubVzWGNWKlVbR
         9b711YerEU5v0lQ/8g1TvpTW3W208GL9u9rNa2TUcGFWoJYnZF+0l3cGVvQotAw5c9xt
         v5YAfE7PbZy5BI6K2uczNmx7cbXI/pQnELTs0fY+RETivehuckiPhvLxWvkXTjx6k7Q4
         3MV9GkPjbV3ueAE5/pvR0O2KyW+0t6FfVGaiIhHqrAC/AP3EOwcjsCgKLj6gTYJ+Oi6I
         g9Aw==
X-Gm-Message-State: APjAAAVu5HTjVM7EmQpvZa5IbIGEUji9IileDVx6awJ7XAZQsyGTbBNS
        Eb2kgVNPaWNLeaXngwB/d8lhSw==
X-Google-Smtp-Source: APXvYqwZUeynH3nuO3cHAd6ukK6Z0iaZZFDjlE/JN+br739G9O4/Gqwr7S/5/erl3PZ9BdY4if/BgA==
X-Received: by 2002:a17:902:bc4b:: with SMTP id t11mr10373553plz.22.1574963610940;
        Thu, 28 Nov 2019 09:53:30 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e1sm4953181pfl.98.2019.11.28.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 09:53:30 -0800 (PST)
Date:   Thu, 28 Nov 2019 09:53:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org, agross@kernel.org,
        daidavid1@codeaurora.org, masneyb@onstation.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] interconnect: Add a common standard aggregate
 function
Message-ID: <20191128175327.GD82109@yoga>
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Nov 05:48 PST 2019, Georgi Djakov wrote:

> Currently there is one very standard aggregation method that is used by
> several drivers. Let's add this as a common function, so that drivers
> could just point to it, instead of copy/pasting code.
> 
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/interconnect/core.c           | 10 ++++++++++
>  include/linux/interconnect-provider.h |  8 ++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 0e4852feb395..2633fd223875 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -221,6 +221,16 @@ static int apply_constraints(struct icc_path *path)
>  	return ret;
>  }
>  
> +int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(icc_std_aggregate);
> +
>  /* of_icc_xlate_onecell() - Translate function using a single index.
>   * @spec: OF phandle args to map into an interconnect node.
>   * @data: private data (pointer to struct icc_onecell_data)
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 31440c921216..0c494534b4d3 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -92,6 +92,8 @@ struct icc_node {
>  
>  #if IS_ENABLED(CONFIG_INTERCONNECT)
>  
> +int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>  struct icc_node *icc_node_create(int id);
>  void icc_node_destroy(int id);
>  int icc_link_create(struct icc_node *node, const int dst_id);
> @@ -104,6 +106,12 @@ int icc_provider_del(struct icc_provider *provider);
>  
>  #else
>  
> +static inline int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static inline struct icc_node *icc_node_create(int id)
>  {
>  	return ERR_PTR(-ENOTSUPP);
