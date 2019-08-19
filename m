Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9851092673
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfHSOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 10:18:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35767 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:18:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so1527854qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GnVEGIzBU9NHNZIjLTWNk1Cm8cjRlXWPZxE9r7WSQU=;
        b=TDyDjGXMRj3QN5l/0UvPeSmzi4oopdOyT18N30d2AW90XmnDyMBGbvgQLzfS1CxiyK
         HkbH1WrXeBE34BVdID1ARHn+BLWJf/UMqos9yatspCXJ01azUw5jrNTSL/lMpqlT5F7U
         D51LrkZZeGATefeU8KXNIxwXLDU5pwDFdjJaaCkyQPLPPdZQ9zaYyL1M1w7umW4rLAM1
         sJXjs0QJAtS8krCMndXMZMA3IRufBm17UIjQ1QBEKYuzKJjnVDR7DAYSHMhGq4jt2INg
         WpIJi9xg72tcB1BxwygjccXKuDOAkYvHPKqePwsD6docF733RQaqer8BxfitpdGacL8k
         xLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GnVEGIzBU9NHNZIjLTWNk1Cm8cjRlXWPZxE9r7WSQU=;
        b=WOANpPXjqQ2QLS45jkh5m+UEuea0zWq0NShaPt3rvVNJx/AWDKQkS2DuHIHCgQoBsI
         vkCP3+l5eERyH9wvGezoVJ8ywAkRFZwhpMB7cJmroMTWIO3pbTssTIl6cuczeHNiibH1
         8NqHWC2hHNimAQ0rrhPncY+99Y+G6PKdi0Lnx2wmqKv/HYuoandr6RjC8lQ/NJel0+6Z
         vrqaMJjtBnoG/2WjRPc6JG1uCueYKIfrSJ7GFOGR1mefLQ8RAk3NH/54+x/MU/4NQxO7
         hTNbsi1nSL0Gg4Tgvp52BID0vnQd8ftH5uIEE2BTil3qGyY30Hx3I9+rIaISRa1FrHt4
         1lLQ==
X-Gm-Message-State: APjAAAVexEGkiwde+NE0DfTALfbB9fHFgMn1joGKHQ4j7ZUDl0xQhVz+
        K/MMo9cQ4CvBjxS/Nw2ZedZGiQ==
X-Google-Smtp-Source: APXvYqzXZgnkuqjOIko+h2VxvD+TylVtLez9TPIJp4cgLk74ZekCBZCwgjBbBgXYiJcQruIdhAATCA==
X-Received: by 2002:a05:620a:112b:: with SMTP id p11mr21793317qkk.146.1566224337033;
        Mon, 19 Aug 2019 07:18:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l19sm7781335qtb.6.2019.08.19.07.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 07:18:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hziUq-00037U-2n; Mon, 19 Aug 2019 11:18:56 -0300
Date:   Mon, 19 Aug 2019 11:18:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190819141856.GG5058@ziepe.ca>
References: <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 02:15:36PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/19/2019 03:52PM
> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix compiler warnings
> >on 32-bit due to u64/pointer abuse
> >
> >On Mon, Aug 19, 2019 at 01:36:11PM +0000, Bernard Metzler wrote:
> >> >If the value is really a kernel pointer, then it ought to be
> >printed
> >> >with %p. We have been getting demanding on this point lately in
> >RDMA
> >> >to enforce the ability to keep kernel pointers secret.
> >> >
> >> >> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
> >> >> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
> >> >
> >> >[..]
> >> >
> >> >>  			rv = siw_rx_kva(srx,
> >> >> -					(void *)(sge->laddr + frx->sge_off),
> >> >> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
> >> >>  					sge_bytes);
> >> >
> >> >Bernard, this is nonsense, what is going on here with sge->laddr
> >that
> >> >it can't be a void *?
> >> >
> >> siw_sge is defined in siw-abi.h. We make the address u64 to keep
> >the ABI
> >> arch independent.
> >
> >Eh? How does the siw-abi.h store a kernel pointer? Sounds like kernel
> >and user types are being mixed.
> >
> 
> siw-abi.h defines the work queue elements of a siw send queue.
> For user land, the send queue is mmapped. Kernel or user land
> clients write to its send queue when posting work
> (SGE: buffer address, length, local key). 

Should have different types.. Don't want to accidently mix a laddr
under user control with one under kernel control.

Jason
