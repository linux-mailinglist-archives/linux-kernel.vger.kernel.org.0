Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1BBA15D02C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 03:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBNCsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 21:48:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNCsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CDEVyx0EpwrdhZ53S3lCYBJJBVy7OyGqLxfZ7Kx/RTo=; b=hTGxYK94ShBJQRo8gp9VnBJSfS
        yc7z5VtbWZZhtoARfqUkG/EoqtsJkvl2HNEbdTp1Gbj8nITrYEXx5SgWVIxmCcedxrpiMC3l7YVU5
        jwOJIPz6vR9SGuzXt8Zh9bR68n9Aa0mEqteTkms86sqSoddisLrghFvLb/+7qcA9TAcyJIjUvObB0
        qhaugPYanhC8xlaDCrHgEfwC6zs9jez8hOfcQols5WAkfkOBr7uX9MaErkWe/x+xO7RfhJ5iOYu8W
        MTEhDucjDI0G6xLKhKj9vSy/DBSBAuhJhVj1ugkDB9hQvAz3ng+0qRii1/nP5F3uIcinW90ovbRT4
        tXm4Isog==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2R1S-0006CZ-3C; Fri, 14 Feb 2020 02:48:06 +0000
Date:   Thu, 13 Feb 2020 18:48:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous
 reclaim
Message-ID: <20200214024806.GU7778@bombadil.infradead.org>
References: <20200209074145.31389-1-richardw.yang@linux.intel.com>
 <20200211104223.GL3466@techsingularity.net>
 <20200212022554.GA7855@richard>
 <20200212074333.GM3466@techsingularity.net>
 <20200214020515.GC20833@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214020515.GC20833@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:05:15AM +0800, Wei Yang wrote:
> On Wed, Feb 12, 2020 at 07:43:33AM +0000, Mel Gorman wrote:
> >Broadly speaking it was driven by cases whereby kswapd either a) fell
> >asleep prematurely and there were many stalls in direct reclaim before
> >kswapd recovered, b) stalls in direct reclaim immediately after kswapd went
> >to sleep or c) kswapd reclaimed for lower zones and went to sleep while
> >parallel tasks were direct reclaiming in higher zones or higher orders.
> 
> Thanks for your explanation. I am trying to understand the connection between
> those cases and the behavior of kswapd.
> 
> In summary, all three cases are related to direct reclaim, while happens in
> three different timing of kswapd:

Reclaim performed by kswapd is the opposite of direct reclaim.  Direct
reclaim is reclaim initiated by a task which is trying to allocate memory.
If a task cannot perform direct reclaim itself, it may ask kswapd to
attempt to reclaim memory for it.

