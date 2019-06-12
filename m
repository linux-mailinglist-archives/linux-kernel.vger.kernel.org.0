Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9918A41942
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392149AbfFLAIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 20:08:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfFLAIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:08:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so8474648pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 17:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGNSHS6b7nRtN7DrDXjS9yuoQKj+7ZkbE1CIpuAR0o0=;
        b=MQ8+52GhzhWZKD3KJyvwipDYgFo0aBfeAV4asNBlO1HN3E7RBSFhPidXKlsrutqxjp
         aBpiHXTYxXdT2Jo4++ZzdtJ1b49mQNMNGcn3EUCOpb5YopOUWVO7/8cOHObpXTvLnXrY
         M6Mb/SFP008eotrXlq0XND7Q/TH/iECuXkvjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGNSHS6b7nRtN7DrDXjS9yuoQKj+7ZkbE1CIpuAR0o0=;
        b=iOl7TMgZXOvmvfR8ID6MehqsqrYbN2DKJ1au3LEPOCS6BMZZpRmBw5+9NVsrQ8ByaN
         21XDpd/5y6KlTNB115W5R7LF1E6TRGWY2jfacxGxdmwa+2jpX+jJG//+O3LjfSxAx6JF
         o1/E2zaP/3Zo27o4ivK9oXx2Y/DLeuxKba5NNKeQDW95bNHKk3QaLE2pTOeu8NKwHnMR
         G1YXtbwl5bkraDugDCaLzSyyUoh/hzkFeGkkak/JmPzNECbSCSd6xnPwkV9Lm21j4WKc
         uz0bM9zLJIZWITd32RC8Q+Rda4ha71OoqsIufHObneAmMeeN9Hq05ksNjZhvAndtMAFf
         DGGQ==
X-Gm-Message-State: APjAAAU6UCsFKc0PH6tqj6aqB6r1VXJ0+H/nYbvsE9pV3qaVHFb1JJhO
        p6X6Gz7IxQMl32jOOSF76JLbJA==
X-Google-Smtp-Source: APXvYqxc4ALuUprM7w4tknTdmgXVfcDqP+QnqH3fxaQ40gioXu/MGGHFvDTnkI3q1VGAjtu6Cx1+1Q==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr29110581pjz.140.1560298115153;
        Tue, 11 Jun 2019 17:08:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u23sm10563943pfn.140.2019.06.11.17.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 17:08:33 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:08:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/5] PM / QOS: Pass request type to
 dev_pm_qos_read_value()
Message-ID: <20190612000832.GJ137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <b414d788faf4c6f87d01086248db4d2e86635180.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b414d788faf4c6f87d01086248db4d2e86635180.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:21:33PM +0530, Viresh Kumar wrote:
> In order to use dev_pm_qos_read_value(), and other internal routines to
> it, to read values for different QoS requests, pass request type as a
> parameter to these routines.

nit: I find that somewhat hard to parse, a possible improvement:

"In order to allow dev_pm_qos_read_value() and other {related,similar}
 internal routines to read values for different QoS requests, pass
 request type as a parameter to these routines."

(I'm not a native English speaker, so I don't claim this to be
correct ;-)

> For now, it only supports resume-latency request type.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt |  2 +-
>  drivers/base/power/domain_governor.c     |  4 +--
>  drivers/base/power/qos.c                 | 10 +++---
>  drivers/base/power/runtime.c             |  2 +-
>  drivers/cpuidle/governor.c               |  2 +-
>  include/linux/pm_qos.h                   | 41 +++++++++++++++++-------
>  6 files changed, 40 insertions(+), 21 deletions(-)

looks good to me, however I'm just a QoS n00b:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
