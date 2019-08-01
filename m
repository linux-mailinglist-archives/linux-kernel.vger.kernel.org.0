Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7687DE6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfHAPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbfHAPEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D034B30A9234;
        Thu,  1 Aug 2019 15:04:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F0E51992D;
        Thu,  1 Aug 2019 15:04:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Aug 2019 17:04:35 +0200 (CEST)
Date:   Thu, 1 Aug 2019 17:04:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 3/4] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190801150432.GC31538@redhat.com>
References: <20190730052305.3672336-1-songliubraving@fb.com>
 <20190730052305.3672336-4-songliubraving@fb.com>
 <20190730161113.GC18501@redhat.com>
 <1E2B5653-BA85-4A05-9B41-57CF9E48F14A@fb.com>
 <20190731151842.GB25078@redhat.com>
 <04FB43C3-6E2B-4868-B9D5-C00342DA5C6F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04FB43C3-6E2B-4868-B9D5-C00342DA5C6F@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 01 Aug 2019 15:04:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Song Liu wrote:
>
> > On Jul 31, 2019, at 8:18 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Now, I don't understand why do we need pmd_trans_unstable() after
> > split_huge_pmd(huge-zero-pmd), but whatever reason we have, why can't we
> > unify both cases?
> >
> > IOW, could you explain why the path below is wrong?
>
> I _think_ the following patch works (haven't fully tested yet). But I am not
> sure whether this is the best. By separating the two cases, we don't duplicate
> much code. And it is clear that the two cases are handled differently.
> Therefore, I would prefer to keep these separate for now.

I disagree. I think this separation makes the code less readable/understandable.
Exactly because it handles two cases differently and it is absolutely not clear
why.

But I can't argue, please forget.

Oleg.

