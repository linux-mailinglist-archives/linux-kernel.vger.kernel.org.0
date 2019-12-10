Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711431180A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 07:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLJGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 01:43:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32948 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfLJGnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:43:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so7001191pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 22:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BEsOQpnU2Fph1cy4J7fXWqX+qA8/k32HrrzkPViDr9g=;
        b=rKWS+sYVsja9k0hTYRx7AD3FmdiYxmyDQegsZbxb9XSsVmjse2VRHmD+zciVbY9xfd
         Df1mS1W9/8ZsA4GVQIWMK851Wpq/RDC1D7KDrTFZD7tNqf0pzshtKjLPJfHkL3c5Fs+z
         PUsrAKqyP1GkR+Vh2SA8as16BNtsRfBKNmqdp/t3/i2dbbVGTQqsYIpsYfHxDrMiX+L0
         zTE4tXxRLhskmHL/IrAXD3zA8kxQ/IsiTVimAe7BYhO6yxeMPhXSOwmdvgnsu2dJo0pD
         6yfz739bpjiHyJe9zckZeSWxbYYVdFEDPIPWjJjYRZ+GRkTFoainVrKadvRc5Lx22kxI
         4uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEsOQpnU2Fph1cy4J7fXWqX+qA8/k32HrrzkPViDr9g=;
        b=iGrG6jgK809kotSkgRpJQQ5nVc9ul5O2sSN57oaj9m0ieVf2EguBz7cz4wijAEuLBF
         7u1NnREIHtkroWUyJ2QIBMfhoDuHGzfNIcDar7avLGmXx6AAynKVrVNRX1Q9EjSAcdG/
         tY4cdJbjjopXKeGxqe3BBIdR88PSzfsN4bxOf3BPNSjUV1Es47uH417o/PZRdmCeyjif
         mD5BnpT4rMlxgoUQ7y41E513BsAa6xww4RMIG+LmRCnacXUeocu6E0g/+LC0mwr8aIdw
         DCePQHVO0jBoAvrwWqen0qiIzPwXZG8YPZNPDJTE9FM61bOi3jP7cvji/qOeUy0G6edH
         eqtg==
X-Gm-Message-State: APjAAAVBHxlDLyjNd2FTQLbgDXNag6ImHZfuNYKJCIk/2EwmI2rToMhG
        stL9nK8HXDCFH0/3eb+B++gbxg==
X-Google-Smtp-Source: APXvYqwmAHfbEzPNm/4WgwvG4FJ85rMoFfIuvn1FMXhgED7o/6LqgNh4zD7c3ekP+QYYweyaLz2cHQ==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr34119958plt.156.1575960201667;
        Mon, 09 Dec 2019 22:43:21 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s7sm1509431pjk.22.2019.12.09.22.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 22:43:20 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:13:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        fan.chen@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [v5, PATCH 4/5] cpufreq: mediatek: add opp notification for SVS
 support
Message-ID: <20191210064319.f4ksrxozp3gv4xry@vireshk-i7>
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1574769046-28449-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20191127083619.etocnhpyyut3hzwq@vireshk-i7>
 <1575874588.13494.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575874588.13494.4.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-19, 14:56, andrew-sh.cheng wrote:
> On Wed, 2019-11-27 at 14:06 +0530, Viresh Kumar wrote:
> > On 26-11-19, 19:50, Andrew-sh.Cheng wrote:
> > > +		if (!IS_ERR(opp_item))
> > > +			dev_pm_opp_put(opp_item);
> > > +		else
> > > +			freq = 0;
> > > +
> > 
> > What is the purpose of the above code ?
> When dev_pm_opp_find_freq_ceil() doesn't find matching opp item, freq
> value won't be set.
> Set it as 0 for below checking
> > 
> > > +		/* case of current opp is disabled */
> > > +		if (freq == 0 || freq != info->opp_freq) {
> > > +			// find an enable opp item
> > > +			freq = 1;
> > > +			opp_item = dev_pm_opp_find_freq_ceil(info->cpu_dev,
> > > +							     &freq);
> > > +			if (!IS_ERR(opp_item)) {
> > > +				dev_pm_opp_put(opp_item);
> > > +				policy = cpufreq_cpu_get(info->opp_cpu);
> > > +				if (policy) {
> > > +					cpufreq_driver_target(policy,
> > > +						freq / 1000,
> > > +						CPUFREQ_RELATION_L);
> > 
> > Why don't you simply call this instead of all the code in the else
> > block ?
> These else code is used to check "current opp item is disabled or not".
> If not, do nothing.
> If current opp item is disabled, need to find an not-disabled opp item,
> and set frequency to it.

Right. So this notifier helper of yours receive the opp which is getting
disabled, why don't you compare its frequency directly to see if the current OPP
is getting disabled ?

-- 
viresh
