Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE94B6E0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 08:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGSGNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 02:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSGNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08C04B07D;
        Fri, 19 Jul 2019 06:13:15 +0000 (UTC)
Date:   Fri, 19 Jul 2019 08:13:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, toshi.kani@hpe.com, rppt@linux.ibm.com,
        richardw.yang@linux.intel.com, pasha.tatashin@soleen.com,
        osalvador@suse.de, logang@deltatee.com, jmoyer@redhat.com,
        jglisse@redhat.com, jgg@mellanox.com, jane.chu@oracle.com,
        hch@lst.de, david@redhat.com, corbet@lwn.net, cai@lca.pw,
        aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [patch 23/38] mm/sparsemem: introduce struct mem_section_usage
Message-ID: <20190719061313.GI30461@dhcp22.suse.cz>
References: <20190718225757.ndUBg%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718225757.ndUBg%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 15:57:57, Andrew Morton wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> Subject: mm/sparsemem: introduce struct mem_section_usage
> 
> Patch series "mm: Sub-section memory hotplug support", v10.

Has this been properly reviewed after the last rebase and is this
actually ready for merging? I have seen some follow up fixes
http://lkml.kernel.org/r/20190715081549.32577-1-osalvador@suse.de
and do not see those patches being in the pipe line. Or have they been
merged?
-- 
Michal Hocko
SUSE Labs
