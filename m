Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3E16BBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBYIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 03:34:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44219 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:34:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so5181046plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EIG5peTBvtZ2crp8lRotOHODI8wwfFW0u8sMOW/L1sk=;
        b=QszlcDQTF2Q2LkffTbIRI3lryFDMXd0PvmTxvgXjQgWVs4b+u9xfRQUq/q2qapPqNX
         6fOPzA5/MBsQgoclTc8R1RazJoG0IS7T8sos5KrxMx5nBAW3g4033Z3oFaDO0Eyvi8m3
         zKy6Qi4OpF8r2sA/VDjAV9GgFmLoehFxHt654aIZejm36g9ICrWPyQKq0Lu15SjcQ4RO
         NPGZbO9dCZs/ib/WPLdzP7z8+gzQOA9Pv/qeO4Gi8PGifICutSTCGxHk0vCYhwwtfgIw
         hrVeyJ9wDt3tGfUHHyS4FZgjozzQzt4g4KuNlUS6KvgJqNGeWsBMVWSXZ+QrBZT3VSJk
         s1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EIG5peTBvtZ2crp8lRotOHODI8wwfFW0u8sMOW/L1sk=;
        b=anrvFW9sss5c3r6OVaxYDkXoQOSED/UezVIg3/XLXqyv6BlH3agPTC1LbAShm61pHh
         Nvr9nNclLgmEPXajH8vNkczb1A96HuduKDp0iKYeyu9uEaDt1CQMnHp9cXLsjdjAy5Vx
         Nv1aUtiiIKPqAi8/qWcKruJxxRGy19q30aa4C/j+2hea+5j/B6ty/ZIhkTH9az5HD0Uv
         3El82EgiHYwO80jPEVPEl0F8dlne7trYdbGTXgnFRDlZCA5uQPzH+16D0ua/7FOZalUH
         Y2Wf4/rM6ZCCvP+p5b+Y6bh0TPBEZaaRcebABhNSrSleWd0+/r8WDdQffrosvKlYGx6L
         G40w==
X-Gm-Message-State: APjAAAWT0pM9vAMFN1WJbHb7fLoTYhNqbPOfGPq+CuFyTfPQiCzs68hD
        qmAQ4ngTruDdgM3MkL5Pfyd5NA==
X-Google-Smtp-Source: APXvYqzAbMNZB07THyLuieZ3+XL0SoHji7KzYKVpxSVKAYezqzD3vcQYoYbTfpEkMi2a8G49muU0DA==
X-Received: by 2002:a17:90a:c084:: with SMTP id o4mr3747200pjs.35.1582619651238;
        Tue, 25 Feb 2020 00:34:11 -0800 (PST)
Received: from ?IPv6:240e:362:421:7f00:524:e1bd:8061:a346? ([240e:362:421:7f00:524:e1bd:8061:a346])
        by smtp.gmail.com with ESMTPSA id f1sm2106681pjq.31.2020.02.25.00.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:34:10 -0800 (PST)
Subject: Re: [PATCH] uacce: unmap remaining mmapping from user space
To:     Xu Zaibo <xuzaibo@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
References: <1582528016-2873-1-git-send-email-zhangfei.gao@linaro.org>
 <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <cf1f7ec2-7181-63fd-598d-b74d5a3efa15@linaro.org>
Date:   Tue, 25 Feb 2020 16:33:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zaibo

On 2020/2/24 下午3:17, Xu Zaibo wrote:
>>   @@ -585,6 +595,13 @@ void uacce_remove(struct uacce_device *uacce)
>>           cdev_device_del(uacce->cdev, &uacce->dev);
>>       xa_erase(&uacce_xa, uacce->dev_id);
>>       put_device(&uacce->dev);
>> +
>> +    /*
>> +     * unmap remainning mapping from user space, preventing user still
>> +     * access the mmaped area while parent device is already removed
>> +     */
>> +    if (uacce->inode)
>> +        unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
> Should we unmap them at the first of 'uacce_remove',  and before 
> 'uacce_put_queue'?
>
We can do this,
Though it does not matter, since user space can not interrupt kernel 
function uacce_remove.

Thanks
