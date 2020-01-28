Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE914C0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgA1TNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 14:13:10 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40839 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:13:09 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so7057651ywe.7;
        Tue, 28 Jan 2020 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wKVDbM8dSna8Ek2WmGu0py3hsOW6aws0CcQ8clzPl0=;
        b=Q/F/VGHs771LlF1sjpTuRXeCsaknt7LaVzk9pUl2TOuBLJKDMJjHKjv+kuemKIB4Is
         EnNcCLglXHnJq/BfgID3gmBwQECKvqDtuMWSx6gounOTn7i/dvNewI1n0UXoeEblKkZb
         MxWyBHs52ZcrpWAcYodUux65b0Vo5J6N9bOpgsZOfSg4Qwp4p4M83iNvC5R63iMxjQCK
         pZUiI8Yja10ywMtKlCnw/Q3HU7ViguP3DkZnQGSwwtWUePT8sA5I3Fpeo6UJ6oUYAIVt
         GqQ+QXszEh/kuz/FXkWoCY53rkL4IJhNwairL+Tji8xHQoZ221t2GWlUXCUcQyAZsNGG
         PFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wKVDbM8dSna8Ek2WmGu0py3hsOW6aws0CcQ8clzPl0=;
        b=RUhMSBlJmp8d6Iku5Rsq3zlBQiLenfNGMl0TuVuRumAad/G+q45fYScE2LjcZdkZmM
         s0Debtk30bBdJuoCIXUhIecZPWjRbQkh5uE8U6nYLfhzxzvBSO/Kb70f98O9rn/VrAll
         R6qPEe1qFjGO9YCP4kOp5poaD4J/Za9Wq+Bxj87Yt58YgZjfinAM2k3c8mhqCWFngSyp
         +v2AxhM7eekxxy1inCpu4jQFY4+RemivS8znho1Dw7zj/05xyOZmG0r6nx0q0GneHH87
         QKHxVgXI/ZSUTvtseVETt69fT5fgccbWMB5113TnU1zaVA7DPSnDQM/duTu1zlG7FtfB
         tmGA==
X-Gm-Message-State: APjAAAXhA5O953bf+mNvvvupXUoUWn0VUswaqt67jlZNfgLShzx8TswN
        9b8FOYyOSLW8yoCZiT8OgRs=
X-Google-Smtp-Source: APXvYqza0X/mYL4koOr7/goYIqRMeCTiHeRZYJxKgArDvNT+gdKCvpmjm3KyIxsxUHv0uaUooVE3hQ==
X-Received: by 2002:a81:3d42:: with SMTP id k63mr16490295ywa.366.1580238788668;
        Tue, 28 Jan 2020 11:13:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g65sm8473961ywd.109.2020.01.28.11.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 11:13:08 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:13:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Jones <michael-a1.jones@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, robh+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of
 MFR_COMMON definitions.
Message-ID: <20200128191306.GA32672@roeck-us.net>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
 <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:59:59AM -0700, Mike Jones wrote:
> Change 21537dc driver PMBus polling of MFR_COMMON from bits 5/4 to
> bits 6/5. This fixs a LTC297X family bug where polling always returns
> not busy even when the part is busy. This fixes a LTC388X and
> LTM467X bug where polling used PEND and NOT_IN_TRANS, and BUSY was
> not polled, which can lead to NACKing of commands. LTC388X and
> LTM467X modules now poll BUSY and PEND, increasing reliability by
> eliminating NACKing of commands.
> 
> Signed-off-by: Mike Jones <michael-a1.jones@analog.com>

Fixes: e04d1ce9bbb49 ("hwmon: (ltc2978) Add polling for chips requiring it")

> ---
>  drivers/hwmon/pmbus/ltc2978.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index f01f488..a91ed01 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -82,8 +82,8 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
>  
>  #define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
>  
> -#define LTC_NOT_BUSY			BIT(5)
> -#define LTC_NOT_PENDING			BIT(4)
> +#define LTC_NOT_BUSY			BIT(6)
> +#define LTC_NOT_PENDING			BIT(5)
>  

In ltc_wait_ready(), we have:

	/*
         * LTC3883 does not support LTC_NOT_PENDING, even though
         * the datasheet claims that it does.
         */
        mask = LTC_NOT_BUSY;
        if (data->id != ltc3883)
                mask |= LTC_NOT_PENDING;

The semantics of this code is now different: It means that on
LTC3883 only bit 6 is checked; previously, it was bit 5. I agree
that the above change makes sense, but it doesn't seem correct
to drop the check for bit 5 on LTC3883. Maybe remove the if() above
and always check for bit 5 and 6 ? Or should bit 4 be checked
on parts other than LTC3883 ?

#define LTC_NOT_TRANSITIONING		BIT(4)
...
        mask = LTC_NOT_BUSY | LTC_NOT_PENDING;
        if (data->id != ltc3883)
                mask |= LTC_NOT_TRANSITIONING;

Thanks,
Guenter
