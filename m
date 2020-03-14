Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDED185AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 08:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCOHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 03:15:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCOHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jewea45aYiB6s5a1qemOSbdXYRftmqxlJxaA0AoO65U=; b=e7v9xq02aJXSv1wa7j3FndJf1B
        Vt1+VZfg/qba7aCy+1L1IUopJlYXSjGS/FBdD9TRnHdMzR5B2exScz67xhmAxsoevQhOeEsn5ENo6
        +/08M+hMvhh/oe5D5o6mVyxuEzOV1UgKeH1ygmMAQVhkiQtis35E2LOTZ9M1h6WAUfFKcFlKR1yBZ
        Bn5+x9e0CGBQ4HwQ5M4IOpH8codgzAQFy3+t0GHRLLhUG9S848DuQniUUwaa3vJcGDC4PETsvawEJ
        YaAhj0S7FMbCH8kaED28RRlyA9fSdP4lTTVZqgDs8CJMKciaBS2mgCLQO1cjqzKEjUgiDDXvDxmnD
        yPIUMSPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jD9Ec-0008To-1c; Sat, 14 Mar 2020 16:01:58 +0000
Date:   Sat, 14 Mar 2020 09:01:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200314160157.GR22433@bombadil.infradead.org>
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 02:34:35AM +0800, Yang Shi wrote:
> -extern int page_evictable(struct page *page);
> +/*

This seems to be in kernel-doc format already; could you add the extra
'*' so it is added to the fine documentation?

> + * page_evictable - test whether a page is evictable
> + * @page: the page to test
> + *
> + * Test whether page is evictable--i.e., should be placed on active/inactive
> + * lists vs unevictable list.
> + *
> + * Reasons page might not be evictable:
> + * (1) page's mapping marked unevictable
> + * (2) page is part of an mlocked VMA
> + *
> + */
> +static inline int page_evictable(struct page *page)
> +{
> +	int ret;
> +
> +	/* Prevent address_space of inode and swap cache from being freed */
> +	rcu_read_lock();
> +	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
> +	rcu_read_unlock();
> +	return ret;
> +}

This seems like it should return bool ... that might even lead to code
generation improvement.
