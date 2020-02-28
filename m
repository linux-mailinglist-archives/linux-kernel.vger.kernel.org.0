Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA717373C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 13:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1MdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 07:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1MdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:33:17 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD00246A8;
        Fri, 28 Feb 2020 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582893197;
        bh=iI9Izp1/xx+N6k2MZVXAFgzynuOg+3ILMN2IFASspNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olfkeknYTpfaX/G5LJGKxEF7bCQJHQDBcFV0o4Y32z0y3RCRqnI9oG1BX+JRrVIDM
         jVnYWDRgGEVWdB5aQsvMkI+iM0U2ehwm8z6utSeJMQEYPYQ30Yt2oo2dGT96FB5Kf0
         JeU4N0FzFT0mpC2zqdVHP/N1OEZsd2Ohi8L+71pg=
Date:   Fri, 28 Feb 2020 12:33:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, tj@kernel.org,
        jiangshanlai@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org
Subject: Re: WARNING: at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
Message-ID: <20200228123311.GE3275@willie-the-truck>
References: <20200217204803.GA13479@Red>
 <20200218163504.y5ofvaejleuf5tbh@ca-dmjordan1.us.oracle.com>
 <20200220090350.GA19858@Red>
 <20200221174223.r3y6tugavp3k5jdl@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221174223.r3y6tugavp3k5jdl@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:42:23PM -0500, Daniel Jordan wrote:
> On Thu, Feb 20, 2020 at 10:03:50AM +0100, Corentin Labbe wrote:
> > But I got the same with plain next (like yesterday 5.6.0-rc2-next-20200219 and tomorow 5.6.0-rc2-next-20200220) and master got the same issue.
> 
> Thanks.  I've been trying to reproduce this on an arm board but it's taking a
> while to get it setup since I've never used it for kernel work.
> 
> Hoping to get it up soon, though someone with a working setup may be in a
> better position to help with this.

Any joy with this? It sounded to me like the issue also happens on a
mainline kernel. If this is the case, have you managed to bisect it?

Cheers,

Will
