Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB9C96B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJCCcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 22:32:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35938 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfJCCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:32:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so795330pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K19dUfKMeY8BLXEsXBk6OU/EHlaRxwCl2aUwG6ZXU0o=;
        b=RXesFoYn7HN9To3yjNAdE8us7kMG9/9UJ7QKwCLlNr2HY6CVA2Y9UhrIA9zp3N7dAI
         RD5+HU6tgVFehQV5nDtR68jv0DJuqxXNQp6z6jX8TjRhsync8EJilwihK0X7aZgft4tf
         XI41J68VewsYeOtOzs/g1pNjCKcKZYQKMC+UFx7HS6X99jKuxm6DEOUHho0qoTjdQ43J
         4im4CMYhnYCFUhJe03JnH9IGY+HNv2o1bPB2NDPTKfW9WrxhF3awJcdc7I+sr4TFHM9L
         fGGuz+3kX+V5w7zZqRK7lRU4sKBoWEpeT40XjZ3HZIvORfj5pXwEKzPn0qi5qM1DfBT7
         l0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K19dUfKMeY8BLXEsXBk6OU/EHlaRxwCl2aUwG6ZXU0o=;
        b=tH9XJ0UC3jH2X89JSztOibzCajX9i4IG47AA5qiEw2jfrz9EzyyGg9oUkv7Tu+5SLg
         gFma46aqZUZAqDWkhcVhAfFjTRkLxP3lowJ2cgZ3tjaw/y+t1dCiZf0xtPZ8TRcMj/vz
         al0wXawrE0VIu3kRYC271Lp4wV1fRK/ItWZd9StfLAfWrx9ziC93A36zIL9Xh9QeiZiD
         vZx1NO2Y4HgJY5pr70nEpIG+BmSUaYbjj3BhorguSq+yLmxtorRGyxnnN71Ni/B9aW+v
         yZRu3hZzWPq4zj074v/6FhPKLY0QxNC78RU3AqcCUaFyp3P5uWc/oNUvmv7P2Jkj/GfN
         gDKg==
X-Gm-Message-State: APjAAAUHV9/y7xZT4LiQ9B9/kV3WuliNrxTIg6XwdgwJWaFmMinW4bJl
        jkppX5DathIb7r99yG8sHwHVwz5kVoBIvw==
X-Google-Smtp-Source: APXvYqzVsD7R/zMAePisZn0a9vUIXisxTGyyA+gIBLXagTz6/76dGMuqRiU6CxCmZi5V3UzC9JIBnA==
X-Received: by 2002:a63:e444:: with SMTP id i4mr7151634pgk.45.1570069970102;
        Wed, 02 Oct 2019 19:32:50 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 69sm755865pfb.145.2019.10.02.19.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 19:32:49 -0700 (PDT)
Subject: Re: [PATCH] block: pg: add header include guard
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190720120526.7722-1-yamada.masahiro@socionext.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef3a7522-4753-33c6-6611-e48a2f641bfa@kernel.dk>
Date:   Wed, 2 Oct 2019 20:32:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190720120526.7722-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/19 6:05 AM, Masahiro Yamada wrote:
> Add a header include guard just in case.

Applied, thanks.

-- 
Jens Axboe

