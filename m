Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA1129698
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLWNnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 08:43:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39203 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLWNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:43:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so9211070pfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wVTAxAkLybU/XzL/opvLLffdVLtU7bgXnpcg4bd91o4=;
        b=Y6kMDUZyIpXUhY/6S6BGldJrLa3Be3lQw1aP1BG6W+6jpQs0H94u4738rszDgOEhev
         yj1YEU5Dhi+0a5z+R8dlTKCFEuU7NWGPTiCqZMIE80senDFfhVqi6pcyZbipej4nkQ1d
         V6tESjmrSWYreiBea6tmcV267sBT5fNb09WlZ1BUoaTGrqGyrgi8V+t4P7pGb2ZnYemn
         JQiamP8GzVdx2hTRs/mV/QNsjP6r2E86kVtm2jS0pSsqEyoL0hwlTM8OUhoWzQLioUq1
         qo3tKYhZjjwuv5Wwu/PXS8Oo+fqbuCWVUjnmzjEaSEIUUYY3m7TB7K6FLeQseWDqYeP9
         DSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wVTAxAkLybU/XzL/opvLLffdVLtU7bgXnpcg4bd91o4=;
        b=DfoT6asEq7LY4ia5ixTJfqy0/O+SvWM0enIk8lqyUxKSwHvAMYG1AHUWzp56fUJTX2
         zq72D0JVsmnQBqWazNXDh4NQ+h1fFEXeHgbFjhcFUgmMEAamHe+qghDQQ9bmF0Hlq+Kl
         m5oxjnnqn1FUPBe/8/8qjAMegHq0gB2abHhyEIkBCuQeRUsAZfolpxi/k4iyu9rxnie1
         ZamgO/qqSBlpM0UF793wz/jpgQnc7I/yZKE1uFEfeFf3ojslTTbsexvujEBPSOPZidQ2
         QdziXcFa0j1ryHuZ9MeCpmGJAQYr1Z/nuJjwsjMHXo98+ugKuuPgTRy0EN0DZkazVf7d
         QXUA==
X-Gm-Message-State: APjAAAXILw1NLv7aDXP3DTOMKEb+deANNdGbX1/Ol2DcJeWn4fudvnNC
        M2QQpF2ze8f5S04ckli6VQ3Lnw==
X-Google-Smtp-Source: APXvYqwmupBlYBUO32XRngGKnjqX9G8UnI7c7rx2T5XTS3rPO/gmjyWX42Do7N5EQcg90Wl/OdkwDQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr30692540pgd.135.1577108580760;
        Mon, 23 Dec 2019 05:43:00 -0800 (PST)
Received: from [192.168.11.202] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id z4sm21121512pjn.29.2019.12.23.05.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 05:43:00 -0800 (PST)
Subject: Re: [PATCH v10 0/4] Add uacce module for Accelerator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0e7f16b7-938b-402a-e3e3-2a0bed6fb708@linaro.org>
Date:   Mon, 23 Dec 2019 21:41:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2019/12/16 上午11:08, Zhangfei Gao wrote:
> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
> provide Shared Virtual Addressing (SVA) between accelerators and processes.
> So accelerator can access any data structure of the main cpu.
> This differs from the data sharing between cpu and io device, which share
> data content rather than address.
> Because of unified address, hardware and user space of process can share
> the same virtual address in the communication.
>
> Uacce is intended to be used with Jean Philippe Brucker's SVA
> patchset[1], which enables IO side page fault and PASID support.
> We have keep verifying with Jean's sva patchset [2]
> We also keep verifying with Eric's SMMUv3 Nested Stage patches [3]
>
> This series and related zip & qm driver
> https://github.com/Linaro/linux-kernel-warpdrive/tree/v5.5-rc1-uacce-v10
>
> The library and user application:
> https://github.com/Linaro/warpdrive/tree/wdprd-upstream-v10
>
> References:
> [1] http://jpbrucker.net/sva/
> [2] http://jpbrucker.net/git/linux/log/?h=sva/zip-devel
> [3] https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9
>
> Change History:
> v10:
> Modify the include header to fix kbuild test erorr in other arch.
>
>
> Kenneth Lee (2):
>    uacce: Add documents for uacce
>    uacce: add uacce driver
>
> Zhangfei Gao (2):
>    crypto: hisilicon - Remove module_param uacce_mode
>    crypto: hisilicon - register zip engine to uacce
>
>

Would you mind take a look at the patch set?

The patches are also used for verifying the sva feature.
https://lore.kernel.org/linux-iommu/20191219163033.2608177-1-jean-philippe@linaro.org/

Thanks
