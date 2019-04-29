Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A39E4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfD2OXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbfD2OX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AD15AF1E;
        Mon, 29 Apr 2019 14:23:28 +0000 (UTC)
Date:   Mon, 29 Apr 2019 16:23:26 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
Message-ID: <20190429142326.GA4678@suse.de>
References: <1556290348.6132.6.camel@lca.pw>
 <20190426152632.GC3173@suse.de>
 <1556294112.6132.7.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556294112.6132.7.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:55:12AM -0400, Qian Cai wrote:
> https://git.sr.ht/~cai/linux-debug/blob/master/dmesg

Thanks, I can't see any definitions for unity ranges or exclusion ranges
in the IVRS table dump, which makes it even more weird.

Can you please send me the output of

	for f in `ls -1 /sys/kernel/iommu_groups/*/reserved_regions`; do echo "---$f"; cat $f;done

to double-check?

Thanks,

	Joerg
