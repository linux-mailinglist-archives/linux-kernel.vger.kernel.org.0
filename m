Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6F74FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbfGYNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:43:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35865 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390050AbfGYNnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:43:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so48077949ljj.3;
        Thu, 25 Jul 2019 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJQV5wvFWxsEuA/Ecdi9hNVYPovQXpFL/Apsqwx1hKU=;
        b=PkaqfcmrxgjRX7D4Ljp7RvXLIukftgPjfTmhnC4QswnIm7GoiXVUgoGTPRRSBMbo11
         tD5VY0NHDgoS2yLxOZswQJEkD9lNY2+S/IgW6x6+Xm6BNisZIesz9nCLW5eWdIzfDIfh
         UxCZ9NqMNOJWTTxIMVyehmlGUFGQZnE6nbcbIpXD1iesVFvOcCc2fV7+AVoH6uh4fzJQ
         cglg43lB1kN7gpDBmOoKms/jxFLp+JnH/4NaT4qIDgVPzqNrZ0mWNDelBFZCwCP2rp+f
         TBDSmM+Mld3o06kHOZMtrj4VQvKL18moXn7gBAD0mOYImtkNaci2Ng1atv5/7VC2T1gS
         EZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJQV5wvFWxsEuA/Ecdi9hNVYPovQXpFL/Apsqwx1hKU=;
        b=jKbiH2474lZi+Pwn74FrsdLfvvMHOEqbv2Y4IYN/BA3SQdMrjVSWqRIkvvhUHgIqi7
         gRNUMTtos23HDaG5mu1ONpmpfYGJnIpqYKi7Lfq04kgumNJLfdXYbuDvDprBcATdhVkP
         3U5hiWTyzg/wdXNzrs2dLeRHVONP192YtUCDpCrv+rEIicE+vfvJJcsA1QEjX/eV3Ig/
         TnZwbeSnowflHJm8W1NQx36JZF7fq2x0+y5t3/46fA229esasZlxrJFVOWPlNO258UeW
         ropsTHlXnGw99oraciuWkKN4Za6CpuiCM+lEfaCSmaghcMxdl8mQIEz41Vlj2O/Vheo2
         L9gg==
X-Gm-Message-State: APjAAAXsx1wselHBiZ9YhSn+a5YT+pT75/I/y6TJSJkN/gWAAduYWp3n
        +NOvTEFD6HV12siRVfUO799iqdmh
X-Google-Smtp-Source: APXvYqxNIhVKPq6SLEintV2aQtzJkc3L38e4rCfwaxFNPMShnVss+1iheYjghIUCBT/k7PsFbVLi5w==
X-Received: by 2002:a2e:8741:: with SMTP id q1mr45713135ljj.144.1564062217787;
        Thu, 25 Jul 2019 06:43:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id m5sm7431039lfa.47.2019.07.25.06.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:43:36 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Tegra30+ CPU suspend-resume bug-fixes
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190707230358.10672-1-digetx@gmail.com>
 <f81a974b-4e64-9b66-0399-519480f53c31@gmail.com>
 <20190725094010.GK12715@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03de1cbe-7f0d-a7f0-edca-ee3b6b8c8417@gmail.com>
Date:   Thu, 25 Jul 2019 16:43:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725094010.GK12715@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.07.2019 12:40, Peter De Schrijver пишет:
> On Tue, Jul 23, 2019 at 04:28:35AM +0300, Dmitry Osipenko wrote:
>> 08.07.2019 2:03, Dmitry Osipenko пишет:
>>> Hello,
>>>
>>> This small series addresses two suspend-resume bugs: one affects Tegra30+
>>> due to a typo in the code, other fixes CPU hang on Tegra30 specifically.
>>>
>>> Please review and apply, thanks!
>>>
>>> Dmitry Osipenko (2):
>>>   ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
>>>   ARM: tegra: Use WFE for power-gating on Tegra30
>>>
>>>  arch/arm/mach-tegra/reset-handler.S |  6 +++---
>>>  arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
>>>  drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
>>>  3 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>
>> Hello Peter,
>>
>> We were talking about these fixes on the IRC not so long time ago, does
>> it look good to you? Care to give an ACK?
> 
> Acked-By Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Thanks!
