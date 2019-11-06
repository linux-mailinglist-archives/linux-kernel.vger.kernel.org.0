Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1AF10E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfKFISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 03:18:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfKFISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:18:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so18254038pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Pb3J1TnMyrHbEtYv4MyAUzMHiBthQ4b5tWMwPD00Zec=;
        b=IT+wDsKz7eH1XfZbUEBfSiJkvJJy7o9j2aUjeVGwdRRdQgIrbw9jPP/qrGlnq+NvHr
         plrKmujPiZ2FSwPZdTHxNzZTEqv+AsqAyBsq/fn8luoE8b31WL3D/gBKldnz/KduMuDV
         kMwlAul+PWMpsypharNu1EbIz115+4jcLs4iOHFDd6taKUReevyVLAduuSu/ROg98q3R
         maATSw8Lf3REgICYZa8J4rKBb86B1mgNMdLGIBPRc+8P7mkix2sHN/nnouuVqfsMf03Q
         uWkHCakL6d7lMkHn/+uFerKz2vmVjDKld1x9hCJBwnKVa7hN4wTfeRTE7mCef4XU5u/Y
         5qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pb3J1TnMyrHbEtYv4MyAUzMHiBthQ4b5tWMwPD00Zec=;
        b=Z7qVfuYSl4BQJ2Um6Ggp4OlBb0kEH0vks+Qrcvn3xVcvbWzqsCDq1gywNfKWz77jy3
         Nt45ub39rSGrFIfyerBiqExO7IVADQgwxNnZdzo1+RRCO0Si0AeuTp0yMkAUNaT7Fd3o
         qv7mmW73Kr3NS6ttLtPGiAFrcErhU0pmXRW//lq5hshnCzCYkx1r5g8WvmNnX46gFQCV
         XBGhif2/hQE176d+LvYX0WLztB23dFmPeHbf5xbINsSQWh+e3mAX8uPEx04NiFGzN72b
         Uo+YAqYGsfKoL2OI/37NTSrP/xkOxxN9cfo5xKA2Wi4p+zTeweMWoVw7sWOQT273u80e
         Yuzg==
X-Gm-Message-State: APjAAAUjW4KVxV2DrMgS7epk2H3rqhn16/5EKjd2T3uw600dTi302DnA
        WgejQ08o77BaGeHGmiymx9t4bw==
X-Google-Smtp-Source: APXvYqz/QQDPA6+bnNKK03js7EGHCc3O8indybIknbR/TjXpwF00GzVlt5rXNQ1j1gbsdolo9KrbhQ==
X-Received: by 2002:a65:64da:: with SMTP id t26mr1443346pgv.180.1573028310541;
        Wed, 06 Nov 2019 00:18:30 -0800 (PST)
Received: from ?IPv6:240e:362:4fb:4700:8c77:245e:61d8:3896? ([240e:362:4fb:4700:8c77:245e:61d8:3896])
        by smtp.gmail.com with ESMTPSA id m2sm22041206pff.154.2019.11.06.00.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 00:18:29 -0800 (PST)
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
 <1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
 <20191105114844.GA3648434@lophozonia>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <24cbcd55-56d0-83b9-6284-04c29da11306@linaro.org>
Date:   Wed, 6 Nov 2019 16:17:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105114844.GA3648434@lophozonia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean

Thanks for the review.

