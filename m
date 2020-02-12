Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8015B47E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgBLXIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:08:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:34712 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBLXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:08:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 15:08:17 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="256980416"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 15:08:17 -0800
Date:   Wed, 12 Feb 2020 15:08:15 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] New way to track mce notifier chain actions
Message-ID: <20200212230815.GA3217@agluck-desk2.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:46:47PM -0800, Tony Luck wrote:
> Part 4 is where things are interesting and need a great deal more
> thought.  A bunch of things on the chain return NOTIFY_STOP which
> prevents anything else on the chain from being run.  For the moment
> I ignored that semantic and added code everywhere to set the BIT
> even though nobody else will see it.  This is because I think at
> least some of them should NOT be NOTIFY_STOP.

NOTIFY_STOP is just one mechanism for preventing every function
on the mce chain from reporting an error.

The other bit I'd like to reconsider is edac_get_report_status().
Back in the day we seemed to be paranoid about reporting the same
error more than once via all the different reporting mechanisms.

Since then I've had to track down numerous "Why didn't this error
get reported?" questions that frequently resolved to "It was reported,
but not in the place that you expected".

So now my attitude is "Let's just log it everywhere in so that
whatever log the user is checking, they'll find the error".

-Tony
