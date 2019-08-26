Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90809CDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfHZLOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 07:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbfHZLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19094ABB2;
        Mon, 26 Aug 2019 11:14:16 +0000 (UTC)
Date:   Mon, 26 Aug 2019 13:14:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: poisoned pages do not play well in the buddy allocator
Message-ID: <20190826111414.GG7538@dhcp22.suse.cz>
References: <20190826104144.GA7849@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826104144.GA7849@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-08-19 12:41:50, Oscar Salvador wrote:
[...]
> I checked [1], and it seems that [2] was going towards fixing this kind of issue.
> 
> I think it is about time to revamp the whole thing.

I completely agree. The current state of hwpoison is just too fragile to
be practically usable. We keep getting bug reports (as pointed out by
Oscar) when people try to test this via soft offlining. 

> @Naoya: I could give it a try if you are busy.

That would be more than appreciated. I feel guilty to have it slip
between cracks but I simply couldn't have found enough time to give it a
serious look. Sorry about that.

> [1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] https://lore.kernel.org/linux-mm/1541746035-13408-9-git-send-email-n-horiguchi@ah.jp.nec.com/

-- 
Michal Hocko
SUSE Labs
