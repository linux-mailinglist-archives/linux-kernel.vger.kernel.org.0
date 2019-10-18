Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42011DBD38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442083AbfJRFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:47:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43676 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfJRFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:47:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so2708137pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TiE6mrXNG7EqkcZ/U+Q35uelbhpLaDsgu+uQOO85Zos=;
        b=GT5coTqMgC0RpqXd7gG3yW2ilpPm5cZzvkTxi6FzIbbY4la707DrP5/nepX/YIM/bv
         GNro45KaBJKsI5YcmWVrWhP6svfuswi+XwUiuyZ7OEekpNi7yQjuK+6jsfJrnmOlkDGS
         9Dgd2fc4GS5TWS2CSTSqyZCJMhPQrEMqtmMpeWTk3qmIrrIevK9laoksrPssfgcYfFNa
         TekjbitHqxjwfjC2KyUWsW2pTDXKdvxxZOY29ROPr6m0oQsZSYd96kDGL9GQoj3WGIuR
         TRITWtWwpnRTHiXrarQOP9xfJFptIyyOQvxXnifzplyJ8r9hDJPMu56oQq6bv/3OVRax
         oPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TiE6mrXNG7EqkcZ/U+Q35uelbhpLaDsgu+uQOO85Zos=;
        b=Pugpruge80fpB96uqeMECzU1Ek6RtauFsa+xIx4HBwhgoBB14jKmQX9pxmxLGZfz2W
         kPhUjIoiaQrfVh9WTY4A2Hn7W+sR/8W8fhPT/6ITmXQ9rPRmkd7K2gUJV8N8GbZERJ6q
         QPYtqTpGWtmb9jUPS10LPuKKSyFzVcA3CmpT7r4se5jTtZ96aUUlBxJKrGvowcFIg4Xq
         IXQCkrLNKgJcbQY8vPmDTPtLEwJclTpYjfHTtga+96td8Jz+x4Z41r3EQjLY4BiqA5tv
         Z0GyYXcPHWxJZH8iabzqWt/2+N2S2R2TXCe7fPAcYsZFVWuqdS5EgZIRo6VfT2Sty9l/
         U/AQ==
X-Gm-Message-State: APjAAAUtD9CIis3rrMs2mqG2/Wao7dKcdEGq//UO2anzFUT08by3Mc0A
        QZRZ79jaQ0qPCZoFOJxOfFWQG60DUKg=
X-Google-Smtp-Source: APXvYqw0u5pU/YJB1pLyMOrYy32vfv7QWsaj3jE6gcSYufUNISW7CLe9bQeAT3MtxfOTk99PbjIt1g==
X-Received: by 2002:aa7:96ba:: with SMTP id g26mr4667261pfk.132.1571377662879;
        Thu, 17 Oct 2019 22:47:42 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id c11sm5741274pfj.114.2019.10.17.22.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:47:42 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:17:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 2/5] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191018054740.maqbzbk7secgpc2r@vireshk-i7>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017123508.26130-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 13:35, Sudeep Holla wrote:
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> similarity index 90%
> rename from drivers/cpufreq/arm_big_little.c
> rename to drivers/cpufreq/vexpress-spc-cpufreq.c
> index 7fe52fcddcf1..b7e1aa000c80 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -1,20 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * ARM big.LITTLE Platforms CPUFreq support
> + * Versatile Express SPC CPUFreq Interface driver
>   *
> - * Copyright (C) 2013 ARM Ltd.
> - * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> + * Copyright (C) 2019 ARM Ltd.

Should this be 2013-2019 instead ?

> + * Sudeep Holla <sudeep.holla@arm.com>
>   *
>   * Copyright (C) 2013 Linaro.
>   * Viresh Kumar <viresh.kumar@linaro.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>   */

-- 
viresh
