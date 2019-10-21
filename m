Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646DCDEDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJUNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:35:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51512 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:35:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so6190876wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PSOEOmMln8E+JJRVFy7GPNgUKtrrqbgaTaGl5CCcN0E=;
        b=AULSHFQ+UDP3lc9ZV8CiTvloCNo2njKys1MLrEDDzwQE/3k6sYoehcCZn/FSp51MUz
         BI6A/ODfsBUTYmAsiJwDi9WvQ2mr/gTK6PLDUSIyB0H/XjTNtfHC9sQFqdotNC+VtznU
         EN5ZS7mM4+35l/YIr0T8SokVWFgmbcigY8c9PdWiwIOTRevJBi9AVdoYA8V72cz04xWy
         0Wm8vWzI8wuGNQMssbTGn3g0F8S7NOkqFBALRypah58WwPXzn65E17tBWg31U7vFHdPL
         5faOYT9ABjhsui8b2+Qu8z0ggiXLGBl3O9EUDct8rDz4kDKP127eYVnuO0vlxPErwyV5
         UPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PSOEOmMln8E+JJRVFy7GPNgUKtrrqbgaTaGl5CCcN0E=;
        b=Zqj2WdmdmMKoUW4xvwvgdd8VEKCX90BR+1Lm0NmzgPpFJNopg7p8ShRO9wdIg6kkci
         qn88sjcPQBVVp7vicAX9ttUfQ0LGXRcoIEeel2HjPfzApIy1TF95tTVh7sbsHs6kK7IQ
         RNvTImGa0Huanf+u9MSG8f45H2/EWdAjaW8MmRdGoBN9yhsuTxP0nnJybTEBmxPe5A9I
         kSDyhj7L0YYslGk7VMTFBCtnt2WcD2lgRw4XjBdgXWWZOa/TMzXQ12XR1hJgO7w9+hqy
         UkJS0wPFJknr0ZXrbK0rg574t/OsaPHTltvcIyDOqx7wx/HyVkLZFhGo8WOX6h9zFFz/
         TBMA==
X-Gm-Message-State: APjAAAXOZsHMPf/q/+HtQBJb6eTKTpX1GABwhNPonsFpUZfFYBsH9+8i
        /p9cPk/ux/4kicwyqLfZSlQvOg==
X-Google-Smtp-Source: APXvYqyLilmBsuFakkLGBdUeLaUco79LtHGMIl+KiWY52hD/AAX8wFqqh5+QVIPOhsVpe3bHUSlKtQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr13674573wmc.157.1571664898314;
        Mon, 21 Oct 2019 06:34:58 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id f83sm14776425wmf.43.2019.10.21.06.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 06:34:57 -0700 (PDT)
Date:   Mon, 21 Oct 2019 15:34:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Kenneth Lee <Kenneth-Lee-2012@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v6 1/3] uacce: Add documents for uacce
Message-ID: <20191021133455.GC117664@lophozonia>
References: <1571214873-27359-1-git-send-email-zhangfei.gao@linaro.org>
 <1571214873-27359-2-git-send-email-zhangfei.gao@linaro.org>
 <20191016183638.GB1533448@lophozonia>
 <5da81d06.1c69fb81.395d6.c080SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5da81d06.1c69fb81.395d6.c080SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenneth,

On Thu, Oct 17, 2019 at 03:49:07PM +0800, Kenneth Lee wrote:
> Dear Jean,
> 
> Please let me answer your question about why we build another subsystem
> other than use vfio-mdev.
> 
> I think you might remember that we did build WarpDrive on top of
> vfio-mdev from the very beginning.

Right thanks for reminding me, I had forgotten about the first RFCs.

> Both RFCv1, Share Parent IOMMU mdev, and the RFCv2, Share Domain mdev,
> are based on mdev. We got many comments and we finally felt we could not
> solve all of them if we continued the mdev directory.
> 
> I think the key problem here is that mdev is a virtual *device*. So, 
> 
> 1. As you have said, this creates more logic which is useless for
>    accelerator. For example, it gives the user the full control of DMA
>    and irq, it replays the dma mapping for new attach device and it
>    create VFIO IOMMU drivers... These are necessary to simulate a raw
>    device to a virtual machine. But it is not necessary to an
>    accelerator.
> 
> 2. You are forced to separate the resource to a device before use it.
>    And if the user process crash, we need extra facility to put it back
>    to the resource pool.

I don't understand the difference between vfio-mdev and uacce in this
context. An example may help. If you want to give direct access of a bit
of hardware to userspace, you necessarily need to isolate any resource
associated to that partition from other processes and from the kernel.
Namely create a DMA address space (SVA or AUXD), allocate an MMIO frame
and an interrupt (although IRQs are still handled by the kernel and could
be shared). And then you need to release those resources back into the
pool when the process exits or crashes.

> 3. Though Alex Williamson argues that vfio is not just used for
>    virtualisation. But it is indeed used only by virtualisation for the
>    time being.

There is DPDK, that implements userspace drivers for net and crypto using
vfio-pci, and will likely gain support for vfio-mdev soon. However
similarly to Qemu they are self-contained and can easily deal with the
fork problem, unlike a decompression library for example, that could be
included by any application.

In any case I agree with your point 1. that a simpler user interface might
be beneficial. Perhaps DPDK could support uacce as well later.

Thanks,
Jean

>    And Jerome Glisse （also from Redhat) said he could
>    accept some problem from a virtual machine because we can constrain
>    the behavior of virtual machine program (such as qemu) . But he could
>    not accept that happened in an general application. For example, if
>    you pin the memory in a process and then fork, you may lost the
>    physical page due to COW. We can solve the problem in uacce by
>    letting go the shared pages in the child.
> 
> So we think we should not continue the mdev direction for uacce. Even we
> can merge the logic together. It we become a burden for both vfio and
> uacce. Both of them make use of IOMMU, so of course they will have some
> code similar. But they go to different direction. VFIO is trying to
> export virtual DMA and irq to the user space. While uacce is trying to
> let the accelerator share address with the process itself. Many tricks
> can be made between the final user interface and the address translation
> framework. Merge them together will not be good to both of them. 
> 
> Hope this answer some of your question.
> 
> Cheers:)
