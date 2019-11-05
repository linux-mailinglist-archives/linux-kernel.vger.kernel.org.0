Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321AAEF5A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 07:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfKEGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 01:47:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33778 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbfKEGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:47:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so14446497pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c8eBVSCLgnx4UHNdOIdUmMHjAPLlK/lRDbaNxZy4A4c=;
        b=mEPTpthPqrMH5V6gpUyO2MP9vjXUVOG5F+cfT9fHTAvMDsPPnu++Uy0Y/UG1VJn5YB
         reVqWzhKjLkXKJEVOpPWdARHD0lqj2UqV+m7feK5PILe6moTpRjApPU5kK+I0/R3+RPc
         1Ng5a7znl+03oVa+3EvpFWPqYHxP5S3K1iv22FgcNrumGnBOOsKrmoRwAwoYfl3p/JKO
         Yz970pjFTHptsZLlCJ+GJUF/T33U/rERVx4Z+cntj127yJee4y01vFwqsfBQysMyyTmz
         0GV7j8Bhm+iIW7YG33GDh50N70CaHEuUuf6kqNCOzhYt3AR2Q39VH9eMvy8dt11Gatq3
         IomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c8eBVSCLgnx4UHNdOIdUmMHjAPLlK/lRDbaNxZy4A4c=;
        b=s+oxdbnQ7DGoQPUHVZxkw9jRTcwldza2R75px4d94K3iikW0VWGI1kdC78IwyNdYkA
         y6dtUXEHEmQYmnsobyGdG0cClAwDwgRyDDf9yA9RjhDS4zJeF+bTMti8x6rrA0Svbpm5
         8Uf4h9TomfG2l3veWc1iflqHPtb3OgptlUkSx4vwl7n22GwpeJ0MnRBGDo8860rE8VgW
         LekE5RP8LX8wDJGORkRL0VZYTpifRZ00FXYdh77FZEzWBMfGGdvMGCr9A9uT8SQkdn4B
         f76ztod68Jm2GI5XsCESImyrQfFH43Ll4pOkcNjOZpuoNYKEQJTLFnEcADUsQjwyjic0
         Sskg==
X-Gm-Message-State: APjAAAUn752JVxj4WvVtzRoEVKfRKGJMknExKmfWyR8h/Fxc/BkIKPTt
        p8WXBpxtHYAeOyE0wsEiybb3WQ==
X-Google-Smtp-Source: APXvYqysgFxpzP8+b+00PPJbazsimS6pA5b/uc82/LVtNch0fd3yxbSpRVAafZ4s/JVNEawZcmWuKQ==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr4506695pja.8.1572936460366;
        Mon, 04 Nov 2019 22:47:40 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id q184sm19465254pfc.111.2019.11.04.22.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:47:39 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:17:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/cpufreq/brcmstb-avs-cpufreq.c:449: bad test ?
Message-ID: <20191105064735.t6qiz2kc266em7vi@vireshk-i7>
References: <DB7PR08MB38017C35D2B5E025804338129C660@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB38017C35D2B5E025804338129C660@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-19, 15:18, David Binderman wrote:
> Hello there,
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c:449:61: warning: logical ‘or’ of collectively exhaustive tests is always true [-Wlogical-op]
> 
> Source code is
> 
>     return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
>         (rc != -EINVAL));
> 
> Maybe better code:
> 
>     return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
>         (rc != -EINVAL);

Right. Care to send a proper patch for this ?

-- 
viresh
