Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5F165BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBTKix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:38:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgBTKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:38:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id e8so4029676wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ht1b2Gn12WUgyUngBOy6cF6YFNd2DyC26HhQ0+Z/imw=;
        b=pPvECpqze1JTo8iFOWJcZyZvIn/nlzyOtmaTANlaqersOdPXTtBU7HNjYhvDufZiYg
         uySVBkzB4oK99LagzHeWtvlR90brmTTL/rdv+ipRQSzB1wmb0G8pfgHBcVyuFm+dcekH
         5tMBSVZlJA43YH7iIPLyo9jshQ2R4Wl7Wjm+0mbR7gaYVKvf0ZWWSdL1JfPd2juQnUmq
         ZHcklZjSK3VX4EAKHwqAqLwpe1Elp0tOVI3McoRPcfNpcsQB+m3qrwiAo1rABZUPUg1k
         K7+kcP9sfHVLddDGRJomaoyzBCCQQ6dV0cKWoUPKR+BiNJx1WGuB05/0FtkCcLFnn8AW
         GqHQ==
X-Gm-Message-State: APjAAAUIc81lazLVxD1/Zkr+6Q/NHE3c+y1UNpbnbyCFqxxsDVKuVizI
        DJ8QJG8wUbx1OjiILzwyawA=
X-Google-Smtp-Source: APXvYqx9uGPq79/Y37GnvXyltn1NCMABFOX+xrRpc44HyxfkCeZH95pJYQQfgSCA/8RHbNnLBE0JqQ==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr42913682wrk.101.1582195131500;
        Thu, 20 Feb 2020 02:38:51 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id b17sm4061890wrp.49.2020.02.20.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:38:50 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:38:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200220103849.GG20509@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-02-20 12:33:09, Baoquan He wrote:
> Memory sub-section hotplug was added to fix the issue that nvdimm could
> be mapped at non-section aligned starting address. A subsection map is
> added into struct mem_section_usage to implement it. However, sub-section
> is only supported in VMEMMAP case.

Why? Is there any fundamental reason or just a lack of implementation?
VMEMMAP should be really only an implementation detail unless I am
missing something subtle.

> Hence there's no need to operate
> subsection map in SPARSEMEM|!VMEMMAP case. In this patchset, change
> codes to make sub-section map and the relevant operation only available
> in VMEMMAP case.
> 
> And since sub-section hotplug added, the hot add/remove functionality
> have been broken in SPARSEMEM|!VMEMMAP case. Wei Yang and I, each of us
> make one patch to fix one of the failures. In this patchset, the patch
> 1/7 from me is used to fix the hot remove failure. Wei Yang's patch has
> been merged by Andrew.

Not sure I understand. Are there more issues to be fixed?
>  include/linux/mmzone.h |   2 +
>  mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
>  2 files changed, 127 insertions(+), 53 deletions(-)

Why do we need to add so much code to remove a functionality from one
memory model?
-- 
Michal Hocko
SUSE Labs
