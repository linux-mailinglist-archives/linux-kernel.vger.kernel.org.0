Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE69CAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfHZHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:53:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35685 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbfHZHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:53:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so10117101pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efgN+vHmbZbtfSnoe2tJDrmfT0GUhJplIH0aIIOgUwk=;
        b=tjQlQ2ExrfoO855NFAVsXPV0e4T1NSJLC/o6pniiADGzTexVhfkjnj7HMQKTfDabp9
         2VrpOmtAMlfxBTcV5oq3/ef4R19zGKjOvrYi28ZeEgTDLMFABrCXbnBl/A3fkl0pCdHY
         vv4hfU59E5lc5B7WQxqMi2WmlAsIBjDAguGQ1a6wJy4fHD7zvKZMZXdVkmymfrDkwTn5
         By0P8Yfc2fhDL0KAmp1Y24MU1f0mZgM6u3TJAKVyzOAYzckNWVHBe6KXAeZvyUWH4vOf
         CnPTqp67rX2vTBJ8bxYsYiY2uLj2Dqk3bcbw6KN8UbgqtndFk9klGKHWdKr1YQmAVjxp
         iRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efgN+vHmbZbtfSnoe2tJDrmfT0GUhJplIH0aIIOgUwk=;
        b=YE+ehsmMlZJJioSqAkHeJL1QLVl336QGPPpWg2RNw/K2RvnqUN7e2fhFQTmzcfoWmm
         6un0D+15To44eDxAh6Rv2HhK8SF+ENnLsAtiae+BNV31mjAmEYzXiT0jJvluL11dbY3z
         DmpNRDKVnIxaFgi76rUzcktjssCOSSMeJRczMbBWJJ3jW5SmZM8xz/Cgd1RGpJXPaqua
         hK2zpuXrg9BOP2JK3TUNfazUm5wQyqk3Z0OqZ6NhKmYe6rpSQv8PF8/g0ghaQeliyw9T
         yprFqsCHaPFh/FGv6gFI3pM8sAzjvXb9Nd0tgTVFSUmCl2E1rLz5Yfo4WV+5TKOyoTBQ
         lRKQ==
X-Gm-Message-State: APjAAAVk4cqo4P4GFNtIdYoLqKm0XlVuc1JFUluowZ6UFFJtEhxs9Sg9
        BrnK8o4oaQgbf7gPY4lh1w==
X-Google-Smtp-Source: APXvYqyxRtF788S9SAurc3XEByUeMhHgAoa/qAhAeLHGf5p/zj9RyDaDK4+HzzxGKEADZkX1N9VkTQ==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr14929040pgk.102.1566805982049;
        Mon, 26 Aug 2019 00:53:02 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r75sm14966984pfc.18.2019.08.26.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:53:01 -0700 (PDT)
Date:   Mon, 26 Aug 2019 15:52:51 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/migrate: see hole as invalid source page
Message-ID: <20190826075251.GA7486@mypc>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
 <1565078411-27082-2-git-send-email-kernelfans@gmail.com>
 <20190815172222.GD30916@redhat.com>
 <20190816150222.GA10855@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816150222.GA10855@mypc>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:02:22PM +0800, Pingfan Liu wrote:
> On Thu, Aug 15, 2019 at 01:22:22PM -0400, Jerome Glisse wrote:
> > On Tue, Aug 06, 2019 at 04:00:10PM +0800, Pingfan Liu wrote:
> > > MIGRATE_PFN_MIGRATE marks a valid pfn, further more, suitable to migrate.
> > > As for hole, there is no valid pfn, not to mention migration.
> > > 
> > > Before this patch, hole has already relied on the following code to be
> > > filtered out. Hence it is more reasonable to see hole as invalid source
> > > page.
> > > migrate_vma_prepare()
> > > {
> > > 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
> > > 
> > > 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
> > > 		     \_ this condition
> > > }
> > 
> > NAK you break the API, MIGRATE_PFN_MIGRATE is use for 2 things,
> > first it allow the collection code to mark entry that can be
> > migrated, then it use by driver to allow driver to skip migration
> > for some entry (for whatever reason the driver might have), we
> > still need to keep the entry and not clear it so that we can
> > cleanup thing (ie remove migration pte entry).
> Thanks for your kindly review.
> 
> I read the code again. Maybe I miss something. But as my understanding,
> for hole, there is no pte.
> As the current code migrate_vma_collect_pmd()
> {
> 	if (pmd_none(*pmdp))
> 		return migrate_vma_collect_hole(start, end, walk);
> ...
> 	make_migration_entry()
> }
> 
> We do not install migration entry for hole, then no need to remove
> migration pte entry.
> 
> And on the driver side, there is way to migrate a hole. The driver just
> skip it by
> drivers/gpu/drm/nouveau/nouveau_dmem.c: if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
>                                              ^^^^
> Finally, in migrate_vma_finalize(), for a hole,
> 		if (!page) {
> 			if (newpage) {
> 				unlock_page(newpage);
> 				put_page(newpage);
> 			}
> 			continue;
> 		}
> And we do not rely on remove_migration_ptes(page, newpage, false); to
> restore the orignal pte (and it is impossible).
> 
Hello, do you have any comment?

I think most of important, hole does not use the 'MIGRATE_PFN_MIGRATE'
API. Hole has not pte, and there is no way to 'remove migration pte
entry'. Further more, we can know the failure on the source side, no
need to defer it to driver side.

By this way, [3/3] can unify the code.

Thanks,
	Pingfan
