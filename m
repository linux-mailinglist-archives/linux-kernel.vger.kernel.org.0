Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBE1598EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgBKSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 13:44:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36087 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgBKSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:44:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so12813793ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0RiGxD598VNdYRw7xmS/5EVhHzz6Ia1q5/DbEyGlgg=;
        b=Peg+EZisEXYABEG3l5R11Ckp1h2TIHD5m5gaWrN4FTdFU/HM704QIQjWyBCW+sKJHm
         TBwrHBxnRi9ykqRhuz6fggtR+GToy1ZdOYJGJ6EiqCUOwXPQ4HxQrOMw58KHNljyfUW0
         OX2DGoRuPaL6yR99d8kVppOVrDyjnE0berQWpLdhSb0K1BZymPluwhOiAvd8KJfy9QNw
         mDZiL8svakmQsQsrVsYVxJtMT2u7Ek6+ZXBPXqy1e7tkXG+yHtUyWterKNF6tUmj11xz
         KARQ4strqt7f56f+/CQuK1Ms/VdxyEA3KzU8eKUxmBgaKcM/kEHF6ABRMmJ4fo7s8Pht
         7w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X0RiGxD598VNdYRw7xmS/5EVhHzz6Ia1q5/DbEyGlgg=;
        b=OFyVyhvX+CYueI/+cI/+bg0m4FpQRzol7UiIBOc9ESHNqW9qEkdXAr44ZTTnVb3kJh
         9PycsOpP3ozXAbpoVvANU9DKZ+JPjuhJC6Wt5LuuNbDNBa5VW0Fc8MoUo7B0UrGBTUWo
         9TCqCVn/uTe6vaDX+sKsdQ5J55nF+E7phG/jYIR6PWZUFovFNt5/PK1z8haJIWmjMxiR
         KKXLNbGBZweHF4BhymFdmPN0IRiCe3W7RRK4xfqLIbiCQY9X+tAu7VSWv2qrdo/dOoEO
         IV6cxKQw3FpwTrEkruQAlRiMHs8QI5WFgLdIeBGMJUaABw2K20pcDeKpmUItYAD8uyah
         u0eQ==
X-Gm-Message-State: APjAAAVtuo38hDpz8b8w045u0uTEJ94vWHWj979JscbklFoZfzroCTjU
        mJa4i8uzIjX+mOyQQfH1X98AbASoNko=
X-Google-Smtp-Source: APXvYqw/C3WPKtObJplZ3qp0y3V2KAttt0bItnHGRKkAJLc0CGkZu91ZarSc4OfnExn5g7Nl1yxJGg==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr5173671ljj.4.1581446645116;
        Tue, 11 Feb 2020 10:44:05 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42b3:6bcd:dba3:6f3d:48fb:be1c])
        by smtp.gmail.com with ESMTPSA id n8sm1937902lfi.83.2020.02.11.10.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 10:44:04 -0800 (PST)
Subject: Re: [PATCH v2 23/34] crypto: ccree - remove bogus kerneldoc markers
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-crypto@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200211181928.15178-1-geert+renesas@glider.be>
 <20200211181928.15178-24-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9e74ef25-90d9-0340-4e5f-07ff4d8c3fa3@cogentembedded.com>
Date:   Tue, 11 Feb 2020 21:44:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200211181928.15178-24-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/11/2020 09:19 PM, Geert Uytterhoeven wrote:

> Normal comments should start with "/*".
> "/**" is reserver for kerneldoc.

   Reserved for kernel-doc, perhaps?

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei

