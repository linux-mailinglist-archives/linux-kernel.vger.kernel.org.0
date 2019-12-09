Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16A11683E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLIIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 03:36:40 -0500
Received: from verein.lst.de ([213.95.11.211]:41330 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:36:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9500168BE1; Mon,  9 Dec 2019 09:36:37 +0100 (CET)
Date:   Mon, 9 Dec 2019 09:36:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [block] f216fdd77b:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <20191209083637.GA15038@lst.de>
References: <20191208153922.GI32275@shao2-debian> <20191209073152.GA14094@lst.de> <a67a0920-472f-7f86-299a-097bc2986a1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67a0920-472f-7f86-299a-097bc2986a1c@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:08:56PM +0800, Rong Chen wrote:
> Hi Christoph,
>
> Kernel boot failed in early stage with commit "f216fdd77b":

Well, this config (plus enabling virtio for real) boots just fine for
me.  There is nothing in your dmesgs, which makes me assume the boot
stage means really early?  Nothing touched in this commit is involved
in the very early boot path, though.
