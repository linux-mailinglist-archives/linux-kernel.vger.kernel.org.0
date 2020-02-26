Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5014F16F4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 02:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgBZBLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 20:11:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41434 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgBZBLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:11:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so514181pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p+ckrLz3LRCoSFrfiU30gmbNyc8j6wjK1s1RA2TWajk=;
        b=o80oA2wwqENPftna7/zKRVKoL3DudW8CJuoNGJhKQurPflg4m7wY+s5rdqW1b+zdpW
         LoZWVXYuj2kyYWbb2fGxrBwXJpDzoAR7jwOjWCAh/sMSzynLVtPA7Jitj9iy3uJZeokJ
         BVZn+tnxjRxDXBaXScRBqhEb0zR8BnO6rSER1IyfwRTrfcHXbJ8p3T+zM9czSbbr4SMo
         0F5uag648+xMEEUTw6hyV+t66j69cLVziSXZ+qdsWweHC2VOPCrXrEGbUo6GZYMxVzvY
         aUIj/DiaWh8dZVW91xEsFwPIn1D4mAJUmGxxLjyYMHaRlpQYDeUO5fPrKkyqgjV55xXz
         l9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p+ckrLz3LRCoSFrfiU30gmbNyc8j6wjK1s1RA2TWajk=;
        b=OfRr5ccerwSkusm7TYof0chvhqPM+HC9qIIMKiEtM9YAEGBml54D/6G0C54NweXj8h
         AqFbaJzGLOq9njA4kK1uPnpJmiaKtz3ayewUmGuHrigIEUtVJRWn+e+0Ida2JWdBfVLo
         Gltca1Fo/hKeKgSJuQmoHbEESradXDocew8KI6BoW24+YXMQEtUk5XYq4joZ7sdH2nUX
         gr9oh/KkTxDhawgVp3E4PG+R9TlitDMbGL/VpH1LrzxTDNmZOh0PDHburrn5tLDWWl/Q
         CPhz2gvXp1C3jh5DKyAAQvmR8SZRx2SHmt0oR30NAX5T9nEZ6HpbdVcJEm+Glj68y8Ay
         TAlA==
X-Gm-Message-State: APjAAAXx7gh9yY38JtDP0iUpJ0ZC/2OaglFtpT5u+whDl3P124Sx/mjQ
        QHsjI3duMTX8Cmeb4FRaepgYvg==
X-Google-Smtp-Source: APXvYqwBrVhiEx4l0romklhpTH+y+CgXMko1VU+ZOxfZOJLkAj7ZLDO3KH4v0RJodC8aSrvfaOpG6g==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr1501438pfz.26.1582679497101;
        Tue, 25 Feb 2020 17:11:37 -0800 (PST)
Received: from ?IPv6:240e:362:4c3:8800:a057:bb7f:18d7:2e? ([240e:362:4c3:8800:a057:bb7f:18d7:2e])
        by smtp.gmail.com with ESMTPSA id z10sm204892pgz.88.2020.02.25.17.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 17:11:36 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add maintainers for uacce
To:     Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org
References: <1582611475-32691-1-git-send-email-zhangfei.gao@linaro.org>
 <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
Date:   Wed, 26 Feb 2020 09:11:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/26 上午12:02, Dave Jiang wrote:
>
>
> On 2/24/20 11:17 PM, Zhangfei Gao wrote:
>> Add Zhangfei Gao and Zhou Wang as maintainers for uacce
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   MAINTAINERS | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 38fe2f3..22e647f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17039,6 +17039,16 @@ W:    http://linuxtv.org
>>   S:    Maintained
>>   F:    drivers/media/pci/tw686x/
>>   +UACCE ACCELERATOR FRAMEWORK
>> +M:    Zhangfei Gao <zhangfei.gao@linaro.org>
>> +M:    Zhou Wang <wangzhou1@hisilicon.com>
>> +S:    Maintained
>> +F:    Documentation/ABI/testing/sysfs-driver-uacce
>> +F:    Documentation/misc-devices/uacce.rst
>> +F:    drivers/misc/uacce/
>> +F:    include/linux/uacce.h
>> +F:    include/uapi/misc/uacce/
>
> Mailing list for patch submission?
> +L: linux-accelerators@lists.ozlabs.org ?

Thanks Dave

How about adding both
linux-accelerators@lists.ozlabs.org
linux-kernel@vger.kernel.org
Since the patches will go to misc tree.

Thanks
