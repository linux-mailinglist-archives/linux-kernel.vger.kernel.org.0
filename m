Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839278C054
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfHMSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 14:17:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40777 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfHMSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:17:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so373146wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EPkqHFTT1KvxgsaHnKLv7VXPezcT4eKkPTs4jCtFfDM=;
        b=IZr+C1IzDl55t6GTa2m5J043jUJjCECxfdNp4mzjhSWfxcBwii/qZ0rxBDRHviGetc
         vPhWnCIpy/GOrFojZXDQB4CEG5UAaUJubJCrynkow/sMK/FSUC0SKDxJeTvazGezY5Z6
         aCVmUkUD36h5qNQJ+sXABBJHsUBLceges1UNXbeURj4Uc9Oy3P5JmU/xwk3uQENa7RIj
         AiAsBOefbWNRoty29pYp8bRktkiCUo0UnmLxt/k+qHLys8iXeUqIDB46oo3tSaLNpnru
         SOa4UVLzZJ1tMC6Lu0LocylCkVpSt+tPuAe3qhWPBHv30A4V45nnQ1t7Bch8JVPdzT0X
         C9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPkqHFTT1KvxgsaHnKLv7VXPezcT4eKkPTs4jCtFfDM=;
        b=mu01J6ehrOOo0x5DS4Q8ufjcuKR1ebY1M+ocgbwn9KPYj5P3EWeeoX1tMeDC8v7tg/
         2ydEIbQdLzIZtr6JBdl4ZXYdhRRrF8qSZZ7V/K/mOKMikvvsNnF5G8LmrnTog4UxC9v4
         1WlsrYFOCv9A8cS7QWmjy03n9wU1iCIjr11++YRRxnlWd/ckwIva5O7bth56+t70aOZe
         QcmJxgqP3Yfx9mztkqJkpCM4enKS28uufzqPPep2ALxJvknpHKiRdp+osALsMvx6ix1Y
         1YpnS8s/rERYoxIIDJWoIIkOkfzBhD8pQndculswrLap3WkbRJxGwdoZ6Sv5i0o6Klgy
         zf8w==
X-Gm-Message-State: APjAAAVJIx49/TYtfVur4GqvBReAi2a3bU6M5BzaOU+6b1l4Jn9OCLAs
        /LgaMliLh27z6RCBp/Ntfuz/yw==
X-Google-Smtp-Source: APXvYqxmRERDkAw8Vs6MjMd4K+FOgvlYItlA7RSbC053dvmaYrmvTDCtWuRg32Fud5EUiR4kYm0DYw==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr47193038wrx.175.1565720232097;
        Tue, 13 Aug 2019 11:17:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c6sm3191349wma.25.2019.08.13.11.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:17:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
 <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
Date:   Tue, 13 Aug 2019 19:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 15:34, Pierre-Louis Bossart wrote:
> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>> From: Vinod Koul <vkoul@kernel.org>
>>
>> This callback allows masters to compute the bus parameters required.
> 
> This looks like a partial use of the patch ('soundwire: Add Intel 
> resource management algorithm')? see comments below
> 

Yes it duplicate indeed!

I will use that patch!

--srini
