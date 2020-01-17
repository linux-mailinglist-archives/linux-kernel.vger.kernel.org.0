Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199D814117A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAQTMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 14:12:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:50673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgAQTMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:12:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 11:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="424581003"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2020 11:12:20 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B640B300DE4; Fri, 17 Jan 2020 11:12:20 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:12:20 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     roman.sudarikov@linux.intel.com
Cc:     gregkh@linux-foundation.org, roman.sudarikov@linux.intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200117191220.GN302770@tassilo.jf.intel.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <20200117172726.GM302770@tassilo.jf.intel.com>
 <20200117184249.GB1969121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117184249.GB1969121@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > pmon0-3: list of pci busses indexed by die
> > 
> > To be honest the approach doesn't seem unreasonable to me. It's similar
> > e.g. how we express lists of cpus or nodes in sysfs today.

<snipped repeated form letter non answer to question>

Roman, 

I suppose you'll need something like

/sys/device/system/dieXXX/pci-pmon<0-3>/bus 

and bus could be a symlink to the pci bus directory.

The whole thing will be ugly and complicated and slow and difficult
to parse, but it will presumably follow Greg's rules.

-Andi

