Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46744F1207
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfKFJWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 04:22:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfKFJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:22:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82F36AC8C;
        Wed,  6 Nov 2019 09:22:09 +0000 (UTC)
Date:   Wed, 6 Nov 2019 10:22:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, yuqi jin <jinyuqi@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
Message-ID: <20191106092208.GE8314@dhcp22.suse.cz>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191105070141.GF22672@dhcp22.suse.cz>
 <20191105173359.39052327cf221d9c4b26b783@linux-foundation.org>
 <20191106071742.GB8314@dhcp22.suse.cz>
 <f8f1bce1-4503-4da0-71ea-6fd12fcd687a@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f1bce1-4503-4da0-71ea-6fd12fcd687a@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 16:02:29, Shaokun Zhang wrote:
> Hi Michal,
> 
> On 2019/11/6 15:17, Michal Hocko wrote:
> > On Tue 05-11-19 17:33:59, Andrew Morton wrote:
> >> On Tue, 5 Nov 2019 08:01:41 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >>> On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
> >>>> From: yuqi jin <jinyuqi@huawei.com>
> >>>>
> >>>> In the multi-processor and NUMA system, I/O device may have many numa
> >>>> nodes belonging to multiple cpus. When we get a local numa, it is
> >>>> better to find the node closest to the local numa node, instead
> >>>> of choosing any online cpu immediately.
> >>>>
> >>>> For the current code, it only considers the local NUMA node and it
> >>>> doesn't compute the distances between different NUMA nodes for the
> >>>> non-local NUMA nodes. Let's optimize it and find the nearest node
> >>>> through NUMA distance. The performance will be better if it return
> >>>> the nearest node than the random node.
> >>>
> >>> Numbers please
> >>
> >> The changelog had
> >>
> >> : When Parameter Server workload is tested using NIC device on Huawei
> >> : Kunpeng 920 SoC:
> >> : Without the patch, the performance is 22W QPS;
> >> : Added this patch, the performance become better and it is 26W QPS.
> > 
> > Maybe it is just me but this doesn't really tell me a lot. What is
> > Parameter Server workload? What do I do to replicate those numbers? Is
> 
> I will give it better description on it in next version. Since it returns
> the nearest node from the non-local node than the random one, no harmless
> to others, Right?

Well, I am not really familiar with consumers of this API to understand
the full consequences and that is why I keep asking. From a very
highlevel POV prefering CPUs on the same NUMA domain sounds like a
reasonable thing to do.
-- 
Michal Hocko
SUSE Labs
