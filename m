Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD132102929
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfKSQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 11:20:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:59090 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfKSQUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:20:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 08:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="215568768"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2019 08:20:19 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 19 Nov 2019 18:20:18 +0200
Date:   Tue, 19 Nov 2019 18:20:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt change for v5.5 part 2
Message-ID: <20191119162018.GN11621@lahna.fi.intel.com>
References: <20191119130751.GK11621@lahna.fi.intel.com>
 <20191119160022.GA2027670@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119160022.GA2027670@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:00:22PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 19, 2019 at 03:07:51PM +0200, Mika Westerberg wrote:
> > Hi Greg,
> > 
> > There is one more Thunderbolt driver improvement that I would like to
> > get into v5.5 merge window. Please consider pulling.
> 
> Hey, that sounds like the problem my laptop was having!  :)
> 
> Should this also go to stable for 5.4.y?

Yes, I think it makes sense to have it there. Do you want me to mark it
for stable or you do it?
