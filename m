Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC5E2B45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407130AbfJXHoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 03:44:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:55724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404543AbfJXHoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:44:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 00:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,223,1569308400"; 
   d="scan'208";a="210097805"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Oct 2019 00:43:59 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 24 Oct 2019 10:43:58 +0300
Date:   Thu, 24 Oct 2019 10:43:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt fixes for v5.4
Message-ID: <20191024074358.GM2819@lahna.fi.intel.com>
References: <20191011101831.GC2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011101831.GC2819@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Oct 11, 2019 at 01:18:31PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:
> 
>   Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.4-1
> 
> for you to fetch changes up to 747125db6dcd8bcc21f13d013f6e6a2acade21ee:
> 
>   thunderbolt: Drop unnecessary read when writing LC command in Ice Lake (2019-10-08 12:08:21 +0300)
> 
> ----------------------------------------------------------------
> thunderbolt: Fixes for v5.4
> 
> This includes three fixes for various issues people have reported:
> 
>   - Fix DP tunneling on some Light Ridge controllers
>   - Fix for lockdep circular locking dependency warning
>   - Drop unnecessary read on ICL
> 
> ----------------------------------------------------------------
> Mika Westerberg (3):
>       thunderbolt: Read DP IN adapter first two dwords in one go
>       thunderbolt: Fix lockdep circular locking depedency warning
>       thunderbolt: Drop unnecessary read when writing LC command in Ice Lake

Just checking whether this fell through the cracks or you require some
changes?

Thanks!
