Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A97A1982E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC3SER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 14:04:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43775 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3SEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:04:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so19999531qki.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4hYfBPPMsnQLhbHNboJva/pkduGULtadEHE/+GQT34=;
        b=E/UcXSV4s5eVQyTMQKe79QSsPgXJ2wOIzcOHLZBLea8gQPgvLHAwErJWFPozUT1Jth
         n2Q1DAywnmP0TFdLlksu3SFxl8e4OK2aFcLS/COesMHooSjeDG7xtKfei8O7z6WebEdV
         vp7U/5gpSwwY1iEJQGGlDVg+RqFlZkAPPBrVdUJ25KKjnlX1p18DMuwNIAz6jkqcGTb1
         Dny1qA7/lawXuLuJflZdl42jd5LbTwbJpAzcq/PrCNn6ifHbsM8nSDjeGKUzWN9dvWo6
         HiReh2wLZJcTVSw5WeDdn1FzuEm/ZMbqJfdoimsJRLi7YoDr0KRh6ZtKkPiceqTkVB7F
         vVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4hYfBPPMsnQLhbHNboJva/pkduGULtadEHE/+GQT34=;
        b=bPY4dD+DFdKXWk6SUX+RTNtVfkQvY92z5xp9gdQfcjVLn5LW+DbI5R+EYG+4qCssUu
         DWBvUS/xexrHcyFGwpMyc3QQpEIX0JjvoTZF1Erf4Y24zm3Rub+m8JhNAGjKYlak7FMK
         ChUNxaMaBIfER1XZCnqNIapQTjCR/SmkhXmIeMXxwD0QWrqOLOhv5zkkDTegMqlmq+7T
         Vn3zjdb4UCNGoecKMyk+7G5SSZSq450hQQ5dqpNFlO4HLDYKDEcXzZzSClGdpRLV/hu3
         3j9+uQKUi3z/IPTVB91h7DTosM+1HflS3gdDGhYtgEDF/7RxBhTMobSaM39hLqrgJSqU
         krMw==
X-Gm-Message-State: ANhLgQ0snlDij7r/chtNfhbIHhTaGlD98Mo4a67uoDEea643LedCxHLE
        Z8599rV9YqpwfS67KgF0CkGteg==
X-Google-Smtp-Source: ADFU+vslFdZMufUpGUjNF685OiAvFuwqrraXFVX1mi5EP3rlxYGLgJNHBKGy/SGMgS5a0DiGDu/+lg==
X-Received: by 2002:a05:620a:2101:: with SMTP id l1mr1194780qkl.375.1585591455594;
        Mon, 30 Mar 2020 11:04:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r192sm10992825qke.95.2020.03.30.11.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 11:04:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIylh-000302-Ui; Mon, 30 Mar 2020 15:04:13 -0300
Date:   Mon, 30 Mar 2020 15:04:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/bnxt_re: make bnxt_re_ib_init static
Message-ID: <20200330180413.GA11459@ziepe.ca>
References: <20200330110219.24448-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330110219.24448-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:02:19PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/infiniband/hw/bnxt_re/main.c:1313:5:
>  warning: symbol 'bnxt_re_ib_init' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
