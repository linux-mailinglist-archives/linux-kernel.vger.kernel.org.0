Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F13CBABA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfJDMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:43:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45762 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbfJDMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:43:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so3810173pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3cqXuQcaFN/VntPTldGPlJjAqOO9AvS0M1U11Ovk1c=;
        b=SDadIs6cScwMULRTeDO8uEHTjB6x33RGyIxABkrwwW3ZDHFc/0nhikeYnFDsCWJ+Uu
         0d+yi+kzeH6yd4iH01HxeNWQZGUyJQMGaZAuXej1do1ptl1mmrVtPjZQoQSZU78SthxD
         il21R251bB/Vmlh/TwjBfohmN78FuedGI6IkzScbOx5OPkjXSo0aEUbelmyqjE9oY3cZ
         vcdLI7UmyOyrKAtnkSYSVf3nxtZVmYPDP9TbTBKUX9aH6O+zyPL5Kdhf8Mt2pgRmUiEi
         St2nqw5X9yWmLbBYFgmOmmx9/mb5VV8uxZaeL8TBMC7C74SX6DjPFV097m089IpH14tv
         Q6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3cqXuQcaFN/VntPTldGPlJjAqOO9AvS0M1U11Ovk1c=;
        b=tvQJhJLLsqgY/s9LBYDA6nVAWZ0znGx4fXP7MiMFZz3FttF8SJRTO12Kr70+3nKS1W
         mw+gc6nT1kDyq6PE+WC6CY3Fd7fKTJSnO4Ffo3JK9IFnWkmSSE/UG4tJZVSPxDIYaduI
         HFeLEKDCLyIr5vXdtI3KqXh7k4113QNDCQeQ6vKjXhF2WLlCRTrBJ368DVNVa9ua0UjJ
         8n/Y5IhNpeBdDBk5vceTJDHEPl5O5obDU3D3ccH+mGwQIcwVzpi8wAjUFl5fTdsnKvCU
         x2u3Wian/zHS60aYC3W4dZ4rJq6b8B4EAP9+yE9Pj24xVnIkDwjSDSiFKv/EeYFHiJvQ
         XfQw==
X-Gm-Message-State: APjAAAWfVx5qO70vfIWlWYWrDIqILWPuCIJGOr51jlab8zBsdMVkb0mI
        tT7XXKRxzSLoVpKAYcBDyfDvCQ==
X-Google-Smtp-Source: APXvYqwrBu7MsPYZ8FG9D4/hc+Zhpd+amMqjP2ga4VhO8msAfB0tohBaeKFpQF9xhhF7Zg1Pmy7UGA==
X-Received: by 2002:a63:1401:: with SMTP id u1mr14866540pgl.73.1570193008611;
        Fri, 04 Oct 2019 05:43:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id z13sm6601080pfg.172.2019.10.04.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 05:43:27 -0700 (PDT)
Date:   Fri, 4 Oct 2019 05:43:25 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004124325.GB11046@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003203250.GE32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003203250.GE32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:32:50PM -0700, Matthew Wilcox wrote:
> On Thu, Oct 03, 2019 at 01:18:47PM -0700, Davidlohr Bueso wrote:
> > It has been discussed[1,2] that almost all users of interval trees would better
> > be served if the intervals were actually not [a,b], but instead [a, b). This
> 
> So how does a user represent a range from ULONG_MAX to ULONG_MAX now?
> 
> I think the problem is that large parts of the kernel just don't consider
> integer overflow.  Because we write in C, it's natural to write:
> 
> 	for (i = start; i < end; i++)
> 
> and just assume that we never need to hit ULONG_MAX or UINT_MAX.
> If we're storing addresses, that's generally true -- most architectures
> don't allow addresses in the -PAGE_SIZE to ULONG_MAX range (or they'd
> have trouble with PTR_ERR).  If you're looking at file sizes, that's
> not true on 32-bit machines, and we've definitely seen filesystem bugs
> with files nudging up on 16TB (on 32 bit with 4k page size).  Or block
> driver bugs with similarly sized block devices.
> 
> So, yeah, easier to use.  But damning corner cases.

Yeah, I wanted to ask - is the case where pgoff == ULONG_MAX (i.e.,
last block of a file that is exactly 16TB) currently supported on
32-bit archs ?
I have no idea if I am supposed to care about this or not...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
