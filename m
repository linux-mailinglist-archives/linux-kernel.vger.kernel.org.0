Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC4DEBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfJUMQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 08:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727344AbfJUMQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:16:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2616EADE4;
        Mon, 21 Oct 2019 12:16:37 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:16:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge() check
Message-ID: <20191021121636.GL9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-2-osalvador@suse.de>
 <20191018114832.GK5017@dhcp22.suse.cz>
 <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 07:00:46, Naoya Horiguchi wrote:
> On Fri, Oct 18, 2019 at 01:48:32PM +0200, Michal Hocko wrote:
> > On Thu 17-10-19 16:21:08, Oscar Salvador wrote:
> > > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > 
> > > Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
> > > for hugetlb pages.
> > > 
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > 
> > s-o-b chain is reversed.
> > 
> > The code is a bit confusing. Doesn't this check aim for THP?
> 
> No, PageHuge() is false for thp, so this if branch is just dead code.
> 
> > AFAICS
> > PageTransHuge(hpage) will split the THP or fail so PageTransHuge
> > shouldn't be possible anymore, right?
> 
> Yes, that's right.
> 
> > But why does hwpoison_user_mappings
> > still work with hpage then?
> 
> hwpoison_user_mappings() is called both from memory_failure() and
> from memory_failure_hugetlb(), so it need handle both cases.

Thanks for the clarification. Maybe the changelog could be more explicit
because the code is quite confusing.
-- 
Michal Hocko
SUSE Labs
