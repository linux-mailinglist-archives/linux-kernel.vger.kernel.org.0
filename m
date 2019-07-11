Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD4657F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGKNjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 09:39:18 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43774 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfGKNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:39:18 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so2463531uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KazpKbhHu00FeDDiPuVEMFaRWnbqcqwHcNdLtMoOcsY=;
        b=hSpyP6xxjo+eds0vrJb/JDa7NP4AH5hQ5XuifWkBcJeQ7QMVBqpHtOBM+0SNoecQAT
         pZT3btPHtTfKXQPkK/OXxLy6gRcJGFjS5Z2RHHVat3M/YCDQrA523q7tXlIp0lCiXGul
         gaBSTMYQbNyZ1yVHI/m2ZeEucJqTcl3pqzEIlLRHIlwgqIMBIEppENpnpEqEwHpKCREG
         MQHdsD9Cd241lCqj0guf5qqEEFCmEVcVWA6YxxBpFe9sovxZgSWkAX0Rh3GBfcGN2mAf
         JNmgWPxLUVhOlTE6KR119OqXGM0GjC6IgKU82Ldw162Zz78+g5B4OrxU0yHOfeTy50TL
         BwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KazpKbhHu00FeDDiPuVEMFaRWnbqcqwHcNdLtMoOcsY=;
        b=CpuxlirWMINTnbTC4tEtXUcUzKZYIx5sc7Fcs2sYzAdNKrO4/LcRWGoH6/rT1ocec3
         Jqqi1sNWcJChmjdK503abcKlE5pn0IjEx+EXnVc1+2cWXl1+pLymbVuDRNf+lc4wIpGb
         WLmuw58QyNQCCcvNuTNOjdvlqtfXceqSaA7JhvdoliSXZbJFs9fEvgD65BSvK4E7fTVm
         IxeX/bDzi6JffiNbi7H6mtHJzNZwVydpq+2EGft7lcC08IaqlzpLxctPQrD70/4aqBtg
         shzV+m0Ft0ONMptL2/xqXtFvABY9KMIMU91IHh/yVwXUVI6TxzIQvi1O5XJa3GPGE4Uu
         +59Q==
X-Gm-Message-State: APjAAAXpQoIniS83i31SjC+RwJauksJ4DIS9ohDwr7n9itQhHP78coNN
        BqpNZRx4AIhA8Exg4DRauS7Vtw==
X-Google-Smtp-Source: APXvYqxZqbGbb8rEAZtuGWj3Z/ByRS0P9lJZBtlaYx5SRTsxdaUIbZMmBZGoyMBP+H11pK7IY+SnlA==
X-Received: by 2002:ab0:2756:: with SMTP id c22mr4174211uap.22.1562852357161;
        Thu, 11 Jul 2019 06:39:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s67sm2549736vkb.30.2019.07.11.06.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 06:39:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlZI3-0007pP-MZ; Thu, 11 Jul 2019 10:39:15 -0300
Date:   Thu, 11 Jul 2019 10:39:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711133915.GA25807@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711081434.GA86557@archlinux-threadripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> Hi Bernard,
> 
> On Thu, Jul 11, 2019 at 07:44:22AM +0000, Bernard Metzler wrote:
> > Nathan, thanks very much. That's correct.
> 
> Thanks for the confirmation that the fix was correct.
> 
> > I don't know how this could pass w/o warning.
> 
> Unfortunately, it appears that GCC only warns when two different
> enumerated types are directly compared, not when they are implicitly
> converted between.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wenum-compare
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78736
> 
> If it did, I wouldn't have fixed as many warnings as I have.
> 
> https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aissue+is%3Aclosed+label%3A-Wenum-conversion
> 
> Maybe time to start plumbing Clang into your test flow until it can get
> intergrated with more CI setups? :) It can catch some pretty dodgy
> behavior that GCC doesn't:

I keep asking how to use clang to build the kernel and last I was told
it still wasn't ready..

Is it ready now? Is there some flow that will compile with clang
warning free, on any arch? (at least the portion of the kernel I check)

> Kernel CI has added support for it (although they don't email the
> authors of patches individually) 

Well.. we didn't see any emails till yours, so if others are looking
they aren't communicating?

Jason
