Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024A3F3192
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbfKGOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:34:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:32103 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbfKGOeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:34:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 06:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213033260"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 06:33:56 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 16:33:55 +0200
Date:   Thu, 7 Nov 2019 16:33:55 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt changes for v5.5
Message-ID: <20191107143355.GR2552@lahna.fi.intel.com>
References: <20191107131843.GL2552@lahna.fi.intel.com>
 <20191107142556.GA129785@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107142556.GA129785@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:25:56PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2019 at 03:18:43PM +0200, Mika Westerberg wrote:
> > Hi Greg,
> > 
> > Please pull Thunderbolt changes for v5.5 merge window. I needed to merge
> > my fixes branch here because there is dependency between some of the
> > commits. The fixes branch is already included in your char-misc-linus
> > branch.
> 
> None of the USB4 stuff yet?  Awe, I wanted to see that happen...

This includes the USB4 register naming conversion patches. The rest of
the USB4 patches are based on these commits. I will be sending an
updated version of them after v5.5-rc1 is released.

> Anyway, pulled and pushed out, thanks.

Thanks!
