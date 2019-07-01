Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8555AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFYWO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 18:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYWO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:14:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B32520883;
        Tue, 25 Jun 2019 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561500866;
        bh=a+8VUAm8OWcTl8Kv/cC5FFTkGEPWCMubfxkuqab8qY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pdYKAzcT5/SVa+QZbQxLUBofTxIfjrpiHl88O9NdUIe7OEUO74C6mEsBMTxq3KRvQ
         /8WwJ2fwOXLhXnNJ22SgZ6WP/7IhkzI8BoucLTD38qsRjbt/G3Hny1IiAePeFayjfH
         VbPnXXtCaFR7V5j0uaxPzGR3oiA8Zm5lYytebzB0=
Date:   Tue, 25 Jun 2019 15:14:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 3/4] mm: shrinker: make shrinker not depend on memcg
 kmem
Message-Id: <20190625151425.6fafced70f42e6db49496ac6@linux-foundation.org>
In-Reply-To: <1560376609-113689-4-git-send-email-yang.shi@linux.alibaba.com>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
        <1560376609-113689-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 05:56:48 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Currently shrinker is just allocated and can work when memcg kmem is
> enabled.  But, THP deferred split shrinker is not slab shrinker, it
> doesn't make too much sense to have such shrinker depend on memcg kmem.
> It should be able to reclaim THP even though memcg kmem is disabled.
> 
> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker.
> When memcg kmem is disabled, just such shrinkers can be called in
> shrinking memcg slab.

This causes a couple of compile errors with an allnoconfig build. 
Please fix that and test any other Kconfig combinations which might
trip things up.
