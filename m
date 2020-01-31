Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA914E873
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 06:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAaFcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 00:32:09 -0500
Received: from verein.lst.de ([213.95.11.211]:43036 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgAaFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:32:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E952568B20; Fri, 31 Jan 2020 06:32:07 +0100 (CET)
Date:   Fri, 31 Jan 2020 06:32:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] mm/memremap_pages: Kill unused
 __devm_memremap_pages()
Message-ID: <20200131053207.GC17457@lst.de>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com> <158041476158.3889308.4221100673554151124.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158041476158.3889308.4221100673554151124.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:06:01PM -0800, Dan Williams wrote:
> Kill this definition that was introduced in commit 41e94a851304 ("add
> devm_memremap_pages") add never used.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
