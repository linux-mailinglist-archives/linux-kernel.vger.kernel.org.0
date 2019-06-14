Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0E459B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfFNJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 05:57:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:18229 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:56:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 02:56:58 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2019 02:56:56 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Jun 2019 12:56:55 +0300
Date:   Fri, 14 Jun 2019 12:56:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Peter Bowen <pzb@amazon.com>
Subject: Re: [PATCH] thunderbolt: Implement CIO reset correctly for Titan
 Ridge
Message-ID: <20190614095655.GB2640@lahna.fi.intel.com>
References: <20190607111451.59648-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607111451.59648-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:14:51PM +0300, Mika Westerberg wrote:
> When starting ICM firmware on Apple systems we need to perform CIO reset
> as part of the flow. However, it turns out that the reset register has
> changed to another location in Titan Ridge.
> 
> Fix this by introducing ->cio_reset() callback with corresponding
> implementations for Alpine and Titan Ridge.
> 
> Fixes: 4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple systems")
> Reported-by: Peter Bowen <pzb@amazon.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to thunderbolt.git/fixes.
