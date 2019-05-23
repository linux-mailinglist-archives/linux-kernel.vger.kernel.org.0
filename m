Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CE28980
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbfEWTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 15:38:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390653AbfEWTii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:38:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so7046269wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=usHFsL/Ku0+Qt69lCmqe22nPRQ+KCZhK+aj6hDp84KA=;
        b=dEsVb+717tCpXM8S8/JVSdaPBKgC83leuc1FOaorAZjd+ULMl6eVEbEy2UPyYsCWUS
         mZh7R6nEIeJNMWh3SVxRpUQG4GqALYcrNmdzk5ytH9Li/qOOm8nlLHyKs+qYkU8r3392
         ma2KBLIJutn+5Gmum7VdZSYnYE52esHH2dxBAJ6hW2VRC353R0zjMxfFV2327qj+KdU2
         aPHX7J9eB+KtvkI8MM0Yt59wOkgZLOcMrbe/pc+3hbJG90+avzfCAoAGezfgnU4D95OC
         +a8BEz2AA0Qyc5zDGQL/+pI/U3Zt2lgbkKZrEq7qNvP5Apux5z8CxI/YRrJgv6UnrheQ
         +0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usHFsL/Ku0+Qt69lCmqe22nPRQ+KCZhK+aj6hDp84KA=;
        b=OflHMISr5Y13ktDIFQ04MWuWky51GZcnnk7bWU2plAox7X0Xfvv4kxLAaXYTcAPyTv
         djcvfztwfYOWyyqHP1qVOAqqS/hpo0zKPoNwp1tVb0zs3xW5c+8izO2XESr0cI6uzVPC
         8/Z1pWn+M6gj1tTCyxpowtRnbbFFAkVmnVT/CZ7EXMY4bIt8HO0ZuU3HDRCAIHoDUK/9
         w3PfEJThYIo1oVp+0Rc4qZKEvjdTqvKSSx5bFWQODFcm1ttJxq1qE42oa9gvGEr8J1ou
         obLqknWGRfN/6WSJk5Tt2bAcj/8sHbuNaBCNimeANC4cRMWtRcrzXv/bPDP5Rcm25O5Y
         mcFw==
X-Gm-Message-State: APjAAAUYtGg5gq1JLfURQDMC+ZY6YT0TZi+3YoPOSLoYnzIAFWXDqYXP
        1brio54Ekwu4QPoNZFtrEQj3Wg==
X-Google-Smtp-Source: APXvYqw6ha7d5sNzeDFQr/ijdtNE/bEpoeVCKgQGVyf/DObuR09g3pB8MvOSpCNmuBgVeq+biOQ4CA==
X-Received: by 2002:a1c:20d7:: with SMTP id g206mr12847712wmg.136.1558640315678;
        Thu, 23 May 2019 12:38:35 -0700 (PDT)
Received: from [192.168.43.165] ([37.170.182.188])
        by smtp.googlemail.com with ESMTPSA id o6sm365890wrh.55.2019.05.23.12.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:38:35 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/ixp4xx: Implement delay timer
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190523181602.3284-1-linus.walleij@linaro.org>
 <3496e81f-ea63-794d-0d8a-8eba9f2f6853@linaro.org>
 <CACRpkdZ5LCeqkvJrN-TAcSy7knNOQhGV7M_wfZZ4Rz5ah87KnA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <08ab3a6e-5167-02e8-9d46-0186b92c8a71@linaro.org>
Date:   Thu, 23 May 2019 21:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ5LCeqkvJrN-TAcSy7knNOQhGV7M_wfZZ4Rz5ah87KnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2019 21:34, Linus Walleij wrote:
> On Thu, May 23, 2019 at 9:21 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 23/05/2019 20:16, Linus Walleij wrote:
> 
>>> This adds delay timer functionality to the IXP4xx
>>> timer driver.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> The patch does not apply on tip/timers/core
> 
> This seems to be because tip/timers/core is not yet containing
> the commits from v5.2-rc1.
> 
> Maybe I just send my patches too early after the merge window :)

Ok, I see thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

