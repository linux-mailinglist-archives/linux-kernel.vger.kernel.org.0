Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF617ADF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCESPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:15:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38065 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCESPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:15:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id e20so4868347qto.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=taGYctWUYbUF3wN5YqlkpDDhXC7j/BKiUe4CLO3HA00=;
        b=fi9OUuEfnNwsMFfZ6K9oDoplTvqx+7muOU76Ic3e4RAD39qYdTda8npDlz1U3dqyG+
         q+tf7QuuAanHDQXMONjtT+/4C0SIOdoBtb3jdWJGHo7EoN6fX+zbueqEgECqlB/ueyZc
         iD8X1efeuxmkLP3nCQ6g7PJayKFyFNf+gFBIJHjM+WUeUHnYe4EDUnYw9A3kjxTROSVj
         4nh8g255YcrxxMbVZle3h4s4ZK9O3hHhzfmGopN2+Jh0u91Qc/t+Xm0dOKXz3Ar6fB7J
         TM6eGMSxO/O9mUa2m0C0EDqGEgEyFwCLTx1kcgQK0GPgMJV0goSMjcEbQHUY41DFY6aA
         xxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=taGYctWUYbUF3wN5YqlkpDDhXC7j/BKiUe4CLO3HA00=;
        b=PE2R2OkgLW7UfTrfC+bQFLL9AWcJe55pGwacWYse61jhcKYaNa5TJTA0v1brD+tY/t
         4zCkIrPm5zniFP8OhFDmCQidZ/9+ofQuZqvGUzBN0M+3MF2QyUlNsYdoUFC4WSCPObaA
         1KH4g9ngGfNa9D+u0YIG3ukHx7Oo1hCvmIN9rrOWV+LhkwfHj7oZ504pXaVmrLMAv+c4
         1FVHupSP8Q32SmMxuuAnTwN3//B0X1a+6PjESTc3GzX4q3vjSGRYfS5A4o4MafSZI0jl
         VGh6CZGaIyCwgJCG0t96wPqdsxvV0ZZFWja/inl4imKhg74cxirP/IpmzzSHg1TWugQ+
         h8dw==
X-Gm-Message-State: ANhLgQ0nDUPIlTtSarK1VJzz5UqKOkEI6eXImE8n7v2ddCc9KdWrHx3k
        ZQKSFN/aQUGJiBDEbtgP0bI=
X-Google-Smtp-Source: ADFU+vtM6tWWY3q8eUJiPICKsST9fUvV4TO81glTFHhrwj8nGzxZynulWGfYiAqfFZDYLHIsJtULVw==
X-Received: by 2002:ac8:5644:: with SMTP id 4mr3148736qtt.195.1583432137577;
        Thu, 05 Mar 2020 10:15:37 -0800 (PST)
Received: from [10.94.4.21] (189-94-128-21.3g.claro.net.br. [189.94.128.21])
        by smtp.gmail.com with ESMTPSA id k1sm9975455qkj.69.2020.03.05.10.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:15:37 -0800 (PST)
Date:   Thu, 05 Mar 2020 15:14:35 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200305153434.5r2jqsfxyrusrgwc@linux-p48b>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com> <20200305083714.9381-3-tommi.t.rantala@nokia.com> <20200305145149.GB7895@kernel.org> <20200305153434.5r2jqsfxyrusrgwc@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] perf bench futex-wake: Restore thread count default to online CPU count
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <64827405-D03D-4216-A3BD-8547AE42450B@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 5, 2020 12:34:34 PM GMT-03:00, Davidlohr Bueso <dave@stgolabs=2En=
et> wrote:
>On Thu, 05 Mar 2020, Arnaldo Carvalho de Melo wrote:
>
>>Em Thu, Mar 05, 2020 at 10:37:13AM +0200, Tommi Rantala escreveu:
>>> Since commit 3b2323c2c1c4 ("perf bench futex: Use cpumaps") the
>default
>>> number of threads the benchmark uses got changed from number of
>online
>>> CPUs to zero:
>>>
>>>   $ perf bench futex wake
>>>   # Running 'futex/wake' benchmark:
>>>   Run summary [PID 15930]: blocking on 0 threads (at [private] futex
>0x558b8ee4bfac), waking up 1 at a time=2E
>>>   [Run 1]: Wokeup 0 of 0 threads in 0=2E0000 ms
>>>   [=2E=2E=2E]
>>>   [Run 10]: Wokeup 0 of 0 threads in 0=2E0000 ms
>>>   Wokeup 0 of 0 threads in 0=2E0004 ms (+-40=2E82%)
>>>
>>> Restore the old behavior by grabbing the number of online CPUs via
>>> cpu->nr:
>>>
>>>   $ perf bench futex wake
>>>   # Running 'futex/wake' benchmark:
>>>   Run summary [PID 18356]: blocking on 8 threads (at [private] futex
>0xb3e62c), waking up 1 at a time=2E
>>>   [Run 1]: Wokeup 8 of 8 threads in 0=2E0260 ms
>>>   [=2E=2E=2E]
>>>   [Run 10]: Wokeup 8 of 8 threads in 0=2E0270 ms
>>>   Wokeup 8 of 8 threads in 0=2E0419 ms (+-24=2E35%)
>>>
>>> Fixes: 3b2323c2c1c4 ("perf bench futex: Use cpumaps")
>>
>>Thanks, tested and applied=2E
>
>Thanks!

Taking that as an Acked-by, ok?

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
