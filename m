Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532576B0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbfGPVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 17:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfGPVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:10:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B38E2173E;
        Tue, 16 Jul 2019 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563311449;
        bh=n+Bn+l+cocbUUKE1hcmyc7LxYuNmdQZj8ye7iFFZ9dM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e0Yoeza2yPveXA+92jY/2RqFilkK5CRv5gg5ToLsnbx6plgyhXBOJ40QVvCgMCLbm
         lYqzvOyjpPLPYKWu9WnDxSmdsVrY9b+1SIob7lUgtImr2zBWWuaq5EKpNKHNLEUnYG
         9D9M+OxP48NSnLTK0ZjW1kxvyv520Q3Jjyii9AuQ=
Date:   Tue, 16 Jul 2019 14:10:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Message-Id: <20190716141048.c94534a23e4c059dff34e3a1@linux-foundation.org>
In-Reply-To: <8dd86951-f8b0-75c2-d738-5080343e5dc5@nvidia.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
        <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
        <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
        <20190715150031.49c2846f4617f30bca5f043f@linux-foundation.org>
        <0ee5166a-26cd-a504-b9db-cffd082ecd38@nvidia.com>
        <8dd86951-f8b0-75c2-d738-5080343e5dc5@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 17:38:04 -0700 Ralph Campbell <rcampbell@nvidia.com> wrote:

> I'm not surprised at the confusion. It took me quite awhile to 
> understand how migrate_vma() works with ZONE_DEVICE private memory.
>
> ...
> 
> I see Christoph Hellwig got confused by this too [1].

While making such discoveries, please prepare a patch which adds
comments which will help the next poor soul!
