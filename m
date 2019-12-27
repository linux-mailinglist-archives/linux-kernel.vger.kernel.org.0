Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585E412B457
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 12:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfL0LwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 06:52:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51858 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfL0LwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:52:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so7893453wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CYKhEBIyq9WsTm4USUtMIQjKjqSO6ixzpKdzAB4oDVs=;
        b=FJ5H4I1pH8AI9vdRjVpcvyexPVcVWHT4hESrkMD37naCNQrNUAToMg/KzQ63ShscAU
         7sA1kSWqTuSap7spewyOng+o7oZcYxGmMSlArvHlF2Iup8iAUWmqeU/s6fFg6TYZERNd
         ZCa1xrm59vHtXlRxvMsUpXpY3gPB2Npwv4YCucND4bjO4x2YAQwYap0pYA8QpedaLPQJ
         NsvLACvis8dykG/Xi4K2Z28xmKhh0WFPojhK6Y3lVn7Z2sv3cmBdMSAlyFqQzJ4P4MCN
         ptwtIXAjo87o5/2eURiV3/rZu9WFDLfRGY/z8C5jqmHE/EJFC1jvauq57HoPclwlxRU8
         dsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CYKhEBIyq9WsTm4USUtMIQjKjqSO6ixzpKdzAB4oDVs=;
        b=aivsKX+2q2VpScNVf9FNo5nSJOZ+Usoxw+A4d7seI/eupLTmhvdHz3bwAiDkfRhJsy
         QJKVvPxe3aOk4XjAw4xJJRaYm7zVJc1e+7qBlxNxZfvZtMLaPsiXKSi6IW3sgwMqNkjL
         kQcvNG3vVqPGGvGnQxFIRGqvzqnwhaN1os412kezp6I+iKKrOoudjiTkoJzkXGlmBE4W
         TE+bJxhm8EJDVfEHp3fVr9CtNLJxRxA4ya4XJvt5ffkiRm4p/80D6OttNxJqPbTXGayT
         neYBIYbjPMqUb861cyGx1bSHzjStHBH+jkiMlff/9c1UFhtRbvYJel8W7OHYrRSmRuhM
         JVhA==
X-Gm-Message-State: APjAAAUUqRWMHqdnVSgD9lrxoyyK0QyKVQGt3nWglZr+Bqrnq2AmLKjN
        fMlXJM1S4ewRDqd1VixahDZjWQ==
X-Google-Smtp-Source: APXvYqz2mIvuXnQ4YmVCVQ4oGmz3+KftH7EYXnr0k5f6KQgbzvBbJr3z/NRPaqk+UBpY6/0lrBeEoA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr18906638wmj.7.1577447519769;
        Fri, 27 Dec 2019 03:51:59 -0800 (PST)
Received: from apalos.home (athedsl-4510215.home.otenet.gr. [94.71.190.15])
        by smtp.gmail.com with ESMTPSA id s128sm11127104wme.39.2019.12.27.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:51:58 -0800 (PST)
Date:   Fri, 27 Dec 2019 13:51:56 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tomislav Tomasic <tomislav.tomasic@sartura.hr>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [RFC net-next 0/2] mvpp2: page_pool support
Message-ID: <20191227115156.GA29682@apalos.home>
References: <20191224010103.56407-1-mcroce@redhat.com>
 <20191224095229.GA24310@apalos.home>
 <20191224150058.4400ffab@carbon>
 <CAGnkfhzYdqBPvRM8j98HVMzeHSbJ8RyVH+nLpoKBuz2iqErPog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhzYdqBPvRM8j98HVMzeHSbJ8RyVH+nLpoKBuz2iqErPog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 03:37:49PM +0100, Matteo Croce wrote:
> On Tue, Dec 24, 2019 at 3:01 PM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Tue, 24 Dec 2019 11:52:29 +0200
> > Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > > On Tue, Dec 24, 2019 at 02:01:01AM +0100, Matteo Croce wrote:
> > > > This patches change the memory allocator of mvpp2 from the frag allocator to
> > > > the page_pool API. This change is needed to add later XDP support to mvpp2.
> > > >
> > > > The reason I send it as RFC is that with this changeset, mvpp2 performs much
> > > > more slower. This is the tc drop rate measured with a single flow:
> > > >
> > > > stock net-next with frag allocator:
> > > > rx: 900.7 Mbps 1877 Kpps
> > > >
> > > > this patchset with page_pool:
> > > > rx: 423.5 Mbps 882.3 Kpps
> > > >
> > > > This is the perf top when receiving traffic:
> > > >
> > > >   27.68%  [kernel]            [k] __page_pool_clean_page
> > >
> > > This seems extremly high on the list.
> >
> > This looks related to the cost of dma unmap, as page_pool have
> > PP_FLAG_DMA_MAP. (It is a little strange, as page_pool have flag
> > DMA_ATTR_SKIP_CPU_SYNC, which should make it less expensive).
> >
> >
> > > >    9.79%  [kernel]            [k] get_page_from_freelist
> >
> > You are clearly hitting page-allocator every time, because you are not
> > using page_pool recycle facility.
> >
> >
> > > >    7.18%  [kernel]            [k] free_unref_page
> > > >    4.64%  [kernel]            [k] build_skb
> > > >    4.63%  [kernel]            [k] __netif_receive_skb_core
> > > >    3.83%  [mvpp2]             [k] mvpp2_poll
> > > >    3.64%  [kernel]            [k] eth_type_trans
> > > >    3.61%  [kernel]            [k] kmem_cache_free
> > > >    3.03%  [kernel]            [k] kmem_cache_alloc
> > > >    2.76%  [kernel]            [k] dev_gro_receive
> > > >    2.69%  [mvpp2]             [k] mvpp2_bm_pool_put
> > > >    2.68%  [kernel]            [k] page_frag_free
> > > >    1.83%  [kernel]            [k] inet_gro_receive
> > > >    1.74%  [kernel]            [k] page_pool_alloc_pages
> > > >    1.70%  [kernel]            [k] __build_skb
> > > >    1.47%  [kernel]            [k] __alloc_pages_nodemask
> > > >    1.36%  [mvpp2]             [k] mvpp2_buf_alloc.isra.0
> > > >    1.29%  [kernel]            [k] tcf_action_exec
> > > >
> > > > I tried Ilias patches for page_pool recycling, I get an improvement
> > > > to ~1100, but I'm still far than the original allocator.
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn: http://www.linkedin.com/in/brouer
> >
> 
> The change I did to use the recycling is the following:
> 
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3071,7 +3071,7 @@ static int mvpp2_rx(struct mvpp2_port *port,
> struct napi_struct *napi,
>     if (pp)
> -       page_pool_release_page(pp, virt_to_page(data));
> +      skb_mark_for_recycle(skb, virt_to_page(data), &rxq->xdp_rxq.mem);
>     else
>          dma_unmap_single_attrs(dev->dev.parent, dma_addr,
> 
> 
Jesper is rightm you aren't recycling anything.

The mark skb_mark_for_recycle() usage seems correct. 
There are a few more places that we refuse to recycle (for example coalescing
page pool and slub allocated pages is forbidden). I wonder if you hit any of
those cases and recycling doesn't take place. 
We'll hopefully release updated code shortly. I'll ping you and we can test on
that


Thanks
/Ilias
> 
> 
> --
> Matteo Croce
> per aspera ad upstream
> 
