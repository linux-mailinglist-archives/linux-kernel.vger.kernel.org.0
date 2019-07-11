Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A679765F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGKSFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 14:05:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38829 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfGKSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:05:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so4358868qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1D45VDmCAbr+E4SZBzLB6VIycjDuXVw9dZK5gxi0EWc=;
        b=D0oxmZqNliGmZXYrGlhIuUh88RZXZ6IhsMAFjAuLmDmNgjdEH+q+K6YnRJrxj7arH8
         ibDZ7U1n+0tp6aNzpggOFouDSSYnHYAgfPUKAbSjef7i4GZxiBjOBtSx6GyLsCG7I8Gs
         3/nzEU52dHNo4HusV+6Qin1Wu1zmfGeiNhJFM51AbW2JxISWIxPoigumd2UMuNYyUbkq
         HQs82H7FdUQfp1nyOXzSwBKVDw2umbdNTDuBDd1Dei8y+sOUVydROMLgz9de2iphEO20
         x8ZsHURXfb0KYVdcJtWqFA4sItPUKHyTuyTeUp9pK4wUGCeP0d7cslj2oo39SjrAqRa+
         aYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1D45VDmCAbr+E4SZBzLB6VIycjDuXVw9dZK5gxi0EWc=;
        b=HcLBeLsZdNx/xCCY9wNFTnA7rTw5XGat7/zItH3rOMsK06U8y5sbfYYmFbZlQC8tG0
         VMFuJc4sfMYzov/8Aw+96cg7ZXVe21+9e+ZXRI6q2AXT+GrYLFr1+fJFRD3Fe03Y3/pk
         W2Kr3EmAerx+ssOyYNL2YnWjKOebZMm5PU39W3A4JupN0JTEG9HN8FDLiFcQWdVVMnhM
         aldLP8uDL8MXJ+sdDj0pWMhD3jjkJtmQ/e5XpKQkuHe8Ebm30NdAiRXUzf2kfn8ybCiw
         4Xd/Ju0fpOKYqC7CwpLrLpvq9EONJ/F79vAic3ULd0vvsOI1MEtV9Syh3tw6bAw0Aq/q
         KYYA==
X-Gm-Message-State: APjAAAXP1zcMZlnbf8D7P6P48VC3JakH04wu+9ywnbvN0auw+faABUDk
        EKzGD1gF5+YRwjeXOfxY1whWAw==
X-Google-Smtp-Source: APXvYqy+KfKKXdR19a3uizpOypAq/2/Z4gaxG2jfIxckyfMiRmNY9/ODZSym3MEcVj/1lDRN0YQD1A==
X-Received: by 2002:a05:620a:310:: with SMTP id s16mr2827756qkm.420.1562868312483;
        Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z21sm2034477qto.48.2019.07.11.11.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hldRP-0000Da-MZ; Thu, 11 Jul 2019 15:05:11 -0300
Date:   Thu, 11 Jul 2019 15:05:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Mark expected switch fall-throughs
Message-ID: <20190711180511.GA816@ziepe.ca>
References: <20190711161218.GA4989@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711161218.GA4989@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:12:18AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/infiniband/sw/siw/siw_qp_rx.c: In function ‘siw_rdmap_complete’:
> drivers/infiniband/sw/siw/siw_qp_rx.c:1214:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    wqe->rqe.flags |= SIW_WQE_SOLICITED;
>    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_rx.c:1215:2: note: here
>   case RDMAP_SEND:
>   ^~~~
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_qp_sq_process’:
> drivers/infiniband/sw/siw/siw_qp_tx.c:1044:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     siw_wqe_put_mem(wqe, tx_type);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1045:3: note: here
>    case SIW_OP_INVAL_STAG:
>    ^~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1128:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     siw_wqe_put_mem(wqe, tx_type);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1129:3: note: here
>    case SIW_OP_INVAL_STAG:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> NOTE: -Wimplicit-fallthrough will be enabled globally in v5.3. So, I
>       suggest you to take this patch for 5.3-rc1.

Okay, I queued this for the current merge window then

Jason
