Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706F93138C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfEaRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 13:12:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:30440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfEaRMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:12:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 10:12:33 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2019 10:12:33 -0700
Date:   Fri, 31 May 2019 10:13:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190531171336.GA30649@iweiny-DESK2.sc.intel.com>
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
 <20190530214726.GA14000@iweiny-DESK2.sc.intel.com>
 <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
 <CAFgQCTtVcmLUdua_nFwif_TbzeX5wp31GfTpL6CWmXXviYYLyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtVcmLUdua_nFwif_TbzeX5wp31GfTpL6CWmXXviYYLyw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 07:05:27PM +0800, Pingfan Liu wrote:
> On Fri, May 31, 2019 at 7:21 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> >
> > Rather lightly tested...I've compile-tested with CONFIG_CMA and !CONFIG_CMA,
> > and boot tested with CONFIG_CMA, but could use a second set of eyes on whether
> > I've added any off-by-one errors, or worse. :)
> >
> Do you mind I send V2 based on your above patch? Anyway, it is a simple bug fix.

FWIW please split out the nr_pinned change to a separate patch.

Thanks,
Ira
