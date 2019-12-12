Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFDB11D9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 00:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfLLXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 18:18:35 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:37312 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731357AbfLLXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:18:34 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ifXiw-0007z1-Tq; Fri, 13 Dec 2019 00:18:23 +0100
Date:   Fri, 13 Dec 2019 00:18:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Florian Westphal <fw@strlen.de>, linux-mm@kvack.org, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove __krealloc
Message-ID: <20191212231822.GO795@breakpoint.cc>
References: <20191212223442.22141-1-fw@strlen.de>
 <alpine.DEB.2.21.1912121459400.121505@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912121459400.121505@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> wrote:
> On Thu, 12 Dec 2019, Florian Westphal wrote:
> 
> > Since 5.5-rc1 the last user of this function is gone, so remove the
> > functionality.
> > 
> > See commit
> > 2ad9d7747c10 ("netfilter: conntrack: free extension area immediately")
> > for details.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> So this also means that we can fold __do_krealloc() into krealloc()?

I would leave that to compiler but if you prefer this I can respin.
