Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BD587A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF0QwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 12:52:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41726 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0QwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:52:12 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so6233668ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DqFjunvfzffqgIZ8iiPD+H8SSoG6V+SP0K0VJ3A5fx0=;
        b=KQSa86Rm46KyflWbjO8sMEAvicvA0fyXn/hfsxo50Lw1VA1dzNt+KhHkni3IU3uJmt
         LTXSHoQWtOePNPIXO6KpE9GRjF15NYznxu3zD0rK+Z1XkiyCUDCAn9l33wCD/UvFn2NB
         nKpLlgGsubprhfhmV48zWz6Kz2c5GbEzpt+0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqFjunvfzffqgIZ8iiPD+H8SSoG6V+SP0K0VJ3A5fx0=;
        b=tVdmubzAHXoEyIcQMJ6Z1nSUd8+lNBQ3sw5AVnV3OF27zmoHcc1ZHsQF6gytV8Kuct
         KwTZleRiHwfzmuJtFPJ6DUAHdwsV6bHE8xpCDHh3kAgl7syD8sCzC7ISVFDfrykQw5qd
         FxWOJt37L/LWH0LyxJvcO23qnTjJ92sMMa/14hFNWZ3BWUiS47pn7oqoxoLvRnyLjWrx
         bkSoY4tjvJHCQupZ9Xe3tUxnYHHGMgspDTr06lo0ShoDTDeKnVbA57DG/QdJ9YJ2Uxos
         kssfTVA29lt9U5pNwOtXes0nKHe2wGzicD/c3nThQ2kv15MnY8+J7jN9wf7yT5afHvp9
         7zaw==
X-Gm-Message-State: APjAAAXv1jwqsrCet3J/C9wQ0+gPxRrVDW1I/3PBAM80X2uzTQ299u4s
        wSnDbffbynowFyAXpyWYCJlRdg==
X-Google-Smtp-Source: APXvYqyt6xnpjQsc6QrIQfSewwyhRWZas0FunrB6wbYdMEltDg38WA9/didDfmvSLS/Pz/SDe/hZnw==
X-Received: by 2002:a6b:b7d5:: with SMTP id h204mr5524563iof.188.1561654331901;
        Thu, 27 Jun 2019 09:52:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm3750702ioi.72.2019.06.27.09.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 09:52:11 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] packet: Fix undefined behavior
 in bit shift
To:     David Miller <davem@davemloft.net>
Cc:     c0d1n61at3@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190627010137.5612-1-c0d1n61at3@gmail.com>
 <20190627032532.18374-2-c0d1n61at3@gmail.com>
 <7f6f44b2-3fe4-85f6-df3c-ad59f2eadba2@linuxfoundation.org>
 <20190627.092253.1878691006683087825.davem@davemloft.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9687ddc6-3bdb-5b2a-2934-ed9c6921551d@linuxfoundation.org>
Date:   Thu, 27 Jun 2019 10:52:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627.092253.1878691006683087825.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 10:22 AM, David Miller wrote:
> From: Shuah Khan <skhan@linuxfoundation.org>
> Date: Wed, 26 Jun 2019 21:32:52 -0600
> 
>> On 6/26/19 9:25 PM, Jiunn Chang wrote:
>>> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
>>> significant bit to unsigned.
>>> Changes included in v2:
>>>     - use subsystem specific subject lines
>>>     - CC required mailing lists
>>>
>>
>> These version change lines don't belong in the change log.
> 
> For networking changes I actually like the change lines to be in the
> commit log.  So please don't stray people this way, thanks.
> 

As a general rule, please don't include change lines in the commit log.
For networking changes that get sent to David and netdev, as David
points out here, he likes them in the commit log, please include them
in the commit log.

I am working on FAQ (Frequently Answered Questions) section for mentees.
I will add this to it.

thanks,
-- Shuah
