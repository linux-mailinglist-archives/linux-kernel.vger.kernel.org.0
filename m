Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAA15673C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBHTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 14:03:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43251 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:03:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id u131so1586598pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WKGslASOCJw9fH3wCvacNiNi/Eg9Xxun443ZFbQsq/Y=;
        b=H7AwUKxwj3AgcnUzdX+bAYwhdlA3o8FhdLERI7kkjGcEm/i51aOzWW2TJf1ZEl6+EK
         nW357lhAJGILHf5g9H+rnlHEFaqOcx4ar9LSspfnGI9umKyeBwgFAWnDc7g4GyWJiFe8
         YVfNe2YoRKqSJ9ohFJ46lXtWVyciDBiN8exlNui93mbFp9DKQkD9nsY4fNthfws/8rn+
         9u5cO9VMQ9DbmlX4X3HqWS47OLsAY5SF5fHQnPRedfjv628K4gQUIXbj264A5KXvXhFx
         I/iNXs2Ah4GWZvep+clzpUdG8P1ZJEAx1EnAwBtZm9Li01PdMO1/QC4HpNRw2Pe0Fvdp
         /PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKGslASOCJw9fH3wCvacNiNi/Eg9Xxun443ZFbQsq/Y=;
        b=T79/i0rQGQc45KpCtDsWGnjPPl/7ztIYRUFllr1jPmNKGES69r51gGPXqVgjoBYSm6
         BrTl8Yn0sTBDF6YjTyaExcBOlf8lCopTSQFunfqPj3nLMOOzIki1Nd3KfVaHBtIRP9uj
         HPDx1Iq8zOE7tD3f3mGZajCVD8SRyc53CunsW7/hyT033OmiYrz+vn8AG7jyx3gh4+lt
         tuzEBhGyZDxslAWRT72f976hYz2KKV0xXpLgSUIUNIBHJ0qjFhx/Pvd9rVJKru0iGyAR
         eNON7EG/Qz9sG6+oyCHlQLXGbMNDCX6tefnca1/F0lH4JkPEGoxmzDqT22Y5ZoqIL/Xl
         AVBA==
X-Gm-Message-State: APjAAAUhRJcLVQnxc0nQosBNC7h98iQUgK6OWSIM7Q8H7xz/Huvx0uQY
        q41AkfS/UCm4OpMxIiQRaUjqWW7WPIY=
X-Google-Smtp-Source: APXvYqwlpP9bUrL3nARRTpT0gLzoPOwlGe7Xc1j8a4wSNDkXpcHcT2e8aaZdQYY4krc1NFi2co5xVQ==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr5432421pfj.73.1581188601975;
        Sat, 08 Feb 2020 11:03:21 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q84sm7308326pgq.94.2020.02.08.11.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 11:03:21 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: fix async close()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6ab2ba6d202439323571ab6536025df0dd8b167e.1581159868.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36dfed78-3399-38f6-7c9c-807803dec72a@kernel.dk>
Date:   Sat, 8 Feb 2020 12:03:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6ab2ba6d202439323571ab6536025df0dd8b167e.1581159868.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/20 4:04 AM, Pavel Begunkov wrote:
> First, io_close() misses filp_close() and io_cqring_add_event(), when
> f_op->flush is defined. That's because in this case it will
> io_queue_async_work() itself not grabbing files, so the corresponding
> chunk in io_close_finish() won't be executed.
> 
> Second, when submitted through io_wq_submit_work(), it will do
> filp_close() and *_add_event() twice: first inline in io_close(),
> and the second one in call to io_close_finish() from io_close().
> The second one will also fire, because it was submitted async through
> generic path, and so have grabbed files.
> 
> And the last nice thing is to remove this weird pilgrimage with checking
> work/old_work and casting it to nxt. Just use a helper instead.

Thanks, applied. Nice cleanup, too!

-- 
Jens Axboe

