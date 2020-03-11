Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F5182207
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCKTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:17:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43051 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:17:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id dc19so4241599edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IoGQYT+rchnYF2zG5DEg3NeiNAoLKHCeyEY/yuvUhRg=;
        b=Qty98XX/5cZd1xLOpIdrTlHmSOxWrvAJPpba33iF+RhyOUDdezy7/AvSYh58mnyJK6
         UjTrcRQsHNLdkJSG4Rw3egxSyRm+NO5u/ziM5sEJ4syzSi/ofv//CVi/NySuuemFXjvN
         ZeoLd5zBi2yI+dJQt1ARKHz//BShoSnycvkQPPAa0mD1VCftEOwQPOKdsBjzXtMib2am
         BCC6ytK1fgh3Zw+e4CK/xxJ4RSHoAl0xoSWbEHV74NfcywU4Sr8i4XQ/fpmXYceMyRQA
         DMasFvXlCVaYwJH6VlOT0huN4mo+9H8IzPTNwLw8MkGeLZ+H01zkXm4mEPrOf4DnyaJj
         BcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IoGQYT+rchnYF2zG5DEg3NeiNAoLKHCeyEY/yuvUhRg=;
        b=chXamRYPlWeZgldlQGzk4uYP8aJNa6RiFXU/dsYXxAvFsntuA8joGSiGqoh5cbl+zw
         jVMqA4wvogl1lxBYsihaBgs5E2HmG7WwKo8+8byIql7/1a+m5S304hsAHF03ncHyjYoc
         UtsWbW9N1yc5B/uS4phFKrFq8imrYJonkLun+Sr4xYCQNWv+u1yIMp1po5u6Y9wHa6MA
         r1AgHWINLozYB6yDJj8vnsUMrucy7URiyFaRHy39tDiJhblBS3sVzwjCDeHEtinQRZF5
         d5F3Ei+pN7rThHf40deZWgmtkiIGH2tBKQhsbj9TssqfQySvrtsUbRvv9Zm71C4O5d49
         nUkg==
X-Gm-Message-State: ANhLgQ3Pho9/UiC6pks0fn0IHGteBZcH/HdHYdmINNuIyItf33rKcsCh
        RUl9aO/Q9Oysv/YN9KPG95HAgQ==
X-Google-Smtp-Source: ADFU+vvqObpUv4yT5hu9m1ZZe/ETe+eJynYIwhQ0IE0wZjybZQc/WQoS5nOBi4wA7jf1jEJxVN6wFw==
X-Received: by 2002:a50:ed97:: with SMTP id h23mr3364514edr.197.1583954252557;
        Wed, 11 Mar 2020 12:17:32 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k11sm482932ejr.92.2020.03.11.12.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 12:17:31 -0700 (PDT)
Subject: Re: [RESEND][PATCH v8 1/6] usb: dwc3: Registering a role switch in
 the DRD code.
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200311172109.45134-1-john.stultz@linaro.org>
 <20200311172109.45134-2-john.stultz@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <7337bea7-1449-e6e3-4c65-1bb802a2c316@linaro.org>
Date:   Wed, 11 Mar 2020 19:17:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311172109.45134-2-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)

@bjorn found an API change that explodes this one.

Fixed here: https://lkml.org/lkml/2020/3/11/1034
