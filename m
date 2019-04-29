Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E453EA53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfD2Smt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 14:42:49 -0400
Received: from muru.com ([72.249.23.125]:47616 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfD2Sms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:42:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8280B80E4;
        Mon, 29 Apr 2019 18:43:05 +0000 (UTC)
Date:   Mon, 29 Apr 2019 11:42:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc:     Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        d-gerlach@ti.com, t-kristo@ti.com
Subject: Re: [PATCH] soc: ti: pm33xx: Add a print while entering RTC only
 mode with DDR in self-refresh
Message-ID: <20190429184245.GG8007@atomide.com>
References: <20190429044435.19315-1-j-keerthy@ti.com>
 <b862e2c4-781c-ced9-3a6f-b0095562732a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b862e2c4-781c-ced9-3a6f-b0095562732a@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* santosh.shilimkar@oracle.com <santosh.shilimkar@oracle.com> [190429 18:40]:
> On 4/28/19 9:44 PM, Keerthy wrote:
> > Currently there is no way to distinguish if the SoC entered DS0
> > mode or the RTC only mode. Hence add a print before entering
> > the RTC only mode.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
> Tony, Am assuming you will queue this up ?

OK yeah I'll queue it.

Thanks,

Tony
