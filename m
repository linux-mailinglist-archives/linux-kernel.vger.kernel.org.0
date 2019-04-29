Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6ADB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 07:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfD2Fny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 01:43:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40959 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2Fnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:43:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so791450pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6olaaoMgCPdNo+TQ5dKNbZrzG8cHHnKkwnShCeOItA=;
        b=vVTNghG8+EXptSKKElI+90BdcTKrPVcDaawjQoAPtAHprgvxAwfsIyUlN7eSQpkMq1
         r8IlUWyXc8o0gAgfuWbxADSpvDVIUSyjnBq4M16wgQ612CLJltsgXClxENqiTIS/cEsN
         L5UHLr/4iGjBnsuvcMJLgn+QAiLZ7IZlDD+CiJJrEV/jsMY11Iev1b5+C6zFodkqFRHd
         lbq+wtTJU3MULv0Vm/iu9qCuwdk6ZA8j5gQcgnDIeN2uenMC4yme8YB9c0fLX0wdn6sC
         TpsDCeNjhGi3LN+JARS7HwqqJucAA1DVs0QqOkM+MY4Zorb6dZYwwbBYLJjj6Jyvyvh2
         pfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6olaaoMgCPdNo+TQ5dKNbZrzG8cHHnKkwnShCeOItA=;
        b=NSp4mo6orvplwtNDnaBFHXtWs5oc67DLK57WoUfggALAbdB35x9zLoFPdVS0HHJEPj
         2Q8YvuhDaqiyjkI/rYT6NskW9v4RIlHI6OwmeBivWP8wLHzITpWmSyzCdi8dWkB73H7h
         uU4RvyPXJLPqpqLqxBXX89xwE1ys7fecyJ/DEXP5cW+OUH66Su2h6NQjLiKqjjB8AWCx
         dYkrHSZt16q+wCwREyPt30NAUsVZ9mhHyqV7D1YsOryS4lUAgFPxGqavzOT79AHAjaP6
         QCRoN4Ye+SAd1BYZZO4GAbMy06LnhEgseMFqv/y26uELD/U/ZDPzXSi4MnKqCkbg11SU
         /VMg==
X-Gm-Message-State: APjAAAX9ue/F+ErgDVTx7R5oai54g/qs/CyLExDwtmpcUmQCeTkEz7h3
        hiVTvWN4i4GHbI9qV46f656HijnnXBM=
X-Google-Smtp-Source: APXvYqyR0BedU0HRa9qIql/vNEnoOrMXmo165VyvbsnwOXe7QM4jxF/+e+MxiLue3le0JEShGbwICQ==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr59820324pfc.11.1556516632851;
        Sun, 28 Apr 2019 22:43:52 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h187sm55306813pfc.52.2019.04.28.22.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:43:52 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:13:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
Message-ID: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-19, 11:51, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
> 
> Fix it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Viresh Kumar <viresh.kumar@linaro.org>

What exactly have I done here ? :)

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ee8419a6390c..42aeb9087cab 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2012-2018 Linaro Limited.
> + *
> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *  This program is free software; you can redistribute it and/or modify
> -- 
> 2.17.1

-- 
viresh
