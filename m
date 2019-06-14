Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD345B65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFNL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 07:28:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:22014 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfFNL2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:28:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 04:28:05 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2019 04:28:03 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Jun 2019 14:28:02 +0300
Date:   Fri, 14 Jun 2019 14:28:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the thunderbolt-fixes
 tree
Message-ID: <20190614112802.GE2640@lahna.fi.intel.com>
References: <20190614211933.25c1b792@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614211933.25c1b792@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:19:33PM +1000, Stephen Rothwell wrote:
> Hi Mika,

Hi,

> In commit
> 
>   e00367a43c56 ("thunderbolt: Implement CIO reset correctly for Titan Ridge")
> 
> Fixes tag
> 
>   Fixes: 4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple systems")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: c4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple systems")

Indeed that's the correct one. I've fixed it up now. Thanks!
