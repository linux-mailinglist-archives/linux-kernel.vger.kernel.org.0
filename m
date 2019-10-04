Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6725BCB5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfJDIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 04:19:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:56639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388246AbfJDIT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:19:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="205805350"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 01:19:52 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Oct 2019 11:19:51 +0300
Date:   Fri, 4 Oct 2019 11:19:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        nicholas.johnson-opensource@outlook.com.au,
        Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu,
        Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191004081951.GD2819@lahna.fi.intel.com>
References: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com>
 <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com>
 <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com>
 <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:07:34AM +0300, Yehezkel Bernat wrote:
> > Also if you can get the hw_vendor_id and hw_product_id from the kernel
> > does that mean you don't need to do the two reads or you still need
> > those?
> 
> Are those the chip vendor or the OEM, in case they are different?

Those are the actual USB4 hardware maker values, directly from
ROUTER_CS_0 (p. 287 in the USB4 spec). This almost certainly differ from
the OEM values from DROM we currently expose.

> Thinking about it again, I'd guess it shouldn't matter much, if the chip is from
> Intel, the FW supports NVM upgrade, isn't it?

So the bottom line is that if the kernel thinks the router supports NVM
upgrade it exposes the nvm_active/nvm_non_active files etc. I think
fwupd uses this information to display user whether the device can be
upgraded or not (for example ICL cannot as the NVM is part of BIOS).

Exposing hw_vendor_id and hw_product_id may speed up fwupd because it
does not need to go over the active NVM to figure out whether the new
image is for the correct controller.
