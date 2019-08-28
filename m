Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CECA00BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1Ldg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 07:33:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37068 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Ldg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:33:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so1860128lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W4k922k9zeV+KfQfiJqR2N+91jdNw1/Jjb4KIs5vjPQ=;
        b=YorixTSYr0MhSCMW5HCOletixEn6/tOCf5UL+8sbNzlPEuMgChbvkGL2EH1dxfcCts
         MgKWJt/de/ny6cL0qu7LpJ5U1DQnoAZIDuArTGyINHElseqALQhXqW8QMF2z56eGkZni
         Ee3ktj55pxMJMfgsAmHdbvC/6t5xHpFWW++7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W4k922k9zeV+KfQfiJqR2N+91jdNw1/Jjb4KIs5vjPQ=;
        b=msL5gmiPKKR9AsYyUk5ToP1zpRkA/poaBLSM4saocxcePyuBF1O6757vTvFcRiF6OY
         IVUaiYne5ZPF4aT5GDs3suEcyOTMbX/SCRflG3O9JXiWs6wdl2n2SP0G4K6s6YbRG+xU
         dfAwjuMWGHWNVTL1QSlTS87pZstsEoRF5Hyk+kcgBbklSbuGU4m3Us5rJ64DeBFslR2v
         A/sVnmrsEFylvlWyi/AX0q/hJQuA0N/5jXuDtYj/lcQ9Ji1bJZW7BcZlPFDHoAt4yH6W
         pZImaI3Ly+b/lbFF9/OSbGqi6THzs4uxzlYpT0oj+n9xa4RA/wvM6JP6FzdDb50t+rFo
         wU3A==
X-Gm-Message-State: APjAAAXk/5KlddvwQyn8bcBKEFMiTf+O48kRBUWCdBM/8h145hEcGNwG
        m/maCxzG12RnT+ZPcgyq/wZoRg==
X-Google-Smtp-Source: APXvYqym2ZIXlCTSZj9PYR081sRv0P0cVnYj/nJ+YJ73BqhuE1ST8adMu93iCwUSHqAj9mO9KpihLA==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr2291210lfn.69.1566992014318;
        Wed, 28 Aug 2019 04:33:34 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v15sm764768lfg.19.2019.08.28.04.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 04:33:33 -0700 (PDT)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Date:   Wed, 28 Aug 2019 13:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2019 21.19, Julia Lawall wrote:
> 
> 
>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>
>>
>>
>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>
>>> Please explain _why_ is it better in the changelog.
>>>
>>
>> In my naive understanding the negation (!) before the likely/unlikely
>> could confuse the compiler
> 
> As a human I am confused. Is !likely(x) equivalent to x or !x?

#undef likely
#undef unlikely
#define likely(x) (x)
#define unlikely(x) (x)

should be a semantic no-op. So changing !likely(x) to unlikely(x) is
completely wrong. If anything, !likely(x) can be transformed to
unlikely(!x).

Rasmus
