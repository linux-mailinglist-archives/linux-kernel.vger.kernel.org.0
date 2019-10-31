Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DFEB557
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJaQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:50:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37976 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJaQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:50:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id t26so9435559qtr.5;
        Thu, 31 Oct 2019 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLaOpRAjfrbacph10qr6xdAhMPmVu1fR+AKVwIeHENE=;
        b=kEgxMwwRbZzxEVyKWXizq7cW+YwENZDem7Gqpa2Gy1RZwd/e3m9sD3Jd5SdMEBZMmJ
         TcozJ04JWaN3ODGNDMAoCgrZrhXQGFVyqotHzCHWIAjK06BtKaHd8ZS5wBV0G5aqJzU/
         /Jw/gcR2hr+SQsI/fFsGsIXl7qWrDS6rgIgUBeenySZPvWKFyiD4Y3vNyp9lP/RmgEcK
         9S/SJczxVr/7HhlWmxzH/jHwKgf6Y3NKLhwy8LZq9VdQ+hwdM3I6Jw0mxsB1ntyysnkU
         TlaT/hE1qGfrQqm2gZWTLLCEH0aFFEchLuc2FTcyhVNOmQgSWn7di2HFzdJ3DZGjYppy
         XvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLaOpRAjfrbacph10qr6xdAhMPmVu1fR+AKVwIeHENE=;
        b=bGZBclznMB0r62b3plHKVPpcaqKdPq0B385usytdJcCywLbPK5ErG0EZdhg+xLrRmO
         3joMsRug1DllQu4jmvh71VXkHFWpqA81IRzuCvnOqmbDaZvesB7tEqIntqKXO/oF66OY
         GmTd7bqtb0uM19HPL/6Y7y1afaB/yq0dkfp3aORknnEk3aCICzqCZMfru7ToBAtuoZJ0
         sAKgvfkxzT0dTr0IDspatWe6fk6geFmOjDQgWKfuVkNz5sUK/EPFXRyJq6c1zGY2Z8VA
         WmsLULqhvySiU80rG85woPCX5VZdoLaJd2KqvuvddfkHYgSqGAUfzApxALsoxlVk6Caz
         Co8A==
X-Gm-Message-State: APjAAAUKXnmTv/vfsYZlPG6arndjM0zaUvgPcO9auSeXRx5LxrwoEcBG
        PXzVfzW4FMDGwVVHft2bjWm0wkbQ
X-Google-Smtp-Source: APXvYqy8TB1c4Rpru49Qaq9QK03ijg1GplyOlvawK8eI65aLKQPSRzEse7c7fIE5r2DOAVG6rVB0AQ==
X-Received: by 2002:aed:2392:: with SMTP id j18mr6468841qtc.296.1572540624862;
        Thu, 31 Oct 2019 09:50:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::314e])
        by smtp.gmail.com with ESMTPSA id f131sm469553qkb.99.2019.10.31.09.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:50:23 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:50:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iocost: don't nest spin_lock_irq in ioc_weight_write()
Message-ID: <20191031165019.GL3622521@devbig004.ftw2.facebook.com>
References: <20191031105341.GA26612@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031105341.GA26612@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:53:41PM +0300, Dan Carpenter wrote:
> This code causes a static analysis warning:
> 
>     block/blk-iocost.c:2113 ioc_weight_write() error: double lock 'irq'
> 
> We disable IRQs in blkg_conf_prep() and re-enable them in
> blkg_conf_finish().  IRQ disable/enable should not be nested because
> that means the IRQs will be enabled at the first unlock instead of the
> second one.
> 
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
