Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8E8A978
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLVhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfHLVhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:37:33 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FB2206C1;
        Mon, 12 Aug 2019 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565645852;
        bh=07tJJiA2VR08JnF9uwMOoDCaKsZwYqGb2v9SvApZzMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xHPKjAQr8eR3Ys5t2F8n8lhJx/sQg6Qgi3Km8sf0/tf137IyaQhuxWflV6htZbHui
         kpSIg+UULX+BoKkMpAo+Sx8XyPE8Jl/KJ3HJq7Aevp+VoNDiBBFPV+L4dhqxK59Toh
         kUg/XzZ9wWOiMo6oYMgEAxSGz3yUuPiS3S+nDnYg=
Date:   Mon, 12 Aug 2019 14:37:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
Message-Id: <20190812143731.3f46b952e53ff3434e04bcf9@linux-foundation.org>
In-Reply-To: <20190812153326.GB17747@sasha-vm>
References: <20190808074736.GJ11812@dhcp22.suse.cz>
        <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
        <20190808185313.GG18351@dhcp22.suse.cz>
        <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
        <20190809064633.GK18351@dhcp22.suse.cz>
        <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
        <20190811234614.GZ17747@sasha-vm>
        <20190812084524.GC5117@dhcp22.suse.cz>
        <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
        <20190812132226.GI5117@dhcp22.suse.cz>
        <20190812153326.GB17747@sasha-vm>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 11:33:26 -0400 Sasha Levin <sashal@kernel.org> wrote:

> >I thought that absence of the Cc is the indication :P. Anyway, I really
> >do not understand why should we bother, really. I have tried to explain
> >that stable maintainers should follow Cc: stable because we bother to
> >consider that part and we are quite good at not forgetting (Thanks
> >Andrew for persistence). Sasha has told me that MM will be blacklisted
> >from automagic selection procedure.
> 
> I'll add mm/ to the ignore list for AUTOSEL patches.

Thanks, I'm OK with that.  I'll undo Fixes-no-stable.

Although I'd prefer that "akpm" was ignored, rather than "./mm/". 
Plenty of "mm" patches don't touch mm/, such as drivers/base/memory.c,
include/linux/blah, fs/, etc.  And I am diligent about considering
-stable for all the other code I look after.

This doesn't mean that I'm correct all the time, by any means - I'd
like to hear about patches which autosel thinks should be backported
but which don't include the c:stable tag.

