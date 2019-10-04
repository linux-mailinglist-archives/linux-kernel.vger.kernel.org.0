Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98619CBED6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389631AbfJDPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:16:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:26830 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:16:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 08:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="205878501"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 08:16:22 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Oct 2019 18:16:21 +0300
Date:   Fri, 4 Oct 2019 18:16:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christian Kellner <christian@kellner.me>
Cc:     Mario.Limonciello@dell.com, yehezkelshb@gmail.com,
        linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191004151621.GL2819@lahna.fi.intel.com>
References: <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com>
 <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com>
 <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
 <20191004081951.GD2819@lahna.fi.intel.com>
 <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
 <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
 <20191004142110.GJ2819@lahna.fi.intel.com>
 <1570201357.2.0@kellner.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570201357.2.0@kellner.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 05:02:37PM +0200, Christian Kellner wrote:
> Should work. What would the value be for Thunderbolt 3 (and before)? I
> guess '0' if I am looking at the right thing (bits 31:24 in
> ROUTER_CS_4)?

Yes, it would be 0x10 and below that depending on the generation.

> Is there any harm of also having the 'generation' exposed
> as well? I like the simplicity of the mapping from that value to
> Thunderbolt/USB4 standard version (e.g. I would show that in 'boltctl
> list'); 'hw_version' will need a bit more "interpreting".

If generation is the only thing you need, we can export that now and
forget hw_version :)
