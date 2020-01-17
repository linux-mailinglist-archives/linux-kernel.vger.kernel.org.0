Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCB14022A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbgAQC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 21:59:59 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45604 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389121AbgAQC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:59:58 -0500
Received: by mail-pg1-f180.google.com with SMTP id b9so10902170pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z+YdJeFqFDZRiS6UDwTkhXHC91WQ1PZ11Rxt5I2e+FU=;
        b=OME1BEPmzQ43q7L6b6RwcTDzN4ky8vN6iW5h0/2emyXIECsky7iZXPnqyzRv093ppZ
         lF0W5SFvL5CCJjGYa22yIVb+8y4vpQrqZiwGICPwjOcoZnkUVVipcELGMXwoXaEtdZIG
         dj3GcBd9bPOvsyLDUbzX98O1FdmUNP7uO1rDk3g4htEdgpkeHtlcWflNGj5DeYdJQPT4
         X3ERHWTE/Y8Ppz3iq6d8lVBDzsbSmqqJeVuvtkHKQmXBi6dAfWO/ltPBZp6b5R0q+e9s
         gSj/VoDBc2HjcicB1V5XWrsIwhmg1pzxniaQDupXt3oVaFiygCDcyLLDUskLIYvOz2wJ
         uA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z+YdJeFqFDZRiS6UDwTkhXHC91WQ1PZ11Rxt5I2e+FU=;
        b=m3BWvvs5Sd03vsIaMugOtGe4vQfKIyiUDWNOq4/0Xb9EwkssO8hni9bXDl61jd4cq7
         NbzC8Fcc6hsa1AIAceSOASWTr1AKUrh/u9AISmqJ7y1yM0//bQmGxe5eyFKCqlPKeSSO
         X+Ugr7Bf6t+otRjkQLfRLljfIwn4wagTHg+hVAP03tKTxNIs7YFn0mdrJFdz5J70BHQz
         CxMHdTUyI0lmCeuSgUIbzctoLU7do613J2mipCgidihEsO58D6hrmpylR9opJkDJU8a/
         sbSTh7V7asfzknBKEms44n54b4NQZu1L8ginjko91K9fuHIGxGnzBBY5w+x3vBTIWZ22
         pWHw==
X-Gm-Message-State: APjAAAUryBggW5emSmsrpiQWfYLjm6Y/BITviabGi8owHv283bYNFeqd
        jVfO+KCIP6aKpP1yQyAwyCtjiZXQ76t21g==
X-Google-Smtp-Source: APXvYqyS/RKeM9zumYWvWIONZnnYQoo2K9mMGL30OI0gAqgkRZQYGDp2/hgWcYtcJbLOY/q14c0jWg==
X-Received: by 2002:a62:446:: with SMTP id 67mr713329pfe.109.1579229997428;
        Thu, 16 Jan 2020 18:59:57 -0800 (PST)
Received: from ?IPv6:2600:380:4b14:d397:f0a3:4fc6:c904:323a? ([2600:380:4b14:d397:f0a3:4fc6:c904:323a])
        by smtp.gmail.com with ESMTPSA id a26sm27407001pfo.27.2020.01.16.18.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 18:59:57 -0800 (PST)
Subject: Re: [PATCH] io_uring: remove extra check in __io_commit_cqring
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0d023acc096d63db454927590a5aca07deeac1cf.1579222330.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3109a4c-76c9-fc88-6140-5825fd5bf3e1@kernel.dk>
Date:   Thu, 16 Jan 2020 19:59:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0d023acc096d63db454927590a5aca07deeac1cf.1579222330.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 5:52 PM, Pavel Begunkov wrote:
> __io_commit_cqring() is almost always called when there is a change in
> the rings, so the check is rather pessimising.

Applied, thanks.

-- 
Jens Axboe

