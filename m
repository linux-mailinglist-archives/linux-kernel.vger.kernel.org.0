Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C886FF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfGVL6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 07:58:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42413 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfGVL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:58:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so38152329qtm.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CRIrzOnudb3IKNcSZjvzayaeIc4KXzRLwzqzwFK4iM=;
        b=MAyS9OdfOwONhvYe/ait10+JAjoZI3hO4Mj7T5hTVE1bL72n9k/nvdIs4hGyj7A31F
         PAsZJUMujjv3wXv9it18Xfyf7SlQE9S8o/Hk8vfKY1w4TRNgKBlurXINsulcLAvSS+tL
         xdKCEeJGxVPejtF11vLao5F6vIXpdEnQoZDj+A439+KiPa9fk+o65u6uhXiDWZZj0Nu/
         aZPoetrNx/Glrwjf2MTuhIpztfUqSI4csZkrdVGd6tCWsZrT0Qb2nmHlCmmL5lURCQ/K
         Ix9R9qsGFfNhtRZWipsR31J1m51dsYq5nBljAonGND/Mmp7YhiAXNBCuTjtz5V+0OsUC
         RqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CRIrzOnudb3IKNcSZjvzayaeIc4KXzRLwzqzwFK4iM=;
        b=KT8pn+9MywYq8R3cacPy+sskSslGDWsdkHRSb1cUu+xmtW7Z2qDbk2HlvLafNFMdMw
         bc8z5XJPp9kOIejFspV7zehJve5gvIPGCu9RbVBDXJx/g4v3s2j/RfWAv8bJ44ho0VZA
         qV8ggeR4gomZViDFNXCM0mR36THEP3bnpgmop6PGGz2TU5h2iyKBgIVwqpSI7ntZS0ex
         UNY6L+zYMgh14ikzv4QlGHaukO480pL8iMDeInLJeIEBjNZWgAtGtD9+mwvufmpMrrtv
         bzDnGbuHFImsqKwb0CFc7aAdJGZQBNihIATS6FqYFmbjRUF4xBtJ9GutvLInAIO3oSVv
         LhoA==
X-Gm-Message-State: APjAAAVVMFk9d4YdE70Lb/t8Rl6LioKXUeKasky35VeMVQrTMaZbg5gV
        Ho1cwzaAJyVAsQL0T2Y422iKgw==
X-Google-Smtp-Source: APXvYqwYDEkz6L3GiOzWJNuG80fvv3Qku2BL6YGqjha4khjQQxDuFR21xX6vcx5fVr+FsJgiCF5LCA==
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr50525548qvh.78.1563796685976;
        Mon, 22 Jul 2019 04:58:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z5sm17303382qti.80.2019.07.22.04.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 04:58:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpWxA-0002M7-PK; Mon, 22 Jul 2019 08:58:04 -0300
Date:   Mon, 22 Jul 2019 08:58:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>,
        john.hubbard@gmail.com, SCheung@nvidia.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, bsingharora@gmail.com,
        dan.j.williams@intel.com, dnellans@nvidia.com,
        ebaskakov@nvidia.com, hannes@cmpxchg.org, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190722115804.GB7607@ziepe.ca>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
 <20190719105239.GA10627@amd>
 <20190719114853.GB15816@ziepe.ca>
 <20190719120043.GA15320@infradead.org>
 <20190719120432.GC11224@amd>
 <b5143eb4-f519-57bc-4058-4ed934596ee1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5143eb4-f519-57bc-4058-4ed934596ee1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:38:28PM -0700, John Hubbard wrote:
> On 7/19/19 5:04 AM, Pavel Machek wrote:
> > On Fri 2019-07-19 05:00:43, Christoph Hellwig wrote:
> >> On Fri, Jul 19, 2019 at 08:48:53AM -0300, Jason Gunthorpe wrote:
> >>> It is like MMU_NOTIFIERS, if something needs it, then it will select
> >>> it.
> >>>
> >>> Maybe it should just be a hidden kconfig anyhow as there is no reason
> >>> to turn it on without also turning on a using driver.
> >>
> >> We can't just select it due to the odd X86_64 || PPC64 dependency.
> >>
> >> Which also answers Pavels question:  you never really need it, as we
> >> can only use it for optional functionality due to that.
> > 
> > Okay, just explain it in the help text :-)..
> > 
> > Alternatively... you can have WANT_HMM_MIRROR option drivers select,
> > and option HMM_MIRROR which is yes if WANT_HMM_MIRROR && (X86_64 ||
> > PPC64), no?
> > 
> 
> Yes. This really should be a hidden option that just auto-enables. It's
> not ideal to require people to both *find* HMM_MIRROR, *and* figure out 
> that they need it. (I think it's just this way due to the history of how
> HMM got merged--it started off as a kind of experimental sandbox, so
> it had it's own config options, to avoid bothering anything else.)
> 
> I'll send out a new patch to just auto-select. The WANT_HMM_MIRROR
> approach seems accurate, given the (X86_64 || PPC64) complication, probably
> after -rc1 is ready (I don't see the ODP code using HMM yet, so that
> must not have been merged yet.)
> 
> Longer term, I vaguely recall that there is no strong reason preventing 
> HMM from being made to work on other arches, and am hoping that it was
> just done this way to save development time. I don't want to leave it 
> this way unless there's a good reason to.

No one has given me a satisfactory answer about the restriction
either.

The only thing this kconfig controls that could possibly be arch
specific is the page walking code in hmm_range_snapshot and
related. 

Maybe there is/was some arch entanglement there?

Jason
