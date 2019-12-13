Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91911DA33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbfLLXt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 18:49:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:18741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbfLLXt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:49:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 15:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="204143548"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2019 15:49:25 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AF81C30038C; Thu, 12 Dec 2019 15:49:25 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:49:25 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Ed Maste <emaste@freefall.freebsd.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] perf tools: correct license on jsmn json parser
Message-ID: <20191212234925.GA9938@tassilo.jf.intel.com>
References: <20191212151244.26324-1-emaste@freefall.freebsd.org>
 <CAPyFy2CgXe+8xzqEDhq+NRB-pu+kFnmxm+7GKMmkFz1uXfsa1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPyFy2CgXe+8xzqEDhq+NRB-pu+kFnmxm+7GKMmkFz1uXfsa1Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:00:20PM -0500, Ed Maste wrote:
> On Thu, 12 Dec 2019 at 10:13, Ed Maste <emaste@freefall.freebsd.org> wrote:
> >
> > These files are part of the jsmn json parser, introduced in 867a979a83.
> > Correct the SPDX tag to indicate that they are under the MIT license.
> 
> Oh, it looks like I made a mistake. json.h is actually part of Andi
> Kleen's wrapper and I suspect should be 2-clause BSD as json.c is;
> I'll leave that to Andi.
> 
> jsmn.h is MIT licensed and does have the wrong SPDX tag.

Yes should fix the jsmn.h tag to MIT license.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
