Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC727F33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfEWOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:12:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:42143 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:12:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 07:12:16 -0700
X-ExtLoop1: 1
Received: from mtayar-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.47.66])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2019 07:12:14 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id B302121D78; Thu, 23 May 2019 17:10:05 +0300 (EEST)
Date:   Thu, 23 May 2019 17:10:05 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Shawnx Tu <shawnx.tu@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the v4l-dvb tree
Message-ID: <20190523141004.cfbuymuykjew4tyr@kekkonen.localdomain>
References: <20190524000500.61cacf9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524000500.61cacf9e@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Mauro,

On Fri, May 24, 2019 at 12:05:00AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   eeabf6320e2f ("media: Revert "[media] marvell-ccic: reset ccic phy when stop streaming for stability"")
>   bbf83ed40252c ("media: ov8856: modify register to fix test pattern")
> 
> are missing a Signed-off-by from their authors.

Ouch.

Mauro, what do you prefer, reset the tree or what?

Shawn, Lubomir: please read "Developer's Certificate of Origin 1.1" in
Documentation/process/submitting-patches.rst and then resend with
appropriate SoB lines.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
