Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8B1272F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 02:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLTBos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 20:44:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40686 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:44:48 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so7805224iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEwk0J0BmZw6m3cUGWGohPOAXpqKE+sp6lfv0aKYwSA=;
        b=BCEJG8Pnn7zRX2hVFrKBtfEvBy5FVy2pKsPDlJnMqBSlW3lSfVWwGWGY/XWUBLf7cy
         oZ2UA3E3wReM6h6V3zBhiSta/C/LGav3Lt5hP+XeEzziKgLA3q3V2wxhT7Am0giAvLAC
         nvN8M8xCJ+cSfarEHrjp8Nzb9OlHrjswjB4JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEwk0J0BmZw6m3cUGWGohPOAXpqKE+sp6lfv0aKYwSA=;
        b=oErr2Da1CR3tV6a4DA7DAoJ5//UHm6IpBX96t+m+aSkRXYIm86X3kCBONe4tT9d0Xz
         Li1EDiizqcugKD7KF/eQqLL68sZIC1ID1tIcqEejI7E2FZPzri8cH0vPfy8DfA7Z3Z8Z
         w0dpTIWwxoG+5grvSfGOCQMtTdgOqm6W0BGTVZsweD+Bu1bfIBFx1mH5R4HwqZTdr3pI
         m4OpwxV+rxEJnqvCe7LyMRSHd298Mh3pftpI274X1UiuI48nZiGdO+nlgtlv5KQwm8B8
         PCbDlmHwGlrGyNvny45FXa7pSI/1nP5jlt1damlJhUpWfj7vbIamkDGyZcNio1aXclUQ
         mQTg==
X-Gm-Message-State: APjAAAUByutNNSWC5Nx8vy9muvWjxsCLhkDQUnIX6I9R1DzL6Z4A9jda
        +hH0Aiubkiqduq87GYuezgg1AQ==
X-Google-Smtp-Source: APXvYqyY3jEL4NiI53AQszGHY3N9Ba44JmALN8fmmooTeX1dfVOwzufANLzAhloEAhLvM+j/gVZNYw==
X-Received: by 2002:a6b:c007:: with SMTP id q7mr7896221iof.58.1576806287673;
        Thu, 19 Dec 2019 17:44:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z15sm3514958ill.20.2019.12.19.17.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:44:46 -0800 (PST)
Subject: Re: [PATCH for 5.5 1/1] rseq/selftests: Turn off timeout setting
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191211162857.11354-1-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8f04858-ff13-8ec3-0249-8c864fad406a@linuxfoundation.org>
Date:   Thu, 19 Dec 2019 18:44:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211162857.11354-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:28 AM, Mathieu Desnoyers wrote:
> As the rseq selftests can run for a long period of time, disable the
> timeout that the general selftests have.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>   tools/testing/selftests/rseq/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/rseq/settings
> 
> diff --git a/tools/testing/selftests/rseq/settings b/tools/testing/selftests/rseq/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

I am pulling this patch in for Linux 5.5-rc4.

Let me know if you have any objections.

thanks,
-- Shuah
