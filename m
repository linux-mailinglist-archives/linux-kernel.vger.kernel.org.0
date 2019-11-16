Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2ABFEA29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 02:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKPBpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 20:45:41 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44712 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKPBpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:45:40 -0500
Received: by mail-pl1-f178.google.com with SMTP id az9so5876172plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+r+DGtsqxKFObfIu/+a0rM7YdWT3Hu5doy0T2jUaCg=;
        b=NS+KRsSLddSeLOhePE0fMS1L4ilPIg6LfOSKLj5RdZv88sLQryro61uKoRzZCz3BBD
         MpO6gqdN01mv+jOjQy5OL3R8OHxbNXPYFvKB83+tJULVw78r6VJQtE2gCYInf0uH8Phc
         dyDolVMJ9eK9gOrIZfDaik4WvHtDnEjps7yQzAYb4QtHzA3+gMaOU719seTuHsoB5wXX
         WtvH7N43lpswwuxon04XUSdLeBAbG9mef6oqewcT577rzdKnOMHUK7QbqzxqBgUJWwMS
         L6wxdsDMHb2HQ+gicdKiUKSfQRHmtEOYsnqSZVF/3GSe6n+jL5FKiiSapyF9x4+q7mdB
         bqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+r+DGtsqxKFObfIu/+a0rM7YdWT3Hu5doy0T2jUaCg=;
        b=t0te+4p9t1tysAMLbTxDzTRbq/CNQAfhM/XCCqYeOEO2IN2Lx+NZ3fHYLqlG4RRsam
         gBPJiLr7Hgjgfu+cDU9Mh3t1NlCMOM2EGzUY17hmpMpaItaMkOfFD9/fsMXpHUl5I3ya
         OKGioOFpAkz9L9CGDlCsw8XPvfkWmIAt2zpHZjxIhSFWgjRiwywL+vq1oblIWRqZaPwe
         Z98GF09QSsC3g8kCDP7cJrcdiPuaAZNBGJeyLtWs06awSUKhHAAoYy2J8QnoHuQCT3M/
         yQiD7fuqFqwoxpua4MW0Rpqbb4lBFPSC95FxH2M6ZTc0TnkpzxQ08lcBxYC9MYug9zi/
         KVZA==
X-Gm-Message-State: APjAAAUl/mkCrrcW9Uta9bk93gcqK8NGyZNrAZuvhtx2Ci5WkfcAlt69
        eBj3npLqelahyRhqFJvyH3cqDQ==
X-Google-Smtp-Source: APXvYqxN3iPA9TuLpRAbHys8T2knz3Fvpj5w5DwGRFQnIxjd+34ZqdRRo0cZ4mwHNS9GAiehBk0Dsg==
X-Received: by 2002:a17:902:8494:: with SMTP id c20mr18609248plo.123.1573868738258;
        Fri, 15 Nov 2019 17:45:38 -0800 (PST)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id f189sm10793776pgc.94.2019.11.15.17.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:45:37 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:45:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        rafael@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
Subject: Re: [v3] soc: qcom: Introduce subsystem sleep stats driver
Message-ID: <20191116014534.GA25371@yoga>
References: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Nov 03:19 PST 2019, Maulik Shah wrote:
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 6f87b9d..e095eae 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -288,6 +288,16 @@ Description:
>  		writing a "0" (default) to it disables them.  Reads from
>  		this file return the current value.
>  
> +What:		/sys/power/subsystem_sleep/stats
> +Date:		December 2017
> +Contact:	Maulik Shah <mkshah@codeaurora.org>
> +Description:
> +		The /sys/power/subsystem_sleep/stats file prints the subsystem
> +		sleep information on Qualcomm Technologies, Inc. (QTI) SoCs.
> +
> +		Reading from this file will display subsystem level low power
> +		mode statistics.

sysfs files must follow the design of "one file, one value" and it must
be well defined. "sleep information" does not have a defined structure.

And as Stephen has pointed out several times, /sys/power/subsystem_sleep
is hardly the right place for a Qualcomm-specific entry.

[..]
> diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/subsystem_sleep_stats.c
[..]
> +static int __init subsystem_sleep_stats_init(void)
> +{
> +	struct kobject *ss_stats_kobj;
> +	int ret;
> +
> +	prvdata = kzalloc(sizeof(*prvdata), GFP_KERNEL);
> +	if (!prvdata)
> +		return -ENOMEM;
> +
> +	ss_stats_kobj = kobject_create_and_add("subsystem_sleep",
> +					       power_kobj);
> +	if (!ss_stats_kobj)
> +		return -ENOMEM;
> +
> +	prvdata->kobj = ss_stats_kobj;
> +
> +	sysfs_attr_init(&prvdata->ka.attr);
> +	prvdata->ka.attr.mode = 0444;
> +	prvdata->ka.attr.name = "stats";
> +	prvdata->ka.show = subsystem_stats_show;
> +
> +	ret = sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
> +	if (ret) {
> +		kobject_put(prvdata->kobj);
> +		kfree(prvdata);
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit subsystem_sleep_stats_exit(void)
> +{
> +	sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
> +	kobject_put(prvdata->kobj);
> +	kfree(prvdata);
> +}
> +
> +module_init(subsystem_sleep_stats_init);
> +module_exit(subsystem_sleep_stats_exit);

In the event that this is compiled as a kernel module, this driver won't
be automatically loaded - there's no references from other drivers nor
devicetree.

But equally big of an issue is that there's a single arm64 defconfig, so
this driver will be available on non-Qualcomm installations as well,
so you will be creating /sys/power/subsystem_sleep/stats regardless if
it ever will be possible to get any data out of this.

Regards,
Bjorn
