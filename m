Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD48E1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfHOANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 20:13:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45388 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOANX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:13:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so538213qki.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qzhD8inHCWGPsSExfxoS4FMI+7+fcQwlxaBDgT12qb4=;
        b=kQ7rO4RrHFSZ6MZuuxxoF8VbnBnjRycJLb07elyvEnUiIa4wJgsVinEba3cE2MqTB9
         fJulQuWx6Y5tYTxlddWTc11PBfISadqD+ExfUHnpoPQON92Ku+S5Y/WG1rnAqUDmFm/t
         sZdh11B/5WH1wkWaQw580ROrmY5paRB/mKD6yO6YRdOAjXFOKeMa/lNRNHsDHR11a2YM
         fH5CrO9kz+3OETBgm2cIOfKwCC5iyZs6YtbJwN/rErrCwql6u7WwlNfS1W19r/IYCdLa
         OB/xGbNt8+DZYg3Zcz43LE9VgkFuylrF77Y+9lVNSAp5BzomHMMBV2AknnHcgTQXagXw
         j3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qzhD8inHCWGPsSExfxoS4FMI+7+fcQwlxaBDgT12qb4=;
        b=ckP6UJZYY9sCmrOoxKvB183O+Lktq5YnrxvkxNo28ih1PFFbKEXYOGOcvQ1nLHtuSp
         WuwT1S0TtyDZNk9G4XxbuacZ3cwWpy0HxDC4jIkKHqTzEg4nCY7k9vmU25zdYTVQo9cS
         GJaCQ7P7TzrqGItaaMO9uWE9zj29XNsD5Dzxo5/Qqwr5aFxobpG0BNN7iRo70ZMsAIrp
         PMeAcOdXz/gfp1XW5/q1fZvnAcUhsRp3hYcgbXsJe9/XKXnxVmujEbndEF5D6AShJkkN
         IAajQZDD0fvOrIVBVz1+7KGQMlQt5Bj6+m2sKDWaTmsyN1HUS7l3g1cl5qVwJ7nm3Dt8
         KXkg==
X-Gm-Message-State: APjAAAX/qrXuvlJalnkergaAjKaTOx6aEeTXEACHoGE3ZnVkd6OXrevj
        1QPJ36LZSRwBcUEp6S9qwm8W3Q==
X-Google-Smtp-Source: APXvYqxctXlgOtCTuI+nHfly9zVzKydMCFWuaFknzokpvDUX3JdzMaNu+TsBvuyQsnsSgXcVbMLc+w==
X-Received: by 2002:a05:620a:130d:: with SMTP id o13mr1851841qkj.285.1565828000618;
        Wed, 14 Aug 2019 17:13:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i5sm756517qti.0.2019.08.14.17.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 17:13:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hy3OJ-0003bl-SN; Wed, 14 Aug 2019 21:13:19 -0300
Date:   Wed, 14 Aug 2019 21:13:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 hmm 03/11] mm/mmu_notifiers: add a get/put scheme for
 the registration
Message-ID: <20190815001319.GF11200@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-4-jgg@ziepe.ca>
 <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:20:31PM -0700, Ralph Campbell wrote:
> 
> On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Many places in the kernel have a flow where userspace will create some
> > object and that object will need to connect to the subsystem's
> > mmu_notifier subscription for the duration of its lifetime.
> > 
> > In this case the subsystem is usually tracking multiple mm_structs and it
> > is difficult to keep track of what struct mmu_notifier's have been
> > allocated for what mm's.
> > 
> > Since this has been open coded in a variety of exciting ways, provide core
> > functionality to do this safely.
> > 
> > This approach uses the strct mmu_notifier_ops * as a key to determine if
> 
> s/strct/struct

Yes, thanks for all of this, I like having comments, but I'm a
terrible proofreader :(

Jason
