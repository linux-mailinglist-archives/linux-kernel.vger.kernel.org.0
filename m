Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F16177440
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgCCKdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:33:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:1280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgCCKdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:33:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 02:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="351795474"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Mar 2020 02:33:10 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Mar 2020 12:33:10 +0200
Date:   Tue, 3 Mar 2020 12:33:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <20200303103310.GN2540@lahna.fi.intel.com>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:43:29PM +0000, Nicholas Johnson wrote:
> This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> 
> Since NVMEM subsystem gained support for write-only instances, this
> workaround is no longer required, so drop it.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Assuming this goes through The NVMem tree:

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

If that's not the case, please let me know. I can also take them through
the Thunderbolt tree.
