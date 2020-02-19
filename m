Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC61640B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBSJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 04:45:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38620 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBSJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:45:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so12236411pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2sHioBgitIhnFo2YiqI9nwJzMPQopbQYiLEimmzsTw=;
        b=ZmeGzOyRoL/QKZoNhywtSO44lICxNKvYc//LurCRq9js/OnemH0nqVVJHQzSAPouuz
         PFpbfs4nWJirOWL9OuQk0htkEWzskQT0iXypda/eZmZccBW77wNZtP6t3ycSDynpt0rz
         mY8QUfeITpSvNZx5nYhAOhA3q12PKelPQ0f4edZqXN4ZXz6GDgNjB2tEHhBq3e/W+ei+
         iSojJIatqnbBNKw3bJSZ1H+3g23SLU4eGAh6KyEj19kQeu9F709Shn4Qc5NK76gO9hOa
         3Bxjxc4OnyT9FdwP9pU0SqVy5iqzxeMWuG1/cZkJsrkQ9JaCDG5lj/vR+ZqspXkKBPGM
         43BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2sHioBgitIhnFo2YiqI9nwJzMPQopbQYiLEimmzsTw=;
        b=F9zciA4+e2WKkP4gXPQulZ6eLIWTiO7fh+CTcEc8mOhbow+1BmJsd5maZjwBN7uOEg
         oFROrE+H8jyuiMkWbGNIkLdClJKgQkY+j1uiL5MdkRqpuBlMFflJgfpVn5gD5kxrNk1E
         3wrkDJvbSEE30j1HOcPidPfp6yL7CqkDGrlL5CgIhjrKZC/n4o755Fgj79HBfTexlogp
         RQrROcBeDxEf6QDAQUgMkLzMLNMTRjdHABZ/T2elFK++rmGFmlMnQoZeM9UvvW9jrj/7
         VJDrwO7e7ryTRFI5PxHa5FcI0ydF7EePFLU9D5qTycPuRnbBzXtHBFlrCFQYUL0NgFbO
         h/Qg==
X-Gm-Message-State: APjAAAVx8pUw+0kBZwDedd97tbPtkzHEvIGssQkscKvb7X5wAoGz4woA
        5KX/3mVywAoattt68EflpEmhBw==
X-Google-Smtp-Source: APXvYqw0pFDneFtW688nh18WrP7X4OhSccbWrIqI7ONYhXzLatnBM/oxLz41sfwbFVhqaoqM6Fx3Ig==
X-Received: by 2002:aa7:9525:: with SMTP id c5mr26040665pfp.133.1582105511258;
        Wed, 19 Feb 2020 01:45:11 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id z127sm1931611pgb.64.2020.02.19.01.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 01:45:10 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:15:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Message-ID: <20200219094508.trftyq22rwozzdh2@vireshk-i7>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
 <20200219093526.hexyzhfuirb2lg4m@vireshk-i7>
 <AM0PR04MB4481A321F1881B111D247BEB88100@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481A321F1881B111D247BEB88100@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-20, 09:41, Peng Fan wrote:
> In drivers/cpufreq/cpufreq.c, function __target_index. Line 2065, see below:
> 
> 2062         notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
> 2063         if (notify) {
> 2064                 /* Handle switching to intermediate frequency */
> 2065                 if (cpufreq_driver->get_intermediate) {
> 2066                         retval = __target_intermediate(policy, &freqs, index);
> 2067                         if (retval)
> 2068                                 return retval;
> 2069
> 2070                         intermediate_freq = freqs.new;
> 2071                         /* Set old freq to intermediate */
> 2072                         if (intermediate_freq)
> 2073                                 freqs.old = freqs.new;
> 2074                 }
> 
> Inspired from tegra20-cpufreq.c, use target_intermediate could handle
> i.MX7ULP cpufreq easier.

Ahh, sorry about that. Completely forgot this stuff existed :)

-- 
viresh
