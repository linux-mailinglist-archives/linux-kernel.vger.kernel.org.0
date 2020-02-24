Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5516AE97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 19:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgBXSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 13:22:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:6019 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgBXSWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:22:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 10:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284426587"
Received: from araj-mobl1.jf.intel.com ([10.24.11.16])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 10:22:02 -0800
Date:   Mon, 24 Feb 2020 10:22:02 -0800
From:   "Raj, Ashok" <ashok.raj@linux.intel.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
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
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
Message-ID: <20200224182201.GA22668@araj-mobl1.jf.intel.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenneth,

sorry for waking up late on this patchset.


On Wed, Jan 15, 2020 at 10:12:46PM +0800, Zhangfei Gao wrote:
[... trimmed]

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

I think having this at open time is a bit unnatural. Since when a process
does fork, we do not inherit the PASID. Although it inherits the fd
but cannot use the mmaped address in the child.

If you move this to the mmap time, its more natural. The child could
do a mmap() get a new PASID + mmio space to work with the hardware.


> +	mutex_unlock(&uacce->mm_lock);
> +	if (!uacce_mm) {
> +		ret = -ENOMEM;
> +		goto out_with_mem;
> +	}
> +
