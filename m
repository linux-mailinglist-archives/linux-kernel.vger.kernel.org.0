Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC03B67C15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfGMVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 17:25:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfGMVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 17:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gSeKyUjR9e/8E6Ail8I9eTrrv33i24P5Ay0IpiUeSuk=; b=n+MOy4uUpRDDKVw797VGean/L
        sLUlmgRNfdhMrcyVN318bqRxqpOqYGP1ql3GAbR51HRE1PO6hWDniUxEovN4bBCID4hZBrBc3/3tW
        1UU8uqKuIEz+vEOchWEaAW/A8YXw7qM+rzkndP83kJeIfXlC5qCWy49VTdHbvS1yp1oKfRPrgWR/G
        CDT6ujKi+a9TkD46YJ6fBfxu4DY2Jsw9TZm6nZ8F3oiGPI0tDKH3KnynKzLyiMjBVkAiYuaSyPo+h
        3acXGDjgf3JYRk4OygMyT6AzThsOMTGJ8ip1m/HH0WmJGNjCt/PYtYOAE4WSxQ2YV0L6/4F3b6lUc
        KgI9MVqCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hmPWf-00081A-1g; Sat, 13 Jul 2019 21:25:49 +0000
Date:   Sat, 13 Jul 2019 14:25:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-ID: <20190713212548.GZ32320@bombadil.infradead.org>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 04:49:04AM +0800, Yang Shi wrote:
> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:

There are lots of places where kmemleak will call kmalloc with
__GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM (including the XArray code, which
is how I know about it).  It needs to be fixed to allow its internal
allocations to fail and return failure of the original allocation as
a consequence.

