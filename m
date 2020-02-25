Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9116BBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 09:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgBYIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 03:37:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43989 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgBYIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:37:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so6785259pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lesurzoUvSvfZ2EeEsmnXSXZFaFQRXcHJcV4OzRZYOs=;
        b=DCYfGreFPdhhVUKXFmeqvJ7SEwhie4HjOFGZRNvYH5SHGiV2hNKnZM5LLgrSEwuNK7
         ETetaQ1oMfVmaw3i9vzZIH/dJHU/aNeO2l1wNQw3Jk0AI7ENyeR5T7UPFpZ78lCsi/mv
         kgwfnufCzk/jHU/WRhl1aJXX8MoSfanEuNzEWfq6le+2X32btUn47Uln8Dc0XD0ZbgEJ
         RBVbcCdYViUIjt0SAfo8x3VSPfsgeOQzZ3YlESmTJ0yAIE2HbOtkc5SEViXCsGYjH40X
         Zniy5FQ2dnfIFvKYiV9vPy5iyjHXhmpX6OMC/q3DWm0AjGtMNhDEpxP9Nu4SWi6NCbn2
         1IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lesurzoUvSvfZ2EeEsmnXSXZFaFQRXcHJcV4OzRZYOs=;
        b=lwJ1QFSBx69UOv/ccGPVvoiKkPBR56m4/Oa6OkxMIRh8GiW34b1mnJnvxauQhbcBkw
         vfAN6Sv5nXKHbPf+k7ySAeCtsgwIPo3nyNxSiFrkgmJh+h8WB7MtIDhwZSAw1Zxx+ALo
         XamYQDIfgHcLaWCpUh6qkmqHUFsflYEds9l8PPnlKvccu91QkR/pudRs79t8bT/md5T+
         McPkcJriqX8jRQ3hdFSw6b6UKnxytvIdT81jqCOoSshYqxYatOPXG5PcgoHZYc7R8QfY
         vW6Q9dbyBrxc9zjOeAC++iSZBkz3KZ0lIKF6I1htBFepRfnNAEh3sVkfKC3yzZQLnLn/
         ZgNQ==
X-Gm-Message-State: APjAAAXXWBW0C/QEWIiXwptApTtgWqsGbILcdl1c9BUGYfOBuHVi5SQP
        J2kwJE/irASe1+1qxgzm9gx2Yw==
X-Google-Smtp-Source: APXvYqxEIXMkJNt5ttW3aixCV0507Pt6cLR5KGoDAfoWs6jkQMH5M+MdAxhMB11LIwT8PXIuxrhNDA==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr55230760pgh.71.1582619839849;
        Tue, 25 Feb 2020 00:37:19 -0800 (PST)
Received: from ?IPv6:240e:362:421:7f00:524:e1bd:8061:a346? ([240e:362:421:7f00:524:e1bd:8061:a346])
        by smtp.gmail.com with ESMTPSA id c26sm16217660pfj.8.2020.02.25.00.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:37:19 -0800 (PST)
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
To:     "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Ashok Raj <ashok.raj@intel.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200224182201.GA22668@araj-mobl1.jf.intel.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <81c5a532-468c-3316-83d2-b4fa027dbe0e@linaro.org>
Date:   Tue, 25 Feb 2020 16:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224182201.GA22668@araj-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Raj

On 2020/2/25 上午2:22, Raj, Ashok wrote:
> Hi Kenneth,
>
> sorry for waking up late on this patchset.
>
> +
> +static int uacce_fops_open(struct inode *inode, struct file *filep)
> +{
> +	struct uacce_mm *uacce_mm = NULL;
> +	struct uacce_device *uacce;
> +	struct uacce_queue *q;
> +	int ret = 0;
> +
> +	uacce = xa_load(&uacce_xa, iminor(inode));
> +	if (!uacce)
> +		return -ENODEV;
> +
> +	q = kzalloc(sizeof(struct uacce_queue), GFP_KERNEL);
> +	if (!q)
> +		return -ENOMEM;
> +
> +	mutex_lock(&uacce->mm_lock);
> +	uacce_mm = uacce_mm_get(uacce, q, current->mm);
> I think having this at open time is a bit unnatural. Since when a process
> does fork, we do not inherit the PASID. Although it inherits the fd
> but cannot use the mmaped address in the child.
>
> If you move this to the mmap time, its more natural. The child could
> do a mmap() get a new PASID + mmio space to work with the hardware.
>
Thanks for the suggestion.
We will consider fork in the next step, may need some time.

Thanks
