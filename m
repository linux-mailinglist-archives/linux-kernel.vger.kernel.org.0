Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78D7EFCAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfKELsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 06:48:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38884 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfKELsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:48:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so15607458wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zp9qiL0ltKb9jL4LVJWEei4ILz8NVBXvn672HPv3XcE=;
        b=NL6TiWTvdinGYZluWGSsmZHNFr526R7MSyzrU5joAq8uK73VAEVt5GLJ6QYKHk4ABF
         uQtRxl4A9S7biM/riwE1QQAKdMrUtyFjUg0NW55RuQMaaLUumpiq2aT07Gi2egGFx6iy
         QepJirNZwiury2KpZ/d0E8bDtTNh/kDADtHeAmXhMbTglW2MBjbE69TphKWtv6Eh6nlZ
         wiSCSdNBNDhFQEd04RYxnwg5IvY/cr8npLB7x9fv7+M1Nv6NWgXyf3DP/n86+XKX4g52
         aCFvzWysEiEzr0Ae7XfHHE5aeFspdoalu9yj8/vHZDsUWJIZZMh4u/WkFTRrU/s9Nmyh
         606A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zp9qiL0ltKb9jL4LVJWEei4ILz8NVBXvn672HPv3XcE=;
        b=cgjOOTbwqqEBztWVOrfaBtj0mnNOnCduok0PFdUYD731roG6sOYfNvpdOXIsVOR4vT
         YdAsJqHzKsv9erpM7GDvBs3PZ6LV1Txh9gLLNZM8CffbMfnhdeHI3RPVGMQKie7fETpj
         MwuT6hHjSuK3JFmUWlzdWtEtkZvhGsoEnOsQmhcZCIYpJSW9k7li0jZ0Y/TX7aXeAw63
         jyKz2YlUo397GOdmriHIRB8TC4llsxwdN52rD1Mx6JH6cH11hBufgYWz6HRHbMGdCBLX
         fFA6aZ9NvE/xdGLhsxTfNsK3YhQkVNJAT7Ujm4v/dP8aPi1Dt2faJHbd4AU4+aNzTbTG
         EZ9Q==
X-Gm-Message-State: APjAAAV3+rZZWMDduZJwr6MInz0JIWSKHlPCNUFMQEv7wEvxHMLEyE2E
        dHrDWzhKwaYKucD7ttuNXw0boA==
X-Google-Smtp-Source: APXvYqwzbVrprBjq+eXGIRVB0swnwWh7fhMwzUoJE509CMdkS7DkewOthPh20OJBQh8PWTIGQh1OIw==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr1768915wmk.128.1572954528016;
        Tue, 05 Nov 2019 03:48:48 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id f13sm19986974wrq.96.2019.11.05.03.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:48:47 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:48:44 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
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
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
Message-ID: <20191105114844.GA3648434@lophozonia>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
 <1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhangfei,

Thanks for simplifying this, it's a lot easier to review. I have some
additional comments.

On Tue, Oct 29, 2019 at 02:40:15PM +0800, Zhangfei Gao wrote:
> +static int uacce_sva_exit(struct device *dev, struct iommu_sva *handle,
> +			  void *data)
> +{
> +	struct uacce_device *uacce = data;
> +	struct uacce_queue *q;
> +
> +	mutex_lock(&uacce->q_lock);
> +	list_for_each_entry(q, &uacce->qs, list) {
> +		if (q->pid == task_pid_nr(current))
> +			uacce_put_queue(q);

This won't work in some cases, because any thread can call __mmput() and
end up here. For example a sibling thread that inherited the queue, or a
workqueue that's executing mmput_async_fn(). In addition I think comparing
PID values is unsafe (see comment in pid.h), we'd need to use the struct
pid if we wanted to do it this way.

But I still believe it would be better to create an uacce_mm structure
that tracks all queues bound to this mm, and pass that to uacce_sva_exit
instead of the uacce_device.

The queue isn't bound to a task, but its address space. With clone() the
address space can be shared between tasks. In addition, whoever has a
queue fd also gets access to this address space. So after a fork() the
child may be able to program the queue to DMA into the parent's address
space, even without CLONE_VM. Users must be aware of this and I think it's
important to explain it very clearly in the UAPI.

[...]
> +static struct uacce_qfile_region *
> +uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
> +		    enum uacce_qfrt type, unsigned int flags)
> +{
> +	struct uacce_device *uacce = q->uacce;
> +	struct uacce_qfile_region *qfr;
> +	int ret = -ENOMEM;
> +
> +	qfr = kzalloc(sizeof(*qfr), GFP_KERNEL);
> +	if (!qfr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qfr->type = type;
> +	qfr->flags = flags;
> +
> +	if (vma->vm_flags & VM_READ)
> +		qfr->prot |= IOMMU_READ;

qfr->prot and qfr->flags aren't used at the moment, you could remove them.

> +
> +	if (vma->vm_flags & VM_WRITE)
> +		qfr->prot |= IOMMU_WRITE;
> +
> +	if (flags & UACCE_QFRF_SELFMT) {
> +		if (!uacce->ops->mmap) {
> +			ret = -EINVAL;
> +			goto err_with_qfr;
> +		}
> +
> +		ret = uacce->ops->mmap(q, vma, qfr);
> +		if (ret)
> +			goto err_with_qfr;
> +		return qfr;
> +	}
> +
> +	return qfr;
> +
> +err_with_qfr:
> +	kfree(qfr);
> +	return ERR_PTR(ret);
> +}
> +
> +static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	struct uacce_queue *q = filep->private_data;
> +	struct uacce_device *uacce = q->uacce;
> +	struct uacce_qfile_region *qfr;
> +	enum uacce_qfrt type = 0;
> +	unsigned int flags = 0;
> +	int ret;
> +
> +	if (vma->vm_pgoff < UACCE_QFRT_MAX)
> +		type = vma->vm_pgoff;

Otherwise return -EINVAL?  type probably shouldn't default to MMIO if it
wasn't explicitly requested by the user.

> +
> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
> +	vma->vm_ops = &uacce_vm_ops;
> +	vma->vm_private_data = q;
> +
> +	mutex_lock(&uacce_mutex);
> +
> +	if (q->qfrs[type]) {
> +		ret = -EEXIST;
> +		goto out_with_lock;
> +	}
> +
> +	switch (type) {
> +	case UACCE_QFRT_MMIO:
> +		flags = UACCE_QFRF_SELFMT;
> +		break;
> +
> +	case UACCE_QFRT_DUS:
> +		if (uacce->flags & UACCE_DEV_SVA) {
> +			flags = UACCE_QFRF_SELFMT;

I'd simplify this even further by getting rid of the SELFMT flag. It's the
only possibility at the moment.

> +			break;
> +		}
> +		break;
> +
> +	default:
> +		WARN_ON(&uacce->dev);

WARN_ON(uacce->dev). But shouldn't we instead return -EINVAL here?
UACCE_QFRT_MAX is currently 16, so users can easily trigger this WARN by
passing an invalid value.

[...]
> +void uacce_unregister(struct uacce_device *uacce)
> +{
> +	if (!uacce)
> +		return;
> +
> +	mutex_lock(&uacce->q_lock);
> +	if (!list_empty(&uacce->qs)) {
> +		struct uacce_queue *q;
> +
> +		list_for_each_entry(q, &uacce->qs, list) {
> +			uacce_put_queue(q);

The open file descriptor will still exist after this function returns.
Can all fops can be called with a stale queue?

Thanks,
Jean
