Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC44F79B77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfG2Vs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:48:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfG2Vs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:48:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so28653388pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PBTMvcbHzZT2ylPnK6/N5vcdHNMJLTiFP+3wGDUQr2I=;
        b=jTV7nJdEl0NkTwN34RMqsJBOee8l5Z3q0hOXS3OUXvWyUfdKDCh9T+qa6f1H3zLt5Q
         BwkBPHekvwmFAjO6ryu51O5kzdnBYzfsnwSZBTdqxW6wJQkU2sE8aCqNvU9qdDzfyROK
         lYkYQVPqkjTEDAka1fm7+NWXWevb2tQ6tXoU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PBTMvcbHzZT2ylPnK6/N5vcdHNMJLTiFP+3wGDUQr2I=;
        b=P9zY71td9nK7z+vdrf317IvGEiedsoH5yirv9QpRhMDq6AqZqrQZTbWDwiZGHq5cy0
         kV/XFBabBxH0qQjBP+jHXI/KxXJ/UO6fsfGPVG8KPMRaSenbQXcBv99W9G1HIYM1D+3y
         KGlG8Kq3wCXi2WieXjU/LG9xHSzLZPpCeIOlP2IJdPxMcaelTBw6vI+EN8RCw9NdVIm+
         bsH9V0eLUkjDMcKspuudnoJ4TUVQOtvBfAwPJyEIildMqFZaa+wytsIiqal4iHUMeZ48
         KjOsjQ3UfCHZr46EKYeVvOXs1M95F/mN2uPGEs7EQ+v4jEmbpi17/wCJZcBEtwdmFbBE
         UrtQ==
X-Gm-Message-State: APjAAAVrgurofbIDN/LcK2QCS7/nRt9UTpvCoY7IWpI8mHNyWroxEuyF
        rCt3Y7DfXrkh7bnyH3sEFDzIhA==
X-Google-Smtp-Source: APXvYqy/bap7RfEtFb7EQIgK80j1BhkxTEm0QBIJyQZLWzek6h6g2aCIGDdMPLFJ1yb6bJe0f4S3xg==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr37715386pfn.98.1564436936079;
        Mon, 29 Jul 2019 14:48:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm99551147pfg.166.2019.07.29.14.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 14:48:55 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:48:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: wd33c93: Mark expected swich fall-through
Message-ID: <201907291448.C98BB1E8F1@keescook>
References: <20190729210313.GA5896@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729210313.GA5896@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:03:13PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: m68k):
> 
> drivers/scsi/wd33c93.c: In function ‘round_4’:
> drivers/scsi/wd33c93.c:1856:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    case 2: ++x;
>            ^~~
> drivers/scsi/wd33c93.c:1857:3: note: here
>    case 3: ++x;
>    ^~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/wd33c93.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
> index fb7b289fa09f..f81046f0e68a 100644
> --- a/drivers/scsi/wd33c93.c
> +++ b/drivers/scsi/wd33c93.c
> @@ -1854,6 +1854,7 @@ round_4(unsigned int x)
>  		case 1: --x;
>  			break;
>  		case 2: ++x;
> +			/* fall through */
>  		case 3: ++x;
>  	}
>  	return x;
> -- 
> 2.22.0
> 

-- 
Kees Cook