On 2019/11/5 下午7:48, Jean-Philippe Brucker wrote:
> Hi Zhangfei,
>
> Thanks for simplifying this, it's a lot easier to review. I have some
> additional comments.
>
> On Tue, Oct 29, 2019 at 02:40:15PM +0800, Zhangfei Gao wrote:
>> +static int uacce_sva_exit(struct device *dev, struct iommu_sva *handle,
>> +			  void *data)
>> +{
>> +	struct uacce_device *uacce = data;
>> +	struct uacce_queue *q;
>> +
>> +	mutex_lock(&uacce->q_lock);
>> +	list_for_each_entry(q, &uacce->qs, list) {
>> +		if (q->pid == task_pid_nr(current))
>> +			uacce_put_queue(q);
> This won't work in some cases, because any thread can call __mmput() and
> end up here. For example a sibling thread that inherited the queue, or a
> workqueue that's executing mmput_async_fn(). In addition I think comparing
> PID values is unsafe (see comment in pid.h), we'd need to use the struct
> pid if we wanted to do it this way.
OK, still in check.
>
> But I still believe it would be better to create an uacce_mm structure
> that tracks all queues bound to this mm, and pass that to uacce_sva_exit
> instead of the uacce_device.
I am afraid this method may not work.
Since currently iommu_sva_bind_device only accept the same drvdata for 
the same dev,
that's the reason we can not directly use "queue" as drvdata.
Each time create an uacce_mm structure should be same problem as queue, 
and fail for same dev.
So we use uacce and pick up the right queue inside.

>
> The queue isn't bound to a task, but its address space. With clone() the
> address space can be shared between tasks. In addition, whoever has a
> queue fd also gets access to this address space. So after a fork() the
> child may be able to program the queue to DMA into the parent's address
> space, even without CLONE_VM. Users must be aware of this and I think it's
> important to explain it very clearly in the UAPI.
>
> [...]
>> +static struct uacce_qfile_region *
>> +uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
>> +		    enum uacce_qfrt type, unsigned int flags)
>> +{
>> +	struct uacce_device *uacce = q->uacce;
>> +	struct uacce_qfile_region *qfr;
>> +	int ret = -ENOMEM;
>> +
>> +	qfr = kzalloc(sizeof(*qfr), GFP_KERNEL);
>> +	if (!qfr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	qfr->type = type;
>> +	qfr->flags = flags;
>> +
>> +	if (vma->vm_flags & VM_READ)
>> +		qfr->prot |= IOMMU_READ;
> qfr->prot and qfr->flags aren't used at the moment, you could remove them.
Yes,
>
>> +
>> +	if (vma->vm_flags & VM_WRITE)
>> +		qfr->prot |= IOMMU_WRITE;
>> +
>> +	if (flags & UACCE_QFRF_SELFMT) {
>> +		if (!uacce->ops->mmap) {
>> +			ret = -EINVAL;
>> +			goto err_with_qfr;
>> +		}
>> +
>> +		ret = uacce->ops->mmap(q, vma, qfr);
>> +		if (ret)
>> +			goto err_with_qfr;
>> +		return qfr;
>> +	}
>> +
>> +	return qfr;
>> +
>> +err_with_qfr:
>> +	kfree(qfr);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>> +{
>> +	struct uacce_queue *q = filep->private_data;
>> +	struct uacce_device *uacce = q->uacce;
>> +	struct uacce_qfile_region *qfr;
>> +	enum uacce_qfrt type = 0;
>> +	unsigned int flags = 0;
>> +	int ret;
>> +
>> +	if (vma->vm_pgoff < UACCE_QFRT_MAX)
>> +		type = vma->vm_pgoff;
> Otherwise return -EINVAL?  type probably shouldn't default to MMIO if it
> wasn't explicitly requested by the user.
OK
>
>> +
>> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
>> +	vma->vm_ops = &uacce_vm_ops;
>> +	vma->vm_private_data = q;
>> +
>> +	mutex_lock(&uacce_mutex);
>> +
>> +	if (q->qfrs[type]) {
>> +		ret = -EEXIST;
>> +		goto out_with_lock;
>> +	}
>> +
>> +	switch (type) {
>> +	case UACCE_QFRT_MMIO:
>> +		flags = UACCE_QFRF_SELFMT;
>> +		break;
>> +
>> +	case UACCE_QFRT_DUS:
>> +		if (uacce->flags & UACCE_DEV_SVA) {
>> +			flags = UACCE_QFRF_SELFMT;
> I'd simplify this even further by getting rid of the SELFMT flag. It's the
> only possibility at the moment.
OK, we can remove this flag for simplicity, may add it back if required 
in future patch.
>
>> +			break;
>> +		}
>> +		break;
>> +
>> +	default:
>> +		WARN_ON(&uacce->dev);
> WARN_ON(uacce->dev). But shouldn't we instead return -EINVAL here?
> UACCE_QFRT_MAX is currently 16, so users can easily trigger this WARN by
> passing an invalid value.
Yes, good idea.
>
> [...]
>> +void uacce_unregister(struct uacce_device *uacce)
>> +{
>> +	if (!uacce)
>> +		return;
>> +
>> +	mutex_lock(&uacce->q_lock);
>> +	if (!list_empty(&uacce->qs)) {
>> +		struct uacce_queue *q;
>> +
>> +		list_for_each_entry(q, &uacce->qs, list) {
>> +			uacce_put_queue(q);
> The open file descriptor will still exist after this function returns.
> Can all fops can be called with a stale queue?
To more clear:.
Do you mean rmmod without fops_release.

Thanks
