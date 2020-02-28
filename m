Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1501737D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1NEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:04:49 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40544 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1NEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:04:49 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1281557pjb.5;
        Fri, 28 Feb 2020 05:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Axw6SM4TlKkpDQmSjDIki+Kkb3gKc6drvaZVVxQvZX8=;
        b=DHBhJJDs7vStMVIOubzLwDzc2mnFshaJGS5GpJEPB6NtZn35kS2m9GRaviS7tHnnfO
         uAh1i34NY1d8ihRJorPl9C+ZXeiN9ACAPudbcIha2Me72QKu8VxjZHkzL9hJU+v0FGFx
         bpTg0WuzDv3MwuVXDgQvV7Sn2hl8h8BW1J/wxHiOqtV9765AHLogr0GKFQLXT63CiK45
         TTRxsYAQzHcfwM5LqOEDqQXtdHbxkO0chsl2es+hzZCbiP3wJgakP9M9cQmzfMr2Gv/5
         BSVpaC+RZxSMCOIJgy+gBVvZVA7+IrmAuHNgLmXTJkyZLCWh21wh5Z/Q1JpVgB/qUj4O
         dIdQ==
X-Gm-Message-State: APjAAAWsn9bXQo+lqRNVdQQxPWLylEoh0yswlVgH0Mdkn4nOmO69S2P1
        VSyfIo6XzUgT+8I7COkBc9M=
X-Google-Smtp-Source: APXvYqxwbp2fHh9NW+5vR6avXUS0Ib0R/hnP0tZUNuU8MGLGv8UH+rasFveMUM3nfst1DGTP20BiBw==
X-Received: by 2002:a17:902:c20b:: with SMTP id 11mr3196664pll.175.1582895088016;
        Fri, 28 Feb 2020 05:04:48 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u4sm10200571pgu.75.2020.02.28.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:04:45 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EAE224042C; Fri, 28 Feb 2020 13:04:44 +0000 (UTC)
Date:   Fri, 28 Feb 2020 13:04:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/test_kmod: remove a NULL test
Message-ID: <20200228130444.GY11244@42.do-not-panic.com>
References: <20200228092452.vwkhthsn77nrxdy6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228092452.vwkhthsn77nrxdy6@kili.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 12:24:52PM +0300, Dan Carpenter wrote:
> The "info" pointer has already been dereferenced so checking here is
> too late.  Fortunately, we never pass NULL pointers to the
> test_kmod_put_module() function so the test can simply be removed.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Andrew, mind this going up through you? I'll bounce you the original
next.

  Luis

> ---
>  lib/test_kmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index 9cf77628fc91..e651c37d56db 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -204,7 +204,7 @@ static void test_kmod_put_module(struct kmod_test_device_info *info)
>  	case TEST_KMOD_DRIVER:
>  		break;
>  	case TEST_KMOD_FS_TYPE:
> -		if (info && info->fs_sync && info->fs_sync->owner)
> +		if (info->fs_sync && info->fs_sync->owner)
>  			module_put(info->fs_sync->owner);
>  		break;
>  	default:
> -- 
> 2.11.0
> 
