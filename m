Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13B66338
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 03:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfGLBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 21:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfGLBES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:04:18 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C31E214AF;
        Fri, 12 Jul 2019 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562893458;
        bh=Bo+q0hKf5LxeaSDApUoWhLNtI3MOCrePufeOx5LfW4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eIqKhpReC6BpOSmlhSKbSmEX+UF6UZwoQMoeeqZrA9bz5kt6Fa1wU4ocnSjH69X1g
         +yGG+J0opFVEOtIjbLclYHqZvjMxeT4i+rTawAiYusSoyp3wM8lN4VSx+dRY7HjOjp
         tvdun+s0YcfiReWs+eyaOs5n7rfM1HXSSVq6olg0=
Date:   Thu, 11 Jul 2019 18:04:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sai Charan Sane <s.charan@samsung.com>, mhocko@suse.com,
        tglx@linutronix.de, rppt@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, joe@perches.com,
        miles.chen@mediatek.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/1] mm/page_owner: store page_owner's gfp_mask in
 stackdepot itself
Message-Id: <20190711180417.1358ba8b359f68bbf92cf3c2@linux-foundation.org>
In-Reply-To: <24037235-2174-423f-9055-c6a49aa659e2@suse.cz>
References: <CGME20190607055426epcas5p24d6507b84fab957b8e0881d2ff727192@epcas5p2.samsung.com>
        <1559886798-29585-1-git-send-email-s.charan@samsung.com>
        <24037235-2174-423f-9055-c6a49aa659e2@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 15:51:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 6/7/19 7:53 AM, Sai Charan Sane wrote:
> > Memory overhead of 4MB is reduced by storing gfp_mask in stackdepot along
> > with stacktrace. Stackdepot memory usage increased by ~100kb for 4GB of RAM.
> > 
> > Page owner logs from dmesg:
> > 	Before patch:
> > 		allocated 20971520 bytes of page_ext
> > 	After patch:
> > 		allocated 16777216 bytes of page_ext
> > 
> > Signed-off-by: Sai Charan Sane <s.charan@samsung.com>
> 
> I don't know, this looks like unneeded abuse to me. In the debug
> scenario when someone boots a kernel with page_owner enabled, does 4MB
> out of 4GB RAM really make a difference?

Thanks.  I'll drop this patch.
