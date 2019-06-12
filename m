Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1641F74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfFLImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:42:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfFLImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:42:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so3742027wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vy/mEqXU/U3wrsZD2Jkiz7elwZu303ZemKwcaxzfKNE=;
        b=kQwI9QpLQIVMzRxAg2KZ0HhaUR+hVsU47EOuC6kXAUzU3yET5ccoaWu8g8sAwhuqF0
         THhYGXXsDbrq4biwYS1FO89TeA+EST23eNU+EnRab6ZVXDpK0bfbSMq0HGAHey3q4u6k
         QqsDi/DNo9yr2Y8BY6k7QbTomS071661F8cAJBwPulacoTXhhFCNFjbffAWzsuWqr0xJ
         fvvEcA2fvpzmbB9YvSlnrN7UUym+7rT7R07QX9f2V9AfPB4JTQAvvIn3n/8WT3QvYwCH
         vBrZmZtJTJmgNgYRY9eSiaW131ZuLI/jrgtpcjNnrLwkSeAcAzrcpxaQ+x4Lw06d0gSz
         kMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vy/mEqXU/U3wrsZD2Jkiz7elwZu303ZemKwcaxzfKNE=;
        b=UbOwdP8rPUzomnEFtcK6/5t0Y7FVcH+wHo67g0+CvA/SrCz3uicjfqy7ahWr3edlOQ
         e9Rz/wJHEUIjAWN+8Cwa4GkHKPMBePod4Ns5BKLgwpkdSpyfzS02m0yiOOfLhxSypPJ4
         FTfHnUpNwbPcz9NiBiRM6uTVw8GfvJkskkS/PPpnAekXGl03SSMP6JkfbX1NLOwGRQKF
         0p9ahvzKFt6CYTpM9p3T4XDLkpzYrP8CzwSqiOz6e9Ps+BjaqeSE6O9IE35pMtJBtdpV
         vENvhx5fdT9v5o2ze4h1NLf7HTpjy452TZ+cH576Vi6mjDME+latUDYY8mbiIOPPRJYA
         qwKA==
X-Gm-Message-State: APjAAAUlw7cZS+1ITmugme2gt/DqnIF2bGI6j+sdHpIFd59O8k3DbkLh
        fXIKh4YaAtnctujtSwVZWi1Vpw==
X-Google-Smtp-Source: APXvYqzi/I2WoVwZfkLjbykWRV0LWKhr9BIfOxagRzC9h79bGL0UiupB8mBqM6ygP1BDqtGAyarcuQ==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr20340723wma.175.1560328968062;
        Wed, 12 Jun 2019 01:42:48 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id s8sm27496285wra.55.2019.06.12.01.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:42:47 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:42:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: common: cros_ec_sensors: support protocol v3
 message
Message-ID: <20190612084243.GC4797@dell>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
 <b619ce4f7f2d10ce1ede2b99d7262828f5b24952.1558601329.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b619ce4f7f2d10ce1ede2b99d7262828f5b24952.1558601329.git.fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Fabien Lahoudere wrote:

> Version 3 of the EC protocol provides min and max frequencies and fifo
> size for EC sensors.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 83 ++++++++++++++++++-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +
>  include/linux/mfd/cros_ec_commands.h          | 21 +++++

There have been many changes to this file recently.  We will have to
co-ordinate the merge.

But for now:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
