Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8418212F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfECNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:36:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfECNgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:36:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60812ABE1;
        Fri,  3 May 2019 13:36:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D70DDA885; Fri,  3 May 2019 15:37:46 +0200 (CEST)
Date:   Fri, 3 May 2019 15:37:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20190503133746.GH20156@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20190503102105.13578cc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503102105.13578cc9@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:21:05AM +1000, Stephen Rothwell wrote:
> Hi David,
> 
> After merging the btrfs-kdave tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> fs/btrfs/props.c: In function 'inherit_props':
> fs/btrfs/props.c:389:4: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     btrfs_block_rsv_release(fs_info, trans->block_rsv,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       num_bytes);
>       ~~~~~~~~~~
> 
> Probably introduced by commit
> 
>   b835a4a3faec ("btrfs: use the existing reserved items for our first prop for inheritance")
> 
> Looks like a false positive to me.

Agreed and gcc 8.3.1 does not report that. Kbuild bot reported that as
well and it uses 7.x.
