Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADC51821
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfFXQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:12:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39826 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbfFXQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:12:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so13969189wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rMN3NSCV14U/djjBqah6itWb6YLCN7v9XBQWW70vOiE=;
        b=BeRjHkB5wYZcB0jrLUQae5J+2zrr8Fi+4ULgoGxmhOTCEhZaCQWl9uoSw20Kwytdtp
         HFBr4/cRhHhBi734UmikNXERcSu7e0qyFPJqfh0IaXGf0iLwr65cwOuXwV7xb02cN22y
         zrxBXMPYsWoDIoEfdLmyfQEzNFobWQqwCzgzHh/0xWh5vtnxpwMiei3OgqOExDl02rbh
         1EQvfX1RjPlMHJVLO8G8tyYpcEn3teDS5EP55YmZ21lmfLWJYjUEJ0RFCs+sGjt0Myft
         sEOYfRwUIulLKMvCrjL3UmxuT00e5rkhzZMRJSVTfpTk+8VDjxCgwgCZy3fJxq8/wmW7
         2S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rMN3NSCV14U/djjBqah6itWb6YLCN7v9XBQWW70vOiE=;
        b=MaD/BOHFyEZTEKd3R6X1j/fkSxRg05Q48jaEccw4QL29K1Mj+HxZXd3Zml1Pd7QoIq
         EX6Wp5KHbLi5BuKpHSZhoUFPzWDzb5bEmE09ClAjT50cGby+EnNCYOKavgTlxthpGCh+
         WCgph46KdhLLVj3Nvm7ZKhJeAI0I+Kn+WXE6wvkLahU7XHswF0CetEFNhvu+4zNZyCl4
         70iqxp3jcfnvkd3vOWkooTJxyq46nb2WKNPvTIO9aNKE5KeqLmpnaL5KpCBF6FlAwETb
         xuU336V/YwgRGDUC47Lwb1n4N8Sg/Z+yPrA0scZnMnTd8kPSNkZ5mr+U5bo2KyJtW2DB
         cFBw==
X-Gm-Message-State: APjAAAXS0rYEBf5YBKVGOxlb8iebVATpUMjPS10MVDRRJnY8afDHp/sn
        LAxKsZSYwwdAGFIk8tZFf29jJg==
X-Google-Smtp-Source: APXvYqxvj+TKqmmdbdKdA9FT/+f9mo+PTcoV+zToyGdDKDe5WcV9XGyShouys4BnvOkWQTBFTD7dpg==
X-Received: by 2002:a1c:343:: with SMTP id 64mr17469148wmd.116.1561392770706;
        Mon, 24 Jun 2019 09:12:50 -0700 (PDT)
Received: from [172.20.10.174] ([85.184.65.84])
        by smtp.gmail.com with ESMTPSA id a81sm15903831wmh.3.2019.06.24.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:12:50 -0700 (PDT)
Subject: Re: [PATCH BUGFIX V2] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190622204416.33871-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
Date:   Mon, 24 Jun 2019 10:12:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190622204416.33871-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/19 2:44 PM, Paolo Valente wrote:
> By mistake, there is a '&' instead of a '==' in the definition of the
> macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator with
> the correct one.

A bit worrying that this wasn't caught in testing, as it would have
resulted in _any_ queue being positive for totally seeky?

Anyway, applied.

-- 
Jens Axboe

