Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362FD92587
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfHSNwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:52:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36717 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfHSNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:52:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so1940135qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bnb9CKB/tUC7U3C6zfvlJTsla79VOjwcHcog5ZBZ4GQ=;
        b=Ndbx0dCJ+2SuD3Msmy+Xj62gM8jjfCmnpKHbyJLn4KLWJUVBbvnd6rNUj1WSnft6hr
         IwFgxCanPilNhHpgRMEAXiMS2UMY/g5inXlwhDwiEUaBET+6IhTd97abOeo220f5cinQ
         m8/ndbjL9i88PW1P4iouqC4E5CCjIBG9ivqutDyRFmtgfB+k5B0GHSfSZsPl5wgQ53VB
         MsV+aMYhKYEsSQOJon9ohdFqHmQrNrpYq3DuoYxoTm3eWJa0KeNZI7RWbDTvofXUemuL
         oZTq+EvFrB2hrzDkxfFYniyByAu/9Nmc94VvTx/MDc5N6UEOv+FtmzOyFT5UPYMTHt98
         GWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bnb9CKB/tUC7U3C6zfvlJTsla79VOjwcHcog5ZBZ4GQ=;
        b=KY1HWKZdewtnZDpvqaMxF4QoEeNGpDDBoJrSfakj8Y0VGQCXVMreFGHVdkM9rJ43JT
         PpN8hO4fJ0iwdUhECYUSFIz9mGiwjfQadLdguTfW4cQN/kWST0aiTQIoRjjAs/a/nbNU
         lKYb7mQXJiBQxWqDEvN5omzv6K0WxoKWklWC54cECb/755qgShc5fZVrunr6wGPW7Fhb
         QwEeGRNICOV7IcfANVM+27gpYH6+UjYu7eBP4uC4qLsnOlHDsP7DsYozqOiU6cl1Y0C3
         BFy9Tyb8AFjq2cru9gK/+QN6pcX1leS+LgeeC5GoPtnRek8ZxbjG0Op+7w+wAU5icvhu
         e4Xg==
X-Gm-Message-State: APjAAAWyE2QTNAV0Nw96Vo9R8shos/KaipIw2Kl16cYjdYaKrj3DBfc+
        +zxZpqYlTanfsc+dhK/YKP/fEr7qxSk=
X-Google-Smtp-Source: APXvYqxcKG5ouN9UlYrki/9v0cHyD7bRPQtoBuOJvF3+cVrxMUun8T0S+0aa+uyjxp05nT/bh3K6Pw==
X-Received: by 2002:ac8:4816:: with SMTP id g22mr21315595qtq.179.1566222734137;
        Mon, 19 Aug 2019 06:52:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r15sm6997402qtp.94.2019.08.19.06.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 06:52:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzi4z-0002ul-BL; Mon, 19 Aug 2019 10:52:13 -0300
Date:   Mon, 19 Aug 2019 10:52:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190819135213.GF5058@ziepe.ca>
References: <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:36:11PM +0000, Bernard Metzler wrote:
> >If the value is really a kernel pointer, then it ought to be printed
> >with %p. We have been getting demanding on this point lately in RDMA
> >to enforce the ability to keep kernel pointers secret.
> >
> >> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
> >> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
> >
> >[..]
> >
> >>  			rv = siw_rx_kva(srx,
> >> -					(void *)(sge->laddr + frx->sge_off),
> >> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
> >>  					sge_bytes);
> >
> >Bernard, this is nonsense, what is going on here with sge->laddr that
> >it can't be a void *?
> >
> siw_sge is defined in siw-abi.h. We make the address u64 to keep the ABI
> arch independent.

Eh? How does the siw-abi.h store a kernel pointer? Sounds like kernel
and user types are being mixed.

Jason
