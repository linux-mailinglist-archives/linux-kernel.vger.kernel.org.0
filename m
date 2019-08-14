Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09CB8D7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfHNQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:15:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42240 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:15:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m44so7546072edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8o9aIlCo3mpiOSnSj5arXqF2puBzCrXsQ6oC+NpAyV0=;
        b=tZ+HKRJpMp6FIVMsf7o5+PbNE/FCT6+0SQQSCPqVFcw1JwdH2wCsxVa74p7WBEgC5g
         jrVqSX3R/MWO7Tm8mrkP0X4znPQCXJ9JFxA887NEMRpu4J/KM9Tr+L1chHpnjsFShhfD
         kjqzrNxc68sHtN/8jLDDY1fyH2axmJPwxAWrFyrSfuoGL7mRWlJXFROYkaaNWvZWFGUU
         IdyQ+CskuJCoE+TM3+Af8bUT3Cv0tMVgwlsDId56+UTv9IGyeT1AlWgcdmRwFPZXs/qC
         5OJDP0G7gku518XBm35mFw6VAQojAFdgZwmVunnsc8tGwgo7C51wCDlI0JIKZH94IBar
         zRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8o9aIlCo3mpiOSnSj5arXqF2puBzCrXsQ6oC+NpAyV0=;
        b=nwKELMgpQ/NBHTC8QGWHYIUu37GLB8XJ3VP9A42/PzvijA7wRYMRoHAh4RS/XOKDoG
         ShgLxMoxwLcTABB8C9lqPg0Gh7xX5CKOb6tYnJypRurkY4YQyM0W7WbNr6aXy2cQCrEY
         +cgpgwDJ7MIxIbN3jCYTh6eL0u50qrkseGZpmSmlHI3EKG3apRoVqO7IXw2SS0ngfATQ
         sgwcLgz4BGjOuCcLbGtUnosXlFuFVtHTS1UX6w01cIznJ0nwdvDK4ErN/10ySgtmQmbP
         zWtSq31ebTDC99Lc8yIT44UeBFwT/WKlvUSNujfRgZX2lIZrxZgD4BBwz7O3gzee5mYO
         KsGQ==
X-Gm-Message-State: APjAAAXZa7tli8LUW+u6C2ltgA1JY7C7c0UcWeGy5DedJMrYQbP/JT5W
        7ULsO4W+IqbcJuW9zNXHFWs=
X-Google-Smtp-Source: APXvYqxF+Mu09EjcK1cYN7o4EzQDOnpp2ECuyGdYpYyTAKemcC9zcK2q6cKF2FOFqzmjJ8+JqHjp1A==
X-Received: by 2002:a50:b3cb:: with SMTP id t11mr374805edd.203.1565799343284;
        Wed, 14 Aug 2019 09:15:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e24sm11734ejb.53.2019.08.14.09.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 09:15:42 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:15:41 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/5] resource: Use PFN_UP / PFN_DOWN in
 walk_system_ram_range()
Message-ID: <20190814161541.ho5b6ju4t23vruff@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190814154109.3448-1-david@redhat.com>
 <20190814154109.3448-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814154109.3448-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:41:05PM +0200, David Hildenbrand wrote:
>This makes it clearer that we will never call func() with duplicate PFNs
>in case we have multiple sub-page memory resources. All unaligned parts
>of PFNs are completely discarded.
>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Borislav Petkov <bp@suse.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Bjorn Helgaas <bhelgaas@google.com>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: Nadav Amit <namit@vmware.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Acked-by: Michal Hocko <mhocko@suse.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> kernel/resource.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index 7ea4306503c5..88ee39fa9103 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -487,8 +487,8 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> 	while (start < end &&
> 	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
> 				    false, &res)) {
>-		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
>-		end_pfn = (res.end + 1) >> PAGE_SHIFT;
>+		pfn = PFN_UP(res.start);
>+		end_pfn = PFN_DOWN(res.end + 1);
> 		if (end_pfn > pfn)
> 			ret = (*func)(pfn, end_pfn - pfn, arg);
> 		if (ret)
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me
