Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43DDE2061
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407171AbfJWQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 12:18:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:13513 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404623AbfJWQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:18:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 09:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="209950808"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 09:18:19 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 19:18:19 +0300
Date:   Wed, 23 Oct 2019 19:18:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, oneukum@suse.com, ckellner@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] thunderbolt: Add support for USB4
Message-ID: <20191023161819.GD2819@lahna.fi.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
 <816be093556b466ebb4c645c9933bbc3@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816be093556b466ebb4c645c9933bbc3@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:55:48PM +0000, Mario.Limonciello@dell.com wrote:
> > I did not yet add the hw_vendor_id and hw_product_id attributes because I
> > clocked that 'dd if=nvm_activeX/nvmem of=/dev/null bs=64 count=2' (that's
> > what fwupd does) takes typically less than 10 ms when the controller is powered
> > on. That should not slow down fwupd. We can add them later if it is really a
> > problem (I'm just trying to avoid adding too much attributes that we need to
> > maintain forever).
> 
> Maybe the controller going into D3 is the key to why it measured slow for me when
> I checked.

Yeah, that's most likely the case.
