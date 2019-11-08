Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B768DF42F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfKHJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 04:18:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfKHJSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:18:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BBD5B216;
        Fri,  8 Nov 2019 09:18:53 +0000 (UTC)
Date:   Fri, 8 Nov 2019 10:18:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Message-ID: <20191108091851.GB15658@dhcp22.suse.cz>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-11-19 00:08:03, Toshiki Fukasawa wrote:
> This patch set tries to make pfn walker support ZONE_DEVICE.
> This idea is from the TODO in below patch:
> 
>   commit aad5f69bc161af489dbb5934868bd347282f0764
>   Author: David Hildenbrand <david@redhat.com>
>   Date:   Fri Oct 18 20:19:20 2019 -0700
> 
> 	fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c
> 
> pfn walker's ZONE_DEVICE support requires capability to identify
> that a memmap has been initialized. The uninitialized cases are 
> as follows:
> 
> 	a) pages reserved for ZONE_DEVICE driver
> 	b) pages currently initializing
> 
> This patch set solves both of them.

Why do we want this? What is the usecase?

> 
> Toshiki Fukasawa (3):
>   procfs: refactor kpage_*_read() in fs/proc/page.c
>   mm: Introduce subsection_dev_map
>   mm: make pfn walker support ZONE_DEVICE
> 
>  fs/proc/page.c           | 155 ++++++++++++++++++++---------------------------
>  include/linux/memremap.h |   6 ++
>  include/linux/mmzone.h   |  19 ++++++
>  mm/memremap.c            |  31 ++++++++++
>  mm/sparse.c              |  32 ++++++++++
>  5 files changed, 154 insertions(+), 89 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
