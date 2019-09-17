Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF9B579E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfIQVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 17:32:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIQVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CNs6p3CN2rZixC1bXHXk6bkwsrcCvyP5gXyakxApfJE=; b=rGBdWLZbq5+gzJ+jj3XIjjqSn
        GmVIL/s4VgFbdaGepjYSl5ywB6tY9FFcTfM+9QfsRNM+pJtU4+rS0h81SxCEf10skCQ/G7d/bM9Ah
        Moa96U22+2max/iAs7IlP2xMYYKy/7LaF6rFqkg7hBJomVsC3x+l15nq/QABKGQ6j2VoiVltclVQ/
        EWEjyd+fU4wxle7cAfJAAt9SAH7m2xLtxwyi8r0kuGiCfxQ37NEN7wTZqBxyoo/TgzwJ0GzRPnAyb
        QRsxasaJW56EUBXjlLHpgYVfRH1af2oBntCWx9y1UQhGOjAX873ZaGrJnM6/KmEP7vBSrTYtvKMtW
        vV/AKRtwg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAL5A-0005kc-IT; Tue, 17 Sep 2019 21:32:20 +0000
Date:   Tue, 17 Sep 2019 14:32:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] usercopy: Avoid HIGHMEM pfn warning
Message-ID: <20190917213220.GV29434@bombadil.infradead.org>
References: <201909171056.7F2FFD17@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909171056.7F2FFD17@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:00:25AM -0700, Kees Cook wrote:
> When running on a system with >512MB RAM with a 32-bit kernel built with:
> 
> 	CONFIG_DEBUG_VIRTUAL=y
> 	CONFIG_HIGHMEM=y
> 	CONFIG_HARDENED_USERCOPY=y
> 
> all execve()s will fail due to argv copying into kmap()ed pages, and on
> usercopy checking the calls ultimately of virt_to_page() will be looking
> for "bad" kmap (highmem) pointers due to CONFIG_DEBUG_VIRTUAL=y:
> 
> Now we can fetch the correct page to avoid the pfn check. In both cases,
> hardened usercopy will need to walk the page-span checker (if enabled)
> to do sanity checking.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: f5509cc18daa ("mm: Hardened usercopy")
> Cc: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I want to make virt_to_page() do the right thing for kmapped pages,
but that is completely outside the scope of this patch.
