Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37560E8FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 20:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfJ2TL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 15:11:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46016 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfJ2TL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:11:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id q70so13385098qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uLg9geEqtyjt5mzDoUVYQlG4LfdVTLkoXQvZdovB90Y=;
        b=dnAtc9nSiS/K636rH8LVXxFhcs9pKjtm5VWvqOOE06mikT+tAB8EPpOdlodS2NON8P
         4HVtz3bKvCu8PSzy/Jt9oBrLjZpxKpFZCBI4UruhRyEdeePSDLFee7AKGQ54FZ29BjBy
         fssa1K/0T1Peud0PmIgZ5uUkBXpoPumpFcy5QHQP2rDv6LbalvM1QSASLJAgboUP8HSI
         E4GNkbb2quIg98rFRDKqY90Jak1kkAKYX54n5ld+CUkiUuAoqd+jsR6qJRuYqCEwCcfw
         Y6YMEfQiwzIGkcYZ2SnThyLSriXJe8I6ghk/ty/rkf44OGdVeaUD4xzHOY2khF7cepn7
         QmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uLg9geEqtyjt5mzDoUVYQlG4LfdVTLkoXQvZdovB90Y=;
        b=JiSvwsjc0DruxvSe1ZBNix7Q8XOTBq+Fr2zoOzGaIZnW6qbqL4ndy2KEPKPIg0Q6lZ
         kgwg5tqs69TwJXG1z3hEhu8CHq3pfsRHLFBfPx87u7b9q2KqaJd+Nb5Oj0XzmXDYhV2g
         19+cXIh0Q4okXQzSDZVqR0XqY/Jm3LnVcvu006S/qJNkISpA8M2qPr03QhOG6X9hMOMa
         1GeSqlPf11QGhDphBnHLm+gnqyz7JTjxoZonydm3bNWUOEWminfw2s/TK/Nlc/fSC4sH
         dbd7e5l2VsmdEmkkOL6TfxbvMOTOj9FFwmcM9jSCngBRFwdkE6QPCxGuzrpp2WW+nkwb
         UXRg==
X-Gm-Message-State: APjAAAVAf0kEldlWKjXuZjsi06RVzR6q+rVoevUnuOFOrS5s+E0Ae4gL
        sZ6Oe8mcZmOh6aa0jWDYHhVp1w==
X-Google-Smtp-Source: APXvYqyZAPEze6LI2zKYbJMpKQdcO44XNM8IrD6qTtttrvFRyq4rsMXHje+UG3+u2cq2xAtjVN2Uug==
X-Received: by 2002:a37:4ed5:: with SMTP id c204mr22831514qkb.41.1572376316697;
        Tue, 29 Oct 2019 12:11:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 11sm8326586qkv.131.2019.10.29.12.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 12:11:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPWuJ-0002sy-Li; Tue, 29 Oct 2019 16:11:55 -0300
Date:   Tue, 29 Oct 2019 16:11:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] rxe: calculate inline data size based on
 requested values
Message-ID: <20191029191155.GA10841@ziepe.ca>
References: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
 <1571851957-3524-2-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571851957-3524-2-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:32:37AM -0700, rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> rxe driver has a hard coded value for the size of inline data, where as
> mlx5 driver calculates number of SGE's and inline data size based on the
> values in the qp request. This patch modifies rxe driver to do the same
> so that applications can work seamlessly across drivers.

This description doesn't seem accurate at all, and this patch seems to
be doing two things:

> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 1b596fb..657f9303 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -68,7 +68,6 @@ enum rxe_device_param {
>  	RXE_HW_VER			= 0,
>  	RXE_MAX_QP			= 0x10000,
>  	RXE_MAX_QP_WR			= 0x4000,
> -	RXE_MAX_INLINE_DATA		= 400,
>  	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>  					| IB_DEVICE_BAD_QKEY_CNTR
>  					| IB_DEVICE_AUTO_PATH_MIG
> @@ -81,6 +80,7 @@ enum rxe_device_param {
>  					| IB_DEVICE_MEM_MGT_EXTENSIONS,
>  	RXE_MAX_SGE			= 32,
>  	RXE_MAX_SGE_RD			= 32,
> +	RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge),
>  	RXE_MAX_CQ			= 16384,
>  	RXE_MAX_LOG_CQE			= 15,
>  	RXE_MAX_MR			= 2 * 1024,

Increasing RXE_MAX_INLINE_DATA to match the WQE size limited the
MAX_SGE. IMHO this is done in a hacky way, instead we should define a
maximim WQE size and from there derive the MAX_INLINE_DATA and MAX_SGE
limitations.

> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index aeea994..45b5da5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -229,6 +229,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  {
>  	int err;
>  	int wqe_size;
> +	unsigned int inline_size;
>  
>  	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>  	if (err < 0)
> @@ -244,6 +245,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  			 sizeof(struct rxe_send_wqe) +
>  			 qp->sq.max_inline);
>  
> +	inline_size = wqe_size - sizeof(struct rxe_send_wqe);
> +	qp->sq.max_inline = inline_size;
> +	init->cap.max_inline_data = inline_size;

Whatever this is doing. Is this trying to expand the supported inline
data when max_sge is provided? That seems reasonable but
peculiar. Should be it's own patch.

Also don't double initialize qp->sq.max_inline in the same function,
and there is no need for the temporary 'inline_size'

Jason


>  	qp->sq.queue = rxe_queue_init(rxe,
>  				      &qp->sq.max_wr,
>  				      wqe_size);
> -- 
> 1.8.3.1
> 
