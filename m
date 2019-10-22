Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B1DFED9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfJVIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:00:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfJVIAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:00:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51494B872;
        Tue, 22 Oct 2019 08:00:02 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:00:00 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022075959.GD19060@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191021074533.GA10507@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021074533.GA10507@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:45:33AM +0000, Naoya Horiguchi wrote:
> > +extern bool take_page_off_buddy(struct page *page);
> > +
> > +static void page_handle_poison(struct page *page)
> 
> hwpoison is a separate idea from page poisoning, so maybe I think
> it's better to be named like page_handle_hwpoison().

Yeah, that sounds better.
 
> BTW, if we consider to make unpoison mechanism to keep up with the
> new semantics, we will need the reverse operation of take_page_off_buddy().
> Do you think that that part will come with a separate work?

Well, I am not really sure.
Since we grab a refcount in page_handle_poison, all unpoison mechanism does
is a "put_page", that should send the page back to buddy/pcp lists.
I did not spot any problem when testing it, but I will double check.

Thanks Naoya.

-- 
Oscar Salvador
SUSE L3
