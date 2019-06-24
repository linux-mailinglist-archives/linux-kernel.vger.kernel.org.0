Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04C51A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbfFXSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 14:05:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728106AbfFXSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 991B3ABD4;
        Mon, 24 Jun 2019 18:05:55 +0000 (UTC)
Message-ID: <1561399554.3073.10.camel@suse.de>
Subject: Re: [PATCH v10 08/13] mm/sparsemem: Prepare for sub-section ranges
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 20:05:54 +0200
In-Reply-To: <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 22:52 -0700, Dan Williams wrote:
> Prepare the memory hot-{add,remove} paths for handling sub-section
> ranges by plumbing the starting page frame and number of pages being
> handled through arch_{add,remove}_memory() to
> sparse_{add,remove}_one_section().
> 
> This is simply plumbing, small cleanups, and some identifier renames.
> No
> intended functional changes.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I already gave my Reviewed-by in the previous version:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
