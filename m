Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6252D13A03D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 05:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgANE2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 23:28:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41044 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgANE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:28:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so4705166plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjNQBXAbjFbE6tB4pDxkpITB7JxRdTd+FwpRJxrl7BI=;
        b=eGZGbzyfpHfjOyV2U6dtgilWBwHrm44sbUbDGrsqNbCY36O8cArrB3L/CvMBbmlCqz
         43ZKHLde++61dO93BR52Jm3Nmk+v2wyjifurrEAJN+JYbDj9x/NS1ZbIMg4BOFHeuVKz
         LxQCh8Vy/1OfoWPTREd+8uKS5CwIdls3VxV0raxLOTP9l3Bptv1Lnb8WDgXSpYW/g0zV
         FN5hGKjH8WkbpNCB+t4gf+Ej5UeIeBjEe4x6ZpDNKH/q3xMVuMuupVyhh2ddfjhvnJPu
         FrTV/80BV24cQUe2UGaRr7HHHsmvv5Or6rKLjClMuTPItSczkB85q+n7bs1XVBI3OzYr
         BG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjNQBXAbjFbE6tB4pDxkpITB7JxRdTd+FwpRJxrl7BI=;
        b=NdPbJcDg2kTghBbrqs/EKc8e+aNAxMw26Mwg+oyVf5dgOwVEsAwHv6B1x7djznBVD9
         JKoh6WEq6HduSEk8XXyCti3/rXtl6TyocF1K8Y3of9k2wARpX6y3MPmvH0QA+4GzBqyj
         QOPogH9NKCBUOM99bD4ZAdkUnvd2wNlpMqDW30F8jL+gTD7ngbYSqLStijIXescge52r
         0iVqv4TWiGOgeqQFLJNdAVcE/S1DIHIu19N1cCYCUp0Tg6EjvrVAOchspkhmXT8/ZnCM
         cb7qdHGezwE2ImJjxCUBZk24mQbwp0kULFcbEwwCw0o+uT913cTQ28sQ3zKfK5+hgJv2
         VUWg==
X-Gm-Message-State: APjAAAUa5/pJ0aUVXqPkZPRfr+EVdz+BY+GOOaa7iJBS6vGReFvtIGmA
        NncWSEpp3t2sYCJwqhdwLIYKTEyt15I=
X-Google-Smtp-Source: APXvYqyW3QS3GtTgvX7yU8z6nfGYUoQwtwZf2offWJy0BKb5ZOQQbjkKRh8mpF70LnQNLE2xDutVhA==
X-Received: by 2002:a17:90a:a05:: with SMTP id o5mr26815301pjo.77.1578976123966;
        Mon, 13 Jan 2020 20:28:43 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id w38sm15645044pgk.45.2020.01.13.20.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 20:28:43 -0800 (PST)
Date:   Tue, 14 Jan 2020 09:58:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix spelling mistake: "Whethet"
 -> "Whether"
Message-ID: <20200114042840.swqanxtymyxottcu@vireshk-i7>
References: <20200113182228.1.I3c4155635fe990891a2c98c874cc4a270c82fe1b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113182228.1.I3c4155635fe990891a2c98c874cc4a270c82fe1b@changeid>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 18:22, Harry Pan wrote:
> Fix a spelling typo in the comment, no function change.
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> 
> ---
> 
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8ab31702cf6a..4bd9cb33132c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -172,7 +172,7 @@ struct vid_data {
>  /**
>   * struct global_params - Global parameters, mostly tunable via sysfs.
>   * @no_turbo:		Whether or not to use turbo P-states.
> - * @turbo_disabled:	Whethet or not turbo P-states are available at all,
> + * @turbo_disabled:	Whether or not turbo P-states are available at all,
>   *			based on the MSR_IA32_MISC_ENABLE value and whether or
>   *			not the maximum reported turbo P-state is different from
>   *			the maximum reported non-turbo one.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
