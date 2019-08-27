Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262809DEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfH0H2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:28:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfH0H2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:28:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4061AE4B;
        Tue, 27 Aug 2019 07:28:15 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:28:13 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: poisoned pages do not play well in the buddy allocator
Message-ID: <20190827072808.GA17746@linux>
References: <20190826104144.GA7849@linux>
 <20190827013429.GA5125@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827013429.GA5125@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:34:29AM +0000, Naoya Horiguchi wrote:
> > @Naoya: I could give it a try if you are busy.
> 
> Thanks for raising hand. That's really wonderful. I think that the series [1] is not
> merge yet but not rejected yet, so feel free to reuse/update/revamp it.

I will continue pursuing this then :-).

Thanks Naoya!

-- 
Oscar Salvador
SUSE L3
