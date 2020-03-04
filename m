Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2445C179B13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 22:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgCDVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 16:38:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35821 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgCDVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:38:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id s8so1516556pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zya0a4hWggA1H31y1NhuXMUGNeawz1BRvjVCGIwcxZg=;
        b=IMfS/redeXHNRbO0CWNxq4ChVRncUl4loQytIGK0shTFNF0JDdBnjpdbilx1QJ1cel
         ORe39DQe9Vte3aap3KOzQcDIUGsi50wBSDnQGU7bHsVV1sMNlgypN5u0CNGMZZk5uEJJ
         BOATQkGWjbxvILRt1lMBBXoV9UswaPBtQEDvmYccvmdbbLl3I7tKCJRgAlDi02x1GgF8
         HrIbrgBF6UPKZ657JekPZL09NUarIREb148+glZzJUI2pj1bW7aMfZFMRskIlUuH4/Be
         xV6ZnkEInHLwc/rOvR02ACpWc0iyIrzwfBr/7BRJNRjk5AMWcUXwNBE2AOPDwEzjkOo0
         nSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zya0a4hWggA1H31y1NhuXMUGNeawz1BRvjVCGIwcxZg=;
        b=eqFNYOpURqMe8DIYwhU4ryHEgTzwf3RQoBk6q0TJCAa0gIt11FCnoDMIXJkKykTibh
         4D8cwGVpu0qZntQ4MRrte+NjsSEQAV24Fd/C+RboNgKDno5XL/oDSPNWqF/5q23eW8+Y
         xQj04MsgkYeoPfsbeTZBN01UgRSZL2KdqtOp9WVVtAh6j7bgtQMb5bb8ouPFT3n41tqh
         ZAjLSwjp+4o2jP7Ar+Pl79kOMKRsocMN7shOEPDTCO20qNJOv8A2oWwlQsK+ys+dxdnq
         hY+57OFlSIF+EUHEIVSs6CnCMapKiu5t6Edqzqf1y0BNblXSU+G2uWF6EAxX9iuqKLP/
         Ombw==
X-Gm-Message-State: ANhLgQ3cnH+LZSVxZClUlcF8AcEeEQmmpB9JQvXjHkXLACkX32cy+/Lu
        iTuMVnX8x8IrigdEhkBAH4OYXA==
X-Google-Smtp-Source: ADFU+vsrko71GJpds8JWTZOPI/Bss4D55JUOGfbW49T37nOp5PajcVcX4yNMaZkER8KLlEAMPszwXw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr4939350plt.27.1583357935128;
        Wed, 04 Mar 2020 13:38:55 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d3sm28664532pfn.113.2020.03.04.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:38:54 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:38:52 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, afd@ti.com, s-anna@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv7 13/15] remoteproc/omap: Report device exceptions and
 trigger recovery
Message-ID: <20200304213852.GA2799@xps15>
References: <20200221101936.16833-1-t-kristo@ti.com>
 <20200221101936.16833-14-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221101936.16833-14-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:19:34PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The OMAP remote processors send a special mailbox message
> (RP_MBOX_CRASH) when they crash and detect an internal device
> exception.
> 
> Add support to the mailbox handling function upon detection of
> this special message to report this crash to the remoteproc core.
> The remoteproc core can trigger a recovery using the prevailing
> recovery mechanism, already in use for MMU Fault recovery.
> 
> Co-developed-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
> Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/remoteproc/omap_remoteproc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 1ac270df4d66..7dcb5da0d940 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -383,8 +383,12 @@ static void omap_rproc_mbox_callback(struct mbox_client *client, void *data)
>  
>  	switch (msg) {
>  	case RP_MBOX_CRASH:
> -		/* just log this for now. later, we'll also do recovery */
> +		/*
> +		 * remoteproc detected an exception, notify the rproc core.
> +		 * The remoteproc core will handle the recovery.
> +		 */
>  		dev_err(dev, "omap rproc %s crashed\n", name);
> +		rproc_report_crash(oproc->rproc, RPROC_FATAL_ERROR);
>  		break;
>  	case RP_MBOX_ECHO_REPLY:
>  		dev_info(dev, "received echo reply from %s\n", name);
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
