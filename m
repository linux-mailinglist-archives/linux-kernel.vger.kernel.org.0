Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046E2ED124
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 00:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfKBXxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 19:53:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfKBXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:53:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so8834301pgo.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/Y/HsfG3BX2fZgofwl16a0Nv3tLsdVHznmMwpL2tAbQ=;
        b=oyQ4/6ZGtCXkWWsCVtzR159cLW781RxnGfJsxQT0yAE2AzURerN+9QEP8q57c7wQGK
         n0QPnE09l1qr7sAOafSgQC77zbAVWpiGjPP6bfmarhBVF1rjiY+hcF3gwFaYouTn6t5S
         xTWVNf5FC/jBtQqnOZG4Md6Z8vZgCRgWDDsh9KBGSptGyZjRMFkB7aKaJnLXFqcUH6SH
         ZQyDGV7+WhSqvhSiKUae1JgDhwpxN1rAKY1b4yNDyW908pORomuWwf/BEIDanBZGSVR0
         efl/seYA0vCLlO7wEHE/cQ4FpUFsfylzhUkb8cCQZ0F6XOlbuHbaJHHn66672mi4GIHA
         vaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/Y/HsfG3BX2fZgofwl16a0Nv3tLsdVHznmMwpL2tAbQ=;
        b=bs1v1NxWS/XYi2g6p5jfP83W/JKuj+l+9SSw3TvrjhAuNWq2NcO723qvhWdfSNbAGf
         K20Tp7HNOZ/wh6nLU64NXihFXWQMpcwL4v2PUjXxqL1eSFzk8O5FS3qPmtf6P/ewTA66
         W+2e8mzSuv2uXRoJfaBwR+lLnZ+n35K967JFuUgcc8Ln3oONyhrNf2FbAS1zTfVWRkyM
         y36xo05Z+196ouU2mfX3q+hprRdC6aJW7RTAp+aWJSJH+ia5gAs3OWcUwXnAZ1FTV/Qr
         /1oH7jVrVIPKgnfCYSgIGbA1DPnd4abBCDAyZP/zs7jQ1NXHrQ90wtFAg/5kzgI62m4K
         lWsA==
X-Gm-Message-State: APjAAAWAsjdF6RcKvzfoDEjVmM8rccAR8ZYrBEtHR2i5p/aCcv7zryu0
        jU+XlbNEGBkZLwmwTnd4HwSqJZOSssw=
X-Google-Smtp-Source: APXvYqwp7XxCVtJH9Wu/z/Wo+cj9o3ZWUxHqgwaac9zlw6e8ka5CbJL81DheDVXkwtyyZR7JQcDr5A==
X-Received: by 2002:a63:6786:: with SMTP id b128mr7272604pgc.126.1572738791143;
        Sat, 02 Nov 2019 16:53:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id bb15sm12364965pjb.22.2019.11.02.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 16:53:10 -0700 (PDT)
Date:   Sat, 2 Nov 2019 16:53:09 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
cc:     hui yang <yanghui.def@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: There should have an unit (kB)
In-Reply-To: <20191102205411.GB15832@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1911021646240.34229@chino.kir.corp.google.com>
References: <1572704287-4444-1-git-send-email-yanghui.def@gmail.com> <20191102205411.GB15832@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2019, Matthew Wilcox wrote:

> On Sat, Nov 02, 2019 at 10:18:07PM +0800, hui yang wrote:
> > From: YangHui <yanghui.def@gmail.com>
> > 
> > -    printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
> > +    printk(KERN_CONT " %ldkB", zone->lowmem_reserve[i]);
> > Make it look more perfect
> 
> I don't think this is accounted in kilobytes though.  Isn't it the
> number of pages?
> 

Yes, it's not in KB.

Speaking of lowmem_reserve, however, the current default of 1/256 for both 
ZONE_DMA and ZONE_DMA32 seem too large as memory capacities of nodes 
increase.  We tune this to be much smaller so that we don't have as much 
memory set aside only for GFP_DMA or GFP_DMA32 allocations for that reason 
and because there is less reliance on lowmem for our configurations.

I'm wondering if the default should either be 1/256 up to a bounded memory 
capacity and then the excess is disregarded or whether the default itself 
should be changed to, say, 1024.

Looping in Johannes who may also have an opinion on this.
