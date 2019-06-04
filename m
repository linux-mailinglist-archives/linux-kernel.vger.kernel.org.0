Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B74346EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfFDMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 08:35:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbfFDMfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:35:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07CE9AFD1;
        Tue,  4 Jun 2019 12:35:53 +0000 (UTC)
Date:   Tue, 4 Jun 2019 14:35:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190604123551.GI4669@dhcp22.suse.cz>
References: <20190524173656.8339-1-ira.weiny@intel.com>
 <20190527150107.GG1658@dhcp22.suse.cz>
 <20190529035618.GA21745@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529035618.GA21745@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 20:56:19, Ira Weiny wrote:
> Would you like to roll a V3 with some of this in the commit
> message?

Yes please. I will re-read the whole changelog and let's see whether I
can make more sense of it.

Thanks!
-- 
Michal Hocko
SUSE Labs
