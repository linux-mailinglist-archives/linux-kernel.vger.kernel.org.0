Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A865013C967
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAOQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 11:33:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:29744 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:33:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 08:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="397939603"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 08:33:26 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1irlbj-0007jW-E8; Wed, 15 Jan 2020 18:33:27 +0200
Date:   Wed, 15 Jan 2020 18:33:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: baudrate: Synchronise baud_table[] and
 baud_bits[]
Message-ID: <20200115163327.GF32742@smile.fi.intel.com>
References: <20200114170917.36947-1-andriy.shevchenko@linux.intel.com>
 <20200114172756.GA2052011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114172756.GA2052011@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:27:56PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 14, 2020 at 07:09:17PM +0200, Andy Shevchenko wrote:
> > Synchronize baud rate tables for better readability.
> 
> "Synchronize"?  With what?

Between each other. This SPARC thingy makes it's harder to follow.

> Why?  I'm all for cleaning up code, but this
> just seems totally gratuitous.

Btw, while doing it I found that SPARC actually supports more baud rates than
defined in those arrays. Without this patch I would not (easily) notice that.
Should I also attach another patch and resend?

-- 
With Best Regards,
Andy Shevchenko


