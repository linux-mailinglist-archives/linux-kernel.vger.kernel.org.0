Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1921A8BC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfHMPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:05:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37269 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfHMPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:05:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id f22so4373586edt.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YBSl0CajXoJyFM4Tub0QYu+W5pFIdDgKxAj7ER66uso=;
        b=CoHvU737VmfI3oyKN9MCpGf41kCR7rP/pY9yfa23wZpIf0qFmlKeUvc5sSqdX5B4WR
         GzWCwDjS9Yua8l4RxBlV7wJMf45Yh1LGwk6LBE0I2YpAPeUKTrEr8erv6VvUcJFdj+J9
         AjmmzsfmiTSjvY4Gi91rG3IEc0RHtxXgsiyEITtEoH9C3NCjAKzWoeDOpWLzBCPJ3I/q
         sYP86EKwkl5LHY2z7PJ6LejarajSyhSWLOCxt3cbTMblW8Z6NGSUFx2qXFi+T7pHTHWa
         K0Lu0IunLkAZpkYPM4J2kS9STY2Q2RfUnhxAgKndQLFkYHfSgec0+IdcyZE7Oh9HxYkS
         abiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YBSl0CajXoJyFM4Tub0QYu+W5pFIdDgKxAj7ER66uso=;
        b=PYW/cdlr1XzZH5h3aR/MG5MDXFSQNBuApTz12556xv8b2Aeq7XPUD66BpCsEYXzSnL
         /pwVZp4T5UmE9PaqxXfh4pinskbmgAjGpjcy8p2ffQy01EY6ZBqME0RHnLDWDFotlegg
         Lq0iSODadteirwWev1EH5dODftWWaHQDkm9kEsQxWZFULpOLni/Hlr0yFWl1K+Hvd/Co
         w5Li9XEWOC6M9scc2lMgUZ42SbHUkTIkMeXBtGCoNMeT+NhFpAQV1rPhQ45tKrKUWZaM
         PtV/AsyJnbuy7oNIXcib9eH1CVj/o5IoAZIMOqdVKzJyEqpHMsIOMlGLfFjPLlgmi0Ze
         Ki6w==
X-Gm-Message-State: APjAAAW2sehMXQFZhLuO9OsP/dcIbe65a7JStlFVVqmFaUbs2VWPVz/B
        3Vq1QruNqOgeANoAO8m9Dm9JLw==
X-Google-Smtp-Source: APXvYqwO45W8ArYTmQ7sk2TTXpXhzScDUzYYDs7QsdxWgDQpeMS0VNgTre2qyBnj9dzT2yH0zd4cuw==
X-Received: by 2002:aa7:d1c7:: with SMTP id g7mr3540552edp.227.1565708740258;
        Tue, 13 Aug 2019 08:05:40 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w13sm17886231eji.22.2019.08.13.08.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 08:05:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 812BE100854; Tue, 13 Aug 2019 18:05:39 +0300 (+03)
Date:   Tue, 13 Aug 2019 18:05:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Message-ID: <20190813150539.ciai477wk2cratvc@box>
References: <20190808163303.GB7934@redhat.com>
 <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
 <20190809152404.GA21489@redhat.com>
 <3B09235E-5CF7-4982-B8E6-114C52196BE5@fb.com>
 <4D8B8397-5107-456B-91FC-4911F255AE11@fb.com>
 <20190812121144.f46abvpg6lvxwwzs@box>
 <20190812132257.GB31560@redhat.com>
 <20190812144045.tkvipsyit3nccvuk@box>
 <20190813133034.GA6971@redhat.com>
 <20190813140552.GB6971@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813140552.GB6971@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 04:05:53PM +0200, Oleg Nesterov wrote:
> On 08/13, Oleg Nesterov wrote:
> >
> > On 08/12, Kirill A. Shutemov wrote:
> > >
> > > On Mon, Aug 12, 2019 at 03:22:58PM +0200, Oleg Nesterov wrote:
> > > > On 08/12, Kirill A. Shutemov wrote:
> > > > >
> > > > > On Fri, Aug 09, 2019 at 06:01:18PM +0000, Song Liu wrote:
> > > > > > +		if (pte_none(*pte) || !pte_present(*pte))
> > > > > > +			continue;
> > > > >
> > > > > You don't need to check both. Present is never none.
> > > >
> > > > Agreed.
> > > >
> > > > Kirill, while you are here, shouldn't retract_page_tables() check
> > > > vma->anon_vma (and probably do mm_find_pmd) under vm_mm->mmap_sem?
> > > >
> > > > Can't it race with, say, do_cow_fault?
> > >
> > > vma->anon_vma can race, but it doesn't matter. False-negative is fine.
> > > It's attempt to avoid taking mmap_sem where it can be not productive.
> >
> > I guess I misunderstood the purpose of this check or your answer...
> >
> > Let me reword my question. Why can retract_page_tables() safely do
> > pmdp_collapse_flush(vma) without additional checks similar to what
> > collapse_pte_mapped_thp() does?
> >
> > I thought that retract_page_tables() checks vma->anon_vma to ensure that
> > this vma doesn't have a cow'ed PageAnon() page. And I still can't understand
> > why can't it race with __handle_mm_fault() paths.

vma->anon_vma check is a cheap way to exclude MAP_PRIVATE mappings that
got written from userspace. My thinking was that these VMAs are not worth
investing down_write(mmap_sem) as PMD-mapping is likely to be split later.
(It's totally made up reasoning, I don't have numbers to back it up).

vma->anon_vma can be set up after the check but before taking mmap_sem.
But page lock would prevent establishing any new ptes of the page, so we
are safe.

An alternative would be drop the check, but check that page table is clear
before calling pmdp_collapse_flush() under ptl. It has higher chance to
recover THP for the VMA, but has higher cost too.

I don't know which way is better, so I've chosen which is easier to
implement.

> >
> > Suppose that shmem_file was mmaped with PROT_READ|WRITE, MAP_PRIVATE.
> > To simplify, suppose that a non-THP page was already faulted in,
> > pte_present() == T.
> >
> > Userspace writes to this page.
> >
> > Why __handle_mm_fault()->handle_pte_fault()->do_wp_page()->wp_page_copy()
> > can not cow this page and update pte after the vma->anon_vma chech and
> > before down_write_trylock(mmap_sem) ?
> 
> OK, probably this is impossible, collapse_shmem() does unmap_mapping_pages(),
> so handle_pte_fault() will call shmem_fault() which iiuc should block in
> find_lock_entry() because new_page is locked, and thus down_write_trylock()
> can't succeed.

You've got it right.

> Nevermind, I am sure I missed something. Perhaps you can update the comments
> to make this more clear.

Let me see first that my explanation makes sense :P

-- 
 Kirill A. Shutemov
