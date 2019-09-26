Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FABF997
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfIZSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 14:50:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfIZSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nIyHvTAGG0PPPrIhutULDQfPFwJtw5CYsA3zaxkj3L8=; b=S/xebOxpZka6SndPedzCpkcQA
        0NRBrkthjEKisbOCOwOYzzgOGCimxUOivqG0DqCdghGTyAZGcN/94sgodc9nKolMxvAovO10iFD8f
        79ATXYTEbb9HzzSaBP0OGDM4N8eGjqwB5L027rM/vrfiP411u+GzjpeMkLy6mYraN51PxlNKsRQ/E
        Bgtseu8P/hYASY9aQhhvkxODL9dtYaX/KhGuZEbhYd+p7Jk5nP6qYwfLdc68NR7dZcaJYolF0NMIO
        TqTRt7esK/uWlvyXxyPArwTtW5ld9POZrYh6O3HzwwsNIuSTMlRmoOrTReimeWXdnI7SPrvGnKzF2
        /JgWZKscA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDYqK-0006mv-0s; Thu, 26 Sep 2019 18:50:20 +0000
Date:   Thu, 26 Sep 2019 11:50:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190926185019.GA2147@bombadil.infradead.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
 <20190924204608.GI1855@bombadil.infradead.org>
 <20190924214337.GA17405@cmpxchg.org>
 <20190926134923.wqlkymjdfxd4iymh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926134923.wqlkymjdfxd4iymh@box>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 04:49:23PM +0300, Kirill A. Shutemov wrote:
> It happens if the VMA got unmapped under us while we dropped mmap_sem
> and inode got freed.
> 
> Pinning the file if we drop mmap_sem fixes the issue.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
