Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F902FF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfE3PlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:41:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:55296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3PlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:41:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADB58AFE7;
        Thu, 30 May 2019 15:41:21 +0000 (UTC)
Date:   Thu, 30 May 2019 17:41:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] How to get task_struct from mm
Message-ID: <20190530154119.GF6703@dhcp22.suse.cz>
References: <5cf71366-ba01-8ef0-3dbd-c9fec8a2b26f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf71366-ba01-8ef0-3dbd-c9fec8a2b26f@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-05-19 14:57:46, Yang Shi wrote:
> Hi folks,
> 
> 
> As what we discussed about page demotion for PMEM at LSF/MM, the demotion
> should respect to the mempolicy and allowed mems of the process which the
> page (anonymous page only for now) belongs to.

cpusets memory mask (aka mems_allowed) is indeed tricky and somehow
awkward.  It is inherently an address space property and I never
understood why we have it per _thread_. This just doesn't make any
sense to me. This just leads to weird corner cases. What should happen
if different threads disagree about the allocation affinity while
working on a shared address space?
 
> The vma that the page is mapped to can be retrieved from rmap walk easily,
> but we need know the task_struct that the vma belongs to. It looks there is
> not such API, and container_of seems not work with pointer member.

I do not think this is a good idea. As you point out in the reply we
have that for memcgs but we really hope to get rid of mm->owner there
as well. It is just more tricky there. Moreover such a reverse mapping
would be incorrect. Just think of a disagreeing yet overlapping cpusets
for different threads mapping the same page.

Is it such a big deal to document that the node migrate is not
compatible with cpusets?
-- 
Michal Hocko
SUSE Labs
