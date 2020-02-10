Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC6158063
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBJRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:02:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:61615 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJRCA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:02:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 09:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="227234450"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 09:02:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CDBC8300503; Mon, 10 Feb 2020 09:01:59 -0800 (PST)
Date:   Mon, 10 Feb 2020 09:01:59 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Show percore counts in per CPU output
Message-ID: <20200210170159.GV302770@tassilo.jf.intel.com>
References: <20200206015613.527-1-yao.jin@linux.intel.com>
 <20200210132804.GA9922@krava>
 <f749694f-b3b3-c498-74ea-ec2e6bb0d0f1@linux.intel.com>
 <20200210140120.GD9922@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210140120.GD9922@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > With --percore-show-thread, CPU0 and CPU4 have the same counts (CPU0 and
> > CPU4 are siblings, e.g. 2,453,061 in my example). The value is sum of CPU0 +
> > CPU4.
> 
> so it shows percore stats but displays all the cpus? what is this good for?

This is essentially a replacement for the any bit (which is gone in Icelake).
Per core counts are useful for some formulas, e.g. CoreIPC

The original percore version was inconvenient to post process. This
variant matches the output of the any bit.

-Andi
