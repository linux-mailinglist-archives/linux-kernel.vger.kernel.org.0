Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6366EE8847
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfJ2MgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:36:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41361 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJ2MgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:36:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id m125so8060427qkd.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5hGoQiN8reA7dGIYQ91t9fYgfvZm6X7mudHXkHxFTbc=;
        b=fB4dLq1s7yc0cqWr3UX3wBllXkTMDEA+8azMjeCZxyyzzVlboXjhGwEMMGoTiKhPKy
         dcEI4NlpVcTUs9uzgbLjV2rZEGrAdTXVOIdc15xG4p6JajycEAFzCxckmpQ8hJlGgYIL
         LOmZKdh1pITtoNZ7VsPwksUopPCUmV9BflINLdmfyie7OhR2+FT1OTAaQTjDf7PI+JrE
         S7W5Dd5YHrm7sFDuCVa3Oyn657WXt6+9t3D+Q6Uxh1F+C9EdSzI5K8s876KWFrk8On9b
         yFcFGINtsJMkyxrC0/DzrdGMzlAOTevuWCU28Kdj/3Orb0ybScuDqXpyob/dwIO+1qRk
         vxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5hGoQiN8reA7dGIYQ91t9fYgfvZm6X7mudHXkHxFTbc=;
        b=hUuHw9+AdZ71LNA2+uDaM51GLG8FQoFAVDaaVKAWyWHevaPfR/Cj1mOmS25sKXDF7R
         md2nLVaec6SgKPUT0Ib5pxoUpX2AdR2k0h/1pACuG7k1T05VMvcGfOoxXzvxzSL91pyH
         P12q+GyiNQJgQ1ccI4lVPqI4Pp3wP/vRmH5v30P4GnWIVH8vuHAYxcpIliABU9BdCD0l
         UEmhTofXU1A0Ze+Dcm1u+xiHnfdMZIB+HyyOkygu2etV8EIA3dQ2GXB802uykMVll8go
         b0ZOqIkyAyGTlXuyVDSKJ2qk4tmNN8oLtF/I5S4/CJV3QlZcBLitz88C0QoBReiJ/x0C
         kx6w==
X-Gm-Message-State: APjAAAUpZTmKcFWWNQr/DRHKBXWWf0y+0hB5YgQoqHNb36W9FrgczKk5
        IlEPe99aS0DurE0feACahYQzvw==
X-Google-Smtp-Source: APXvYqz2LdmyfhNiUSxN199BU5n72r+ZeOEi+bTfhZqQeFA1tB81/aFKBbah4O2SxXzo26oZBioP5g==
X-Received: by 2002:a37:8405:: with SMTP id g5mr8682859qkd.387.1572352558913;
        Tue, 29 Oct 2019 05:35:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 27sm3676195qtu.71.2019.10.29.05.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:35:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPQj7-0004ib-GH; Tue, 29 Oct 2019 09:35:57 -0300
Date:   Tue, 29 Oct 2019 09:35:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: huge_pte_offset() returns pte_t *, not integer
Message-ID: <20191029123557.GA6128@ziepe.ca>
References: <20191016095111.29163-1-ben.dooks@codethink.co.uk>
 <bd0ac181-7334-9970-b16a-ce7fd78d30ec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0ac181-7334-9970-b16a-ce7fd78d30ec@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:55:13PM -0700, Mike Kravetz wrote:

> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 53fc34f930d0..e42c76aa1577 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -185,7 +185,7 @@ static inline void hugetlb_show_meminfo(void)
> >  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
> >  #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
> >  				src_addr, pagep)	({ BUG(); 0; })
> > -#define huge_pte_offset(mm, address, sz)	0
> > +#define huge_pte_offset(mm, address, sz)	(pte_t *)NULL

We have recently been converting functions like this to static
inlines, maybe that is more appropriate for this block of 'functions'
as well?

Jason
