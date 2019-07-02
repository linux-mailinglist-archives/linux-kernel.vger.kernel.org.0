Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9A5DA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGCBH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 21:07:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40213 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCBHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:07:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so264257pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+v++TWQepjq+jXcnB/nkSYABP3Yxzhi+VRnwYA7APOc=;
        b=oMb6uM8LX67HBBPGSfb9AUp3WO62ALREH93oGjCh6lO/52vJU14Whlz5WJTyiSSMrz
         QjaNY/UQ071B1xHmQllCQ6rr7wCt6LfkVksGvNso68NLioyZLq/CiWF91YNHV3RVc4Tc
         uKYaHgTqS5g77nWbSFqqtkguGecdLARTlgXwiQcCjSJGW9dNVfB5jAyGp9efviyHfv41
         FmHQ7ktOdAJy57+EuNl5e0YYpeK5FnzK6KngtCHCVJSKMDnCICS8DqhxsQDvRx7ecso7
         kROKNQpbpmweFl+TG+cpIQMjO6gH1SGadjtzkB71XIJpb8QrwIg9DBSqOmSvj1+gYjtW
         PIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+v++TWQepjq+jXcnB/nkSYABP3Yxzhi+VRnwYA7APOc=;
        b=d/kVngmucZ0Z0aNWov12KjVoDhkx6+rNUMqBUzTJdX4Llf2fSISn4SKkMdcbZirGYJ
         U/AZ8YPOfGeoESDyMI+in1lWpfdmosSB7j5NCBywNlgm7l0wW0eSvJoi+WYDmqzWgQ4J
         2141aZMYkG3mqz1vGjvXbhGqjsslMNvH/UlltQ8JV+1FOWgy6jnRDjJ5NoPxUsQjIcZF
         BXsJjBTA0aeAg5kAKHNeclHfa7dBxTjZdKS2mMbK1J40gO1bEeD5X+g9yJ+Ji6U5Ci2A
         6lvYTqBOexS13Ig57Q5fDK6GUNAV1MdU+djbAdfpP4cV4r+Rlk9dCS0klgu48e02+4Ct
         g33g==
X-Gm-Message-State: APjAAAXtAXE/4XkxVQ1Cgb2y9T4a6NH3VZs2yUsqwzn7AwFxqOP9Pn+1
        yYtf/l7GVmddWbCsZPu+4d50dBy2ies=
X-Google-Smtp-Source: APXvYqx+HGwW+nz/+iPgIThxonkUBijVnsTKXtGANv3oqK0FIvnCQgiB8iPHGgSMuIFGhcqm4pEVDQ==
X-Received: by 2002:a17:90a:26ea:: with SMTP id m97mr7877414pje.59.1562101418200;
        Tue, 02 Jul 2019 14:03:38 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q126sm21796589pfq.123.2019.07.02.14.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:03:37 -0700 (PDT)
Date:   Tue, 2 Jul 2019 14:04:01 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190702210400.GA14593@Asurada-Nvidia.nvidia.com>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
 <20190701122158.GE8166@8bytes.org>
 <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
 <20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
 <d4bccb17-2f7a-65e4-6c89-e37cceb6d935@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4bccb17-2f7a-65e4-6c89-e37cceb6d935@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:40:02AM +0100, Robin Murphy wrote:
> On reflection, I don't really think that size_t fits here anyway, since
> all the members of the incoming struct scatterlist are unsigned int too.
> Does the patch below work?

Yes.

> ----->8-----
> From: Robin Murphy <robin.murphy@arm.com>
> Subject: [PATCH] iommu/dma: Handle SG length overflow better
> 
> Since scatterlist dimensions are all unsigned ints, in the relatively
> rare cases where a device's max_segment_size is set to UINT_MAX, then
> the "cur_len + s_length <= max_len" check in __finalise_sg() will always
> return true. As a result, the corner case of such a device mapping an
> excessively large scatterlist which is mergeable to or beyond a total
> length of 4GB can lead to overflow and a bogus truncated dma_length in
> the resulting segment.
> 
> As we already assume that any single segment must be no longer than
> max_len to begin with, this can easily be addressed by reshuffling the
> comparison.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you!

> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 129c4badf9ae..8de6cf623362 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -721,7 +721,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 * - and wouldn't make the resulting output segment too long
>  		 */
>  		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> -		    (cur_len + s_length <= max_len)) {
> +		    (max_len - cur_len >= s_length)) {
>  			/* ...then concatenate it with the previous one */
>  			cur_len += s_length;
>  		} else {
