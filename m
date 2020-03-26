Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB72193DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 12:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 07:33:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgCZLdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:33:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221407FA;
        Thu, 26 Mar 2020 04:33:53 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48D713F71F;
        Thu, 26 Mar 2020 04:33:52 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:33:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/mremap: Add comment explaining the untagging
 behaviour of mremap()
Message-ID: <20200326113349.GB26987@mbp>
References: <20200325111347.32553-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325111347.32553-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:13:46AM +0000, Will Deacon wrote:
> Commit dcde237319e6 ("mm: Avoid creating virtual address aliases in
> brk()/mmap()/mremap()") changed mremap() so that only the 'old' address
> is untagged, leaving the 'new' address in the form it was passed from
> userspace. This prevents the unexpected creation of aliasing virtual
> mappings in userspace, but looks a bit odd when you read the code.
> 
> Add a comment justifying the untagging behaviour in mremap().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will@kernel.org>

I queued this patch via the arm64 tree (for 5.7-rc1). Thanks.

-- 
Catalin
