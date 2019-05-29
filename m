Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB742E418
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfE2SJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 14:09:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbfE2SJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BD96AD89;
        Wed, 29 May 2019 18:09:32 +0000 (UTC)
Date:   Wed, 29 May 2019 20:09:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/swap_state.c:170!
Message-ID: <20190529180931.GI18589@dhcp22.suse.cz>
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 22:32:08, Mikhail Gavrilov wrote:
> On Wed, 29 May 2019 at 09:05, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi folks.
> > I am observed kernel panic after update to git tag 5.2-rc2.
> > This crash happens at memory pressing when swap being used.
> >
> > Unfortunately in journalctl saved only this:
> >
> 
> Now I captured better trace.
> 
> : page:ffffd6d34dff0000 refcount:1 mapcount:1 mapping:ffff97812323a689
> index:0xfecec363
> : anon
> : flags: 0x17fffe00080034(uptodate|lru|active|swapbacked)
> : raw: 0017fffe00080034 ffffd6d34c67c508 ffffd6d3504b8d48 ffff97812323a689
> : raw: 00000000fecec363 0000000000000000 0000000100000000 ffff978433ace000
> : page dumped because: VM_BUG_ON_PAGE(entry != page)
> : page->mem_cgroup:ffff978433ace000
> : ------------[ cut here ]------------
> : kernel BUG at mm/swap_state.c:170!

Do you see the same with 5.2-rc1 resp. 5.1?
-- 
Michal Hocko
SUSE Labs
