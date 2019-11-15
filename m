Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5902EFDCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKOL4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 06:56:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:14859 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfKOL4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:56:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 03:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="214766740"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 Nov 2019 03:56:07 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 15 Nov 2019 13:56:07 +0200
Date:   Fri, 15 Nov 2019 13:56:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Mario.Limonciello@dell.com,
        Christian Kellner <ckellner@redhat.com>, zang <dump@tzib.net>
Subject: Re: [PATCH] thunderbolt: Power cycle the router if NVM
 authentication fails
Message-ID: <20191115115607.GA34425@lahna.fi.intel.com>
References: <20191112092452.70789-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112092452.70789-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:24:52PM +0300, Mika Westerberg wrote:
> On zang's Dell XPS 13 9370 after Thunderbolt NVM firmware upgrade the
> Thunderbolt controller did not come back as expected. Only after the
> system was rebooted it became available again. It is not entirely clear
> what happened but I suspect the new NVM firmware image authentication
> failed for some reason. Regardless of this the router needs to be power
> cycled if NVM authentication fails in order to get it fully functional
> again.
> 
> This modifies the driver to issue a power cycle in case the NVM
> authentication fails immediately when dma_port_flash_update_auth()
> returns. We also need to call tb_switch_set_uuid() earlier to be able to
> fetch possible NVM authentication failure when DMA port is added.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205457
> Reported-by: zang <dump@tzib.net>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> This applies on top of my thunderbolt.git/next.

Applied to thunderbolt.git/next.
