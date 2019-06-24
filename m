Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B951A34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfFXSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 14:00:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbfFXSA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:00:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2569EAEFF;
        Mon, 24 Jun 2019 18:00:56 +0000 (UTC)
Message-ID: <1561399254.3073.7.camel@suse.de>
Subject: Re: [PATCH v10 05/13] mm/sparsemem: Convert
 kmalloc_section_memmap() to populate_section_memmap()
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 20:00:54 +0200
In-Reply-To: <156092352058.979959.6551283472062305149.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156092352058.979959.6551283472062305149.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 22:52 -0700, Dan Williams wrote:
> Allow sub-section sized ranges to be added to the memmap.
> populate_section_memmap() takes an explict pfn range rather than
> assuming a full section, and those parameters are plumbed all the way
> through to vmmemap_populate(). There should be no sub-section usage
> in
> current deployments. New warnings are added to clarify which memmap
> allocation paths are sub-section capable.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
