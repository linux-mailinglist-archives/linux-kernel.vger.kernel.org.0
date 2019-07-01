Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC88D128F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfECHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfECHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C23D3AE0F;
        Fri,  3 May 2019 07:37:45 +0000 (UTC)
Date:   Fri, 3 May 2019 09:37:42 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/12] mm/hotplug: Kill is_dev_zone() usage in
 __remove_pages()
Message-ID: <20190503073742.GC15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677655373.2336373.15845721823034005000.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155677655373.2336373.15845721823034005000.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:55:53PM -0700, Dan Williams wrote:
> The zone type check was a leftover from the cleanup that plumbed altmap
> through the memory hotplug path, i.e. commit da024512a1fa "mm: pass the
> vmem_altmap to arch_remove_memory and __remove_pages".
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
