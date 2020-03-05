Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91D17AE1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:32:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:29598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCEScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:32:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 10:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352410826"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 10:32:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EA28D301BC6; Thu,  5 Mar 2020 10:32:06 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:32:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     zhe.he@windriver.com, jolsa@kernel.org, meyerk@hpe.com,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
Message-ID: <20200305183206.GA1454533@tassilo.jf.intel.com>
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
 <20200305152755.GA6958@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305152755.GA6958@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 12:27:55PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escreveu:
> > From: He Zhe <zhe.he@windriver.com>
> > 
> > NULL pointer may be passed to perf_cpu_map__cpu and then cause the
> > following crash.
> > 
> > perf ftrace -G start_kernel ls
> > failed to set tracing filters
> > [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
> >                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
> > [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
> >                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
> >                      4d f4 31 c9 8b 45 08 8b9
> > Segmentation fault
> 
> I'm not being able to repro this here, what is the tree you are using?

I believe that's the same bug that Jann Horn reported recently for perf trace.
I thought the patch for that went in.

-Andi
