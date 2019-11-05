Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE928F056B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 19:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390814AbfKESyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 13:54:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37354 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390664AbfKESyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:54:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so486304wme.2;
        Tue, 05 Nov 2019 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9rW8VZViOmPb822P4rTXW5hH1eEjWz5hKDflWqqe0g=;
        b=EK5sMnNEwW2daVmWRVcLyyw1FC+4JyswMKLusVZq8o/UnMsna5IpLiTn0sv0DWQRFl
         0b08GdzAsYXcxtgKKkZb3l6ajQZ3h9d3JNUuW4Wm++lIL5mXODgzwaL9F4YS492T4M5m
         /uKQlWcRNKFRPohmntNUjrf/8FmGrPys58cCVg+qome0g+KXd3uARt4UPU3N0CvqS928
         zhf2yXpIg2wl4+qaqPb5P3s7eB0iMdKGP4/RDXEkIjA404AoEXJhz8WkfCz76w4A7jsq
         vztuGcfPMG/yFcxVeltIKEC4K6PKNANgyh6l+SjFnatfGRnm7oQPtPq7rbucpeqv13v0
         tG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9rW8VZViOmPb822P4rTXW5hH1eEjWz5hKDflWqqe0g=;
        b=ZkRI9wIkW1hcy6BM5Dzy1NFXrt9gwGSfbBqcpoquHUBGfhY8JpU+plkJHL5i4QyFfp
         eXk2QWTObxiE4RYZzDq7SPPR90HC+fY9Kp7YfJE/ulUGIt88oWJT3dqib7e3kkBBbLMX
         BPYKbY3//ZOeSrZuDoB7ooEmgCxI7ziMmhV+l3ODBBYSwUdEFJg6nolq/wPzJ6rmf9i4
         Uc15gCBpAEBnIosEFT83EIhyJut8pHnPD1ffmdAnDp2jobhWl4STXAEB3h5jc6xc8gDA
         Ncxc6axq11shBoRRhRgG0hJmWPFm2x+6BYih+OyrQvuEEC+rGnKseiJPMNXLQrWuazOw
         xwSA==
X-Gm-Message-State: APjAAAU2rw6SARwKbXWWbfYiCPtObyvVNSErTkVLLZ3vB05LnKlPmnsy
        EmtuVUeTbBsiRG/nwR7cCTA=
X-Google-Smtp-Source: APXvYqxE0qQ3loLdW8eDE6haw+ABArPyrk5GG0qXr0rhedvoZMm3o2CDogwV5/da5RXup6KDE5Kn4g==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr461960wmk.114.1572980051604;
        Tue, 05 Nov 2019 10:54:11 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w4sm262251wmi.39.2019.11.05.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:54:11 -0800 (PST)
Date:   Tue, 5 Nov 2019 19:54:09 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] crypto: allwinner: fix some spelling mistakes
Message-ID: <20191105185409.GA16603@Red>
References: <20191105150359.61379-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105150359.61379-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:03:59PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in dev_warn and dev_err messages. Fix these.
> Change "recommandation" to "recommendation" and "tryed" to "tried".
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Fix "tryed"
> 
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 4 ++--
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> index 8e4eddbcc814..73a7649f915d 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> @@ -469,7 +469,7 @@ static int sun8i_ce_get_clks(struct sun8i_ce_dev *ce)
>  		}
>  		if (ce->variant->ce_clks[i].max_freq > 0 &&
>  		    cr > ce->variant->ce_clks[i].max_freq)
> -			dev_warn(ce->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommandation (%lu hz)",
> +			dev_warn(ce->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommendation (%lu hz)",
>  				 ce->variant->ce_clks[i].name, cr,
>  				 ce->variant->ce_clks[i].max_freq);
>  	}
> @@ -513,7 +513,7 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
>  			break;
>  		default:
>  			ce_algs[i].ce = NULL;
> -			dev_err(ce->dev, "ERROR: tryed to register an unknown algo\n");
> +			dev_err(ce->dev, "ERROR: tried to register an unknown algo\n");
>  		}
>  	}
>  	return 0;
> diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> index e58407ac256b..b90c2e6c1393 100644
> --- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
> @@ -446,7 +446,7 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
>  			break;
>  		default:
>  			ss_algs[i].ss = NULL;
> -			dev_err(ss->dev, "ERROR: tryed to register an unknown algo\n");
> +			dev_err(ss->dev, "ERROR: tried to register an unknown algo\n");
>  		}
>  	}
>  	return 0;
> @@ -502,7 +502,7 @@ static int sun8i_ss_get_clks(struct sun8i_ss_dev *ss)
>  		}
>  		if (ss->variant->ss_clks[i].max_freq > 0 &&
>  		    cr > ss->variant->ss_clks[i].max_freq)
> -			dev_warn(ss->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommandation (%lu hz)",
> +			dev_warn(ss->dev, "Frequency for %s (%lu hz) is higher than datasheet's recommendation (%lu hz)",
>  				 ss->variant->ss_clks[i].name, cr,
>  				 ss->variant->ss_clks[i].max_freq);
>  	}
> -- 
> 2.20.1
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
