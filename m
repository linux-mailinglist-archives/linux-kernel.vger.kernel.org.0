Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65EFC660
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 07:32:41 -0500
Received: from verein.lst.de ([213.95.11.211]:39341 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfKNMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:32:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56E7C68B05; Thu, 14 Nov 2019 13:32:37 +0100 (CET)
Date:   Thu, 14 Nov 2019 13:32:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     jhubbard@nvidia.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191114123237.GA31940@lst.de>
References: <157371938291.3055029.12105459405251950438.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157371938291.3055029.12105459405251950438.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:20:13AM -0800, Dan Williams wrote:
> +	if (count > 1) {
> +		/* still busy */
> +		return;
> +	} else if (count == 0) {
> +		/* only triggered by the dev_pagemap shutdown path */
> +		__put_page(page);
> +		return;
> +	} else if (!is_device_private_page(page)) {
> +		/* notify page idle for dax */
> +		wake_up_var(&page->_refcount);
> +		return;
> +	}

No need for an else after a return.
