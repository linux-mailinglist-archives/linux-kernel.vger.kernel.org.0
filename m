Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE00E449B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407069AbfJYHfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 03:35:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406923AbfJYHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:35:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so1094898wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6A6igi+iIahcN2i7nqFwvDHaOIrrC7kc9SulvaWb1t0=;
        b=eMiPHVZUMZHiiC3b4wO8fkj4sOT4J8cQT/B7pTI+nYvnYmtef30uo9xxiPHTDLQ5OH
         p1K+uv8OkW0Z4+Kk0Tns6Ry1uk+qekivivWeZV5mil3cYc2J06xyu99Q13F36NeSDlFJ
         rCwL2/2JJ/GHtnlog9n0EAP+hWde6vBnc1/wchD+xtgxxg/12KbLv8zkavTCEwK2iFsA
         euMXFexUNw+UqcOh1hGHC/S+9XxBlELQihI0O1c3+IXjt7+5Y8y1iS2pCgejUvYGtOiv
         tec/DUnVsEEciNCVkbSGwBxfjhhW+CVVJyU6ZIQEf0ECvNkxNj+Dx6J4dObCthj1q831
         QgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6A6igi+iIahcN2i7nqFwvDHaOIrrC7kc9SulvaWb1t0=;
        b=WOQazdEy+gAjxRFn0506mXOr42CC+EBQ1gyKZGbngseEVWN+/QE5ONE0loFbrzYhgf
         gGjyLXALcI7IrDR/LlXTe7yIvTp7YAXoEIpoIRgk9hMgWHGqv6Mrvfl8TRNVvj7jOu2a
         GzGCWbvgkRk89u9s0gRx9RwAWiDL3RLwQVp6FUQOyn+5pznvP7P/vdVt0foHE1vsPdWX
         54KDeUhyu19bGmJvCvyrX+t5RQ6YJyDbLMOcsOJJLC+xVSWpXcGKHJYaV1YdlwugS7J5
         5A2yTJPWvZawPKQUkswxfl8fu+9SXfYbFI5Xs019Gm4oO80CLqYp6lX55F9hbydjPn/0
         ftRA==
X-Gm-Message-State: APjAAAX9pfOdhUAaMu7mPO52gvkwaELCpaAPjYa1jzvimscavn1wVz5b
        3fXzcszxtEQoNonyI4eJYrVbBw==
X-Google-Smtp-Source: APXvYqzgAol3HSs41oKRVvqmVFgjk39bV/r9jrrjPaqODAkY5xGnPUDMWeb/ek0hQto/lg9GZ4rVNg==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr1590050wrb.308.1571988941205;
        Fri, 25 Oct 2019 00:35:41 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id l26sm592473wmg.3.2019.10.25.00.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:35:40 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:35:38 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v6 2/3] uacce: add uacce driver
Message-ID: <20191025073538.GC503659@lophozonia>
References: <1571214873-27359-1-git-send-email-zhangfei.gao@linaro.org>
 <1571214873-27359-3-git-send-email-zhangfei.gao@linaro.org>
 <20191016172802.GA1533448@lophozonia>
 <5da9a9cd.1c69fb81.9f8e8.60faSMTPIN_ADDED_BROKEN@mx.google.com>
 <20191023074227.GA264888@lophozonia>
 <5db25e56.1c69fb81.4fe57.380cSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5db25e56.1c69fb81.4fe57.380cSMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:28:30AM +0800, zhangfei.gao@foxmail.com wrote:
> > Something else I noticed is uacce_idr isn't currently protected. The IDR
> > API expected the caller to use its own locking scheme. You could replace
> > it with an xarray, which I think is preferred to IDR now and provides a
> > xa_lock.
> Currently  idr_alloc and idr_remove are simply protected by uacce_mutex,

Ah right, but idr_find() also needs to be protected? 

> Will check xarray, looks it is more complicated then idr.

Having tried both, it can easily replace idr. For uacce I think it could
be something like (locking included):

	static DEFINE_XARRAY_ALLOC(uacce_xa);

	uacce = xa_load(&uacce_xa, iminor(inode));

	ret = xa_alloc(&uacce_xa, &uacce->dev_id, uacce, xa_limit_32b,
		       GFP_KERNEL);

	xa_erase(&uacce_xa, uacce->dev_id);

Thanks,
Jean
