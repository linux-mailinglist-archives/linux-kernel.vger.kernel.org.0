Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661D572E17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGXLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:48:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfGXLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:48:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so31653613wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ja8qOZBd/+yPpakrfgGOO9Lsjgvj3+ENbjktOu7PQg=;
        b=P/Uz1vqQq8oTd7cuw88+8LKg4UMpx/GPMqE8FjyIKrALHxccYwxrrS5IA0bnYBWN2z
         AiPq/PW8v6DI6Rj+Fta0BYE0v7+XUbhdpjc3/s3kijRktL+u6AdV6STGtga6cTCBSiqt
         k2V2MxsWYugo60P9luWE+sT/58/mo9CpZx1it+vKxBV5qljjcO6F+gIKzTGPCHqa+R/U
         ga2kJT5ZpI6bXSb6sUsAROUihfuMumxnDD+RA3pNVCZqpMso+DHB/NIIrH3AM4EvcIKX
         8nqTtsWPpihGh7iIzDYcoCGE1273gk6xYTy865HsxclPsMHiYhBEZUqE6/SwHX+oDrZ6
         UjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ja8qOZBd/+yPpakrfgGOO9Lsjgvj3+ENbjktOu7PQg=;
        b=bhZkI+ZNGqyf8IAg43x74vfmPKR4AKeBchnrlx1qOhi3CKWYP8JyjVAbjUku+MGZ7b
         U/bYowKzHRzM/XCJdGuarMaDbDKKCUkOxegj+Tu3KchL8EP7fEkwcxR3mablTcfnRMFr
         /CPZ1hVWdgiZXvSj6+rNYTQ47I4kB/GuhFXcfsBoi06yPqUu6J2UB5i6glxH+E4t7dg2
         Y6z/AAz3mzRmpfn9PEeT6y0mrob2hYRlc0SPeCAnIPYLO7TgoPagbVNpQsVEJwt2aQJw
         vP53DnMMsvFLp2y8ne8xL4oxRKu+LMABjwAjxw4o4kmDRaeoQez7mUtFUOfKQZUeisBK
         tMig==
X-Gm-Message-State: APjAAAV3tAAse4ct2H1vpa9r8MnVuQUNkuBms5u5sAxGd4CenJLx5seu
        HRBT0l505rkzO+rsjvogLa5wjQ==
X-Google-Smtp-Source: APXvYqxtbimswj1+iqEbPXS+959hF1x39IRwg6ckgQ3h6RiygXt2444TSZdS5jTfDlL37IKCtELZKw==
X-Received: by 2002:adf:e883:: with SMTP id d3mr91261045wrm.330.1563968921330;
        Wed, 24 Jul 2019 04:48:41 -0700 (PDT)
Received: from localhost (static.20.139.203.116.clients.your-server.de. [116.203.139.20])
        by smtp.gmail.com with ESMTPSA id g11sm46247726wru.24.2019.07.24.04.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 04:48:40 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:48:39 +0200
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] block: drbd: Fix a possible null-pointer dereference
 in receive_protocol()
Message-ID: <20190724114839.fl3ldycrn3zwfgaw@rck.sh>
References: <20190724034916.28703-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034916.28703-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:49:16AM +0800, Jia-Ju Bai wrote:
> In receive_protocol(), when crypto_alloc_shash() on line 3754 fails,
> peer_integrity_tfm is NULL, and error handling code is executed.
> In this code, crypto_free_shash() is called with NULL, which can cause a
> null-pointer dereference, because:
> crypto_free_shash(NULL)
>     crypto_ahash_tfm(NULL)
>         "return &NULL->base"
> 
> To fix this bug, peer_integrity_tfm is checked before calling
> crypto_free_shash().
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>
