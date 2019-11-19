Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB49A102A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfKSRIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:08:18 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:39691 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKSRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:08:18 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 12:08:18 EST
Received: from sapphire.tkos.co.il (unknown [192.168.100.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 479C2440537;
        Tue, 19 Nov 2019 19:02:08 +0200 (IST)
Date:   Tue, 19 Nov 2019 19:02:07 +0200
From:   Baruch Siach <baruch@tkos.co.il>
To:     Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        George Cherian <gcherian@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update Cavium ThunderX drivers
Message-ID: <20191119170207.cwfowgc57rvhg2td@sapphire.tkos.co.il>
References: <20191119165549.14570-1-rrichter@marvell.com>
 <20191119165549.14570-3-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119165549.14570-3-rrichter@marvell.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert, Jan,

On Tue, Nov 19, 2019 at 04:56:26PM +0000, Robert Richter wrote:
> From: Jan Glauber <jglauber@marvell.com>
> 
> Remove my maintainer entries for ThunderX drivers as I'm moving on
> and won't have access to ThunderX hardware anymore and add Robert.
> Also remove the obsolete addresses of David Daney and Steven Hill.
> 
> Add an entry to .mailmap for my various email addresses.

Couldn't find that part in this patch.

baruch

> Cc: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
> Cc: soc@kernel.org
> Signed-off-by: Jan Glauber <jglauber@marvell.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  MAINTAINERS | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
