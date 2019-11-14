Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C534FC0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfKNHX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 02:23:58 -0500
Received: from verein.lst.de ([213.95.11.211]:37939 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:23:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8459568AFE; Thu, 14 Nov 2019 08:23:54 +0100 (CET)
Date:   Thu, 14 Nov 2019 08:23:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191114072354.GA26448@lst.de>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com> <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com> <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:47:38PM -0800, Dan Williams wrote:
> > Got it. This will appear in the next posted version of my "mm/gup: track
> > dma-pinned pages: FOLL_PIN, FOLL_LONGTERM" patchset.
> 
> Thanks!

John - can you please send a small series just doing the zone device
patches rework?  That way we can review it separately and maybe even get
it into 5.5.
