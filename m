Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9D190C59
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 12:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCXLXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 07:23:21 -0400
Received: from foss.arm.com ([217.140.110.172]:60984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgCXLXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C2231B;
        Tue, 24 Mar 2020 04:23:20 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8793F792;
        Tue, 24 Mar 2020 04:23:19 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:23:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200324112316.GG4892@mbp>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200323121437.GC2597@C02TD0UTHF1T.local>
 <20200323190408.GE4892@mbp>
 <2067644.cOvikPKVsA@basile.remlab.net>
 <20200324105217.GA20256@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324105217.GA20256@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:52:17AM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 10:42:30PM +0200, Rémi Denis-Courmont wrote:
> > Le maanantaina 23. maaliskuuta 2020, 21.04.09 EET Catalin Marinas a écrit :
> > > Should we just use adrp on __entry_tramp_data_start? Anyway, the diff
> > > below doesn't solve the issue I'm seeing (only reverting patch 3).
> > 
> > AFAIU, the preexisting code uses the manual PAGE_SIZE offset because the offset 
> > in the main vmlinux does not match the architected offset inside the fixmap. If 
> > so, then using the symbol directly will not work at all.
> 
> Indeed. I can't see a neat way of avoiding this right now, so should we
> drop these patches and leave the code as-is (but with comments as to the
> special requirements that it has)?

I'm going to drop these three patches from -next for now but I can take
any updated comments (they are pretty much missing from this code).

Thanks.

-- 
Catalin
