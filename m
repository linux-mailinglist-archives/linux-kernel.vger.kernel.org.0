Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447F078C54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbfG2NJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 09:09:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46426 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbfG2NJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:09:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so59503365qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gmqmelot7c8TsfxfK8guHC1YaaOzW0NDY2AOV3Nd6Yw=;
        b=1mF386Irha74xgp2n02mxpH5+sB7AkZ9W6c14hyts/wM/W8HyaR2OODlAK6tRTnBhf
         T1FasDPLMMA7tV3KsxMPdmVTwP8nlr4RRn53kiDWsWqsp989a8dw4g1XyOR15oPDlRuL
         iDbqrvc9wUDu9/VjhjJxwamDQ5+7g7oKDkpXQO6gQhPf4L1cvdQ78pecEvK2416q2nJl
         slp+tPAkDp7/RjgIyK6xhKvIBYupGFCKWd+DAYyc2Zrh7eRmnymmO6HrXDtbq0xC02mL
         f3AxOVSQ05CMFEFropuyWaeOhFHzBe7EIP23/Itd2PtcLzNK7hftL6NUHrFuurq0ohYt
         bEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmqmelot7c8TsfxfK8guHC1YaaOzW0NDY2AOV3Nd6Yw=;
        b=GOtpVLC55jCRdphhKcPSASDgL4lpLxQ9h11J4y3WwE7RMj5NXPTR1E+JJlbipskN7A
         Ey1uDnssKP+09my6UlNtcjEkhiBkHeV61V4qJMZvYZeIE0rtMOIIKbytMeEV4LcFKppz
         d81hi99h0/WdTi5tsTCji+eJAh340HnKJM2tIQiDfewIh6NNP8aPfQm9s+0MFP+ihIYs
         ZXoHTQnpNybyQOzE1wTdPwClAk6M6uzrzv4MRzMtkixr6hyjnAglGBlaF0FdylInVTZN
         1DqhRNdg/bdho0oyRx7cIoPUt98ES6lD36GDz8jriFsilwwGYIBScMPHbzjq9uLHgngl
         01WA==
X-Gm-Message-State: APjAAAWtC1ux91NYiexvQuYo7LEOxLyitz/Zg6FiR1L/1tKWORZ/8x5B
        CJ3j55Mw3wtaCIXw6+U0zWg=
X-Google-Smtp-Source: APXvYqxlf9wa1ZONBy8deTWyxx+xNxslPUXKiAkpwGKjeNbSTvSXqtOMFg1q+0qPHgK/kJcWqoYSfA==
X-Received: by 2002:a0c:8a76:: with SMTP id 51mr80122616qvu.210.1564405755580;
        Mon, 29 Jul 2019 06:09:15 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t6sm27462939qkh.129.2019.07.29.06.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:09:14 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:09:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd_genl_status: null check for nla_nest_start
Message-ID: <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
References: <20190723230157.14484-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723230157.14484-1-navid.emamdoost@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:01:57PM -0500, Navid Emamdoost wrote:
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source code.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/block/nbd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9bcde2325893..dba362de4d91 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2149,6 +2149,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
>  	}
>  
>  	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
> +

No newline here, once you fix that nit you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
