Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7583337
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfHFNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 09:45:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHFNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:45:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so41547241pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQh9z74ag+GmRjLxDeaQAgLw1V8J9pK1FZmm6doK+q0=;
        b=tiSelzTk8mWTlpoVBYaXILHfHlswQ+XRiZj0Grsrvlq2dZ9vBXV6QYwMDfzYVxWxdX
         T/sAQpQ6cK5tDefmfWEBYxAC/XqM2IHN8J6B3osQqPeIsIOSf1w0RDjhyB56jsKtkfoZ
         Fdtm+r1y+/dlnUJI2I55JepBmMRpkBWhpSu2oyibbNLC88OAlXtrwqZMDwzlVnWxkQRa
         V0AJnSAoOhb2vsOYj5ZpBaeMt0OfK8rJ2ohVGatcnnFvSHs+bpYWCHrtDGpBiAaMQ3+Q
         dTjxOBFj8mJxSbAUSTePGKwVfocf9LonuuN0vZI0+HgsW1qTC4jBA7NDLadzOF74BHdF
         g7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQh9z74ag+GmRjLxDeaQAgLw1V8J9pK1FZmm6doK+q0=;
        b=qqkPGOccyl2wIbslJcQbMBVGS/fSCb4ZTZjDa8RRMQBuOpw8max4fb0DJTvIgMlBuL
         b/fLrJmwnOSRniHpEnqjyKLasjaBNVuDvi/3YLYScfav7CnhwER1I2zoJomuJlQHfGNg
         Kj5XF0fN87SjWMU8qcOqiZOpQQnAlRVoJGZtkiF/tXmeNj8+Y4SDhR7SLhGbYkMrhpTl
         uVJ6xDgIBWdi2rjR7HuauCQr3XIqNwoVu+L9xfhP3UJCsdjmL5Hvg3MK9tkIjh/9gq5l
         g2cHU4QlPxGnDue/xOOBNl1IBzlw68+vieaFpjllzIRun8hXnnhIufaNCvjqu2JgrF7h
         DXdA==
X-Gm-Message-State: APjAAAUOSILb4CUx00tXzon/IZYH+dh6YysI49NZ2VD/Nr/1TPY4/anv
        GHr0eWf7s3EYI3hUfoe6fR657YFm8mrQ4w==
X-Google-Smtp-Source: APXvYqzq54EhLaujd1/sIZml45bFnQlidzBA9hT0AAdIzhGvcT8uYyfa+uY4esbkhztXp9A71Qs9fQ==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr3284927pju.63.1565099119117;
        Tue, 06 Aug 2019 06:45:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:5cfb:b4eb:1062:5bea? ([2605:e000:100e:83a1:5cfb:b4eb:1062:5bea])
        by smtp.gmail.com with ESMTPSA id a3sm22023266pje.3.2019.08.06.06.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:45:18 -0700 (PDT)
Subject: Re: [PATCH] ata: rb532_cf: Fix unused variable warning in
 rb532_pata_driver_probe
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190806080808.GA30026@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a80a74ae-ab49-7f58-a4f3-8bd3b3012716@kernel.dk>
Date:   Tue, 6 Aug 2019 06:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806080808.GA30026@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 1:08 AM, Gustavo A. R. Silva wrote:
> Fix the following warning (Building: rb532_defconfig mips):
> 
> drivers/ata/pata_rb532_cf.c: In function ‘rb532_pata_driver_remove’:
> drivers/ata/pata_rb532_cf.c:161:24: warning: unused variable ‘info’ [-Wunused-variable]
>    struct rb532_cf_info *info = ah->private_data;
>                          ^~~~

Applied, thanks.

-- 
Jens Axboe

