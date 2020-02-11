Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F321598E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 19:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgBKSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 13:42:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:7262 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgBKSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:42:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 10:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="433779485"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2020 10:42:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 58C64300FDE; Tue, 11 Feb 2020 10:42:00 -0800 (PST)
Date:   Tue, 11 Feb 2020 10:42:00 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200211184200.GA302770@tassilo.jf.intel.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211171544.GA1933705@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
> On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
> > +static ssize_t skx_iio_mapping_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct pmu *pmu = dev_get_drvdata(dev);
> > +	struct intel_uncore_pmu *uncore_pmu =
> > +		container_of(pmu, struct intel_uncore_pmu, pmu);
> > +
> > +	struct dev_ext_attribute *ea =
> > +		container_of(attr, struct dev_ext_attribute, attr);
> > +	long die = (long)ea->var;
> > +
> > +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> 
> If "0000:" is always the "prefix" of the output of this file, why have
> it at all as you always know it is there?
> 
> What is ever going to cause that to change?

I think it's just to make it a complete PCI address.

In theory it might be different on a complex multi node system with
custom interconnect and multiple PCI segments, but that would need code
changes too.

This version of the patchkit only supports standard SKX systems
at this point.

-Andi
