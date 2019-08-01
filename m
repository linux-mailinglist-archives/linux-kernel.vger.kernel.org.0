Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63DC7DF85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfHAPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:55:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732210AbfHAPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j1z5Xw/GaBu27mqAddqi93C7PEHRo5nDH2mrdXzVFtA=; b=E40+ASyOxDOaeu1RcYSMadQyg
        VKx9gNHuM2B1KNAncq9C3BDjDso5QiCMNc3PpKKK1XrDDL4WcrhTq38NO7wZfmWlkMiA+45hLGlo2
        XJq1KicV2i/srM36Kb4GoxA8LKWcGJs45/ZwS5JdIlpUcQuPpONqOhDxTMTL8SDiIL7DtSp7+5QwO
        mZwmBr8PQdCtY+pIvQdo4qX7AdZFUULK7+NNWfeieEoPv4vji/gu/9LTNIMakq4LOJRdHhcQoumTw
        galvGxK6LPW03YBBIiW9kZZ9x04PLmtqW+zPOlYAwNBqV3VWOHLGrMayERi11o0mh00GBoC05Tc45
        RTZBD7OxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htDQc-0008WK-7r; Thu, 01 Aug 2019 15:55:42 +0000
Date:   Thu, 1 Aug 2019 08:55:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yu Zhao <yuzhao@google.com>, trivial@kernel.org
Subject: Re: [PATCH] mm: fix typo in comment
Message-ID: <20190801155542.GJ4700@bombadil.infradead.org>
References: <1564674454-22469-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564674454-22469-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:47:34AM -0400, Joel Savitz wrote:
> Fix spelling of successful (currently spelled successfull in kernel
> source)

If you're going to bother fixing the spelling, may as well fix the grammar
at the same time.

>  	/*
> -	 * The full zone was compacted scanned but wasn't successfull to compact
> +	 * The full zone was compacted scanned but wasn't successful to compact
>  	 * suitable pages.
>  	 */

... actually, I don't know what is meant here.  Could it mean:

	/*
	 * The full zone was scanned for compaction, but didn't produce
	 * suitable pages.
	 */

>  	/*
> -	 * direct compaction has scanned part of the zone but wasn't successfull
> +	 * direct compaction has scanned part of the zone but wasn't successful
>  	 * to compact suitable pages.

	 * Zone compaction had to stop before scanning the full zone, and
	 * no suitable pages were produced.

