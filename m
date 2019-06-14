Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC26458AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFNJcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 05:32:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45475 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfFNJcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:32:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F075D227A82; Fri, 14 Jun 2019 11:32:18 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:32:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@snapgear.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 m68knommu tree
Message-ID: <20190614093218.GA17214@lst.de>
References: <20190614190606.559dc8dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614190606.559dc8dc@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:06:06PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   fs/binfmt_flat.c
> 
> between commit:
> 
>   6071ecd874ac ("binfmt_flat: add endianess annotations")
> 
> from the m68knommu tree and commit:
> 
>   db543c385059 ("fs/binfmt_flat.c: remove set but not used variable 'inode'")

Maybe this should better be added to the maintainer tree as well..
