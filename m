Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4F81BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfHENSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:18:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:48668 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfHENSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:18:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 06:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192418646"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 06:17:44 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 16:17:43 +0300
Date:   Mon, 5 Aug 2019 16:17:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 4/8] thunderbolt: Do not fail adding switch if some port
 is not implemented
Message-ID: <20190805131743.GS2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-5-mika.westerberg@linux.intel.com>
 <20190803141401.bmjo7u723p4wxtqb@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803141401.bmjo7u723p4wxtqb@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 04:14:01PM +0200, Lukas Wunner wrote:
> On Fri, Jul 05, 2019 at 12:57:56PM +0300, Mika Westerberg wrote:
> > There are two ways to mark a port as unimplemented. Typical way is to
> > return port type as TB_TYPE_INACTIVE when its config space is read.
> > Alternatively if the port is not physically present (such as ports 10
> > and 11 in ICL) reading from port config space returns
> > TB_CFG_ERROR_INVALID_CONFIG_SPACE instead. Currently the driver bails
> > out from adding the switch if it receives any error during port
> > inititialization which is wrong.
> > 
> > Handle this properly and just leave the port as TB_TYPE_INACTIVE before
> > continuing to the next port.
> 
> Your patch may also cause this snippet in eeprom.c to become obsolete:
> 
> 		/* Port 5 is inaccessible on this gen 1 controller */
> 		if (sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE)
> 			sw->ports[5].disabled = true;
> 
> To verify this hypothesis, one needs to comment out the call to
> tb_drom_copy_efi() as well as the above-quoted snippet and boot
> on a Mac with Light Ridge.  The driver should hit an error without
> your patch and it may work correctly with your patch.

Indeed. I'll check this - as I have Mac with LR, and update the patch
accordingly (e.g drop the check if the error does not appear).
