Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44721272FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLTBoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 20:44:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46166 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLTBox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:44:53 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so6524069ilm.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ciw9vnVRcCYA+dSWsjs9iKvgTzFY8MfcjiTwjE8ubrY=;
        b=WKW3KpTVos12BAwj/V5uXYViT99udWZI5Qju0fvw7OyrPLdZFmCDi6fpypjaF5A9lB
         4GG5jOHe2NkwiStyKSaZ2482/hdeTjcREI7YzLAZxK4h94IGvbDcwVlgQttM57Bgbd1L
         HuOTnhAYDkMKMFAYYVARxSAjbKIMZyR9z4F2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ciw9vnVRcCYA+dSWsjs9iKvgTzFY8MfcjiTwjE8ubrY=;
        b=LGdg4DPbnWsIYFv/RtxJcwmW1ywjcJwDSZyW2zpN1Px2ECEvt9mkD9UxeDTgo/w2G6
         IDWTs3x1StR1bvp+GhZPk3qVPfnauzd6H/2ZWu16U13sEz1WwgmawEZ/+8J+6OU+pJU8
         UhS2KG65TbDA0dYicYnKZK6Fvx9srT6p9mFlt3ce3CUIdovUCK70l9tN2LmZZzYJIefI
         YSPNsk9fjGz5lPIfbk7ZX9bfjTaJYpJ1AcFbuAid1Yel/CtnU7I0Z6XMkT6KOW5m4Jwh
         jI7eXH2gAx3ua5r/diDKMbpcFKQNg2PmbdcLCM/NV6pgRqk/Oo2f/BufE18bSVTqKp9q
         19bw==
X-Gm-Message-State: APjAAAU0P8oavd3xqew1mEBw3jhALUVeDEWZysTtRvn+4UrG3s5KNTdD
        JVEJLW9HYsZ/7bXrChxcTpac2Q==
X-Google-Smtp-Source: APXvYqyO7gK9bPbl1xPhiRENbYQpzrOYfrdTD+C7OW15O8C5CpjNXXBeffVyjicqesLTQDD/c+otiw==
X-Received: by 2002:a92:3bc7:: with SMTP id n68mr10396531ilh.84.1576806292793;
        Thu, 19 Dec 2019 17:44:52 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 141sm3549593ile.44.2019.12.19.17.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:44:52 -0800 (PST)
Subject: Re: [PATCH for 5.5 3/3] rseq/selftests: Fix: Namespace gettid() for
 compatibility with glibc 2.30
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, stable@vger.kernel.org,
        "Tommi T . Rantala" <tommi.t.rantala@nokia.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191211161713.4490-1-mathieu.desnoyers@efficios.com>
 <20191211161713.4490-4-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <166a5ea8-65e8-2c8b-12ce-4cc7d8a77a74@linuxfoundation.org>
Date:   Thu, 19 Dec 2019 18:44:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211161713.4490-4-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:17 AM, Mathieu Desnoyers wrote:
> glibc 2.30 introduces gettid() in public headers, which clashes with
> the internal static definition within rseq selftests.
> 
> Rename gettid() to rseq_gettid() to eliminate this symbol name clash.
> 
> Reported-by: Tommi T. Rantala <tommi.t.rantala@nokia.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Tommi T. Rantala <tommi.t.rantala@nokia.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>	# v4.18+
> ---
>   tools/testing/selftests/rseq/param_test.c | 18 ++++++++++--------


I am pulling this patch in for Linux 5.5-rc4.

Let me know if you have any objections.

thanks,
-- Shuah
