Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0597E189442
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRDEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 23:04:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PzFLzrAIPb8vb1w5tYzGMUjV6ca4NOIluo1hMlsRAMQ=; b=bpciFsRT+jfH5/+OquGJNUt3qB
        yOS0v6yucO4VOlAZr/TauBgauTDwcGWJNb6rHNEHXKn5m/7oh9INjAE2LcFpnQ1mkKuCedRlFjGue
        iAnLnCCGLaGHLfo7a4R39N4M9x/5ZQfweVKcziu2nWrv9xMGWshesDwInllaSDah9xM0NdF4BcGSI
        q62ZY3uH8cyz+quEBp/Bgb/1ahyd7tTRE/UPeZ5HFjOhh2VT1bVIfZqVnahSuiqaROh05MewsJszL
        vlHUN14oS8Jr3oDnMd4CPSsFsCn8RWdMZWzIcBGz89F/s3w2zQZGsInaTD9Rgx75VdrbcisGcVbJV
        +/75WmPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEP0G-0002IY-3r; Wed, 18 Mar 2020 03:04:20 +0000
Date:   Tue, 17 Mar 2020 20:04:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200318030420.GH22433@bombadil.infradead.org>
References: <1584500541-46817-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584500541-46817-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:02:20AM +0800, Yang Shi wrote:
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Matthew Wilcox <willy@infradead.org>
> Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

