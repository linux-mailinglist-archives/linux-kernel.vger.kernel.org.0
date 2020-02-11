Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D00159938
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgBKS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 13:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgBKS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:00 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9640F2168B;
        Tue, 11 Feb 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581447479;
        bh=SYGr/poOOxABNG/sEWpaMTCIoISL7kajfj6opKOEj/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XPIYzUoVXHabiF9sZZz8W1qNiFvFY5hmzZ/OPpyvFZgXct19ICW58gEa/dhPpLn/
         TH3SMnOouuGySAI7aZDT6+WJaxTRSUdbweso0dgIMS9czgE7EphXdCOyiLCC4rGHnk
         rwBEZoF5fQVf8cSPuR2iqkHx72zgAP0oBiw8wpcg=
Date:   Tue, 11 Feb 2020 10:57:59 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200211185759.GA1941673@kroah.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211184200.GA302770@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
> On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
> > On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
> > > +static ssize_t skx_iio_mapping_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pmu *pmu = dev_get_drvdata(dev);
> > > +	struct intel_uncore_pmu *uncore_pmu =
> > > +		container_of(pmu, struct intel_uncore_pmu, pmu);
> > > +
> > > +	struct dev_ext_attribute *ea =
> > > +		container_of(attr, struct dev_ext_attribute, attr);
> > > +	long die = (long)ea->var;
> > > +
> > > +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> > 
> > If "0000:" is always the "prefix" of the output of this file, why have
> > it at all as you always know it is there?
> > 
> > What is ever going to cause that to change?
> 
> I think it's just to make it a complete PCI address.

Is that what this really is?  If so, it's not a "complete" pci address,
is it?  If it is, use the real pci address please.

> In theory it might be different on a complex multi node system with
> custom interconnect and multiple PCI segments, but that would need code
> changes too.
> 
> This version of the patchkit only supports standard SKX systems
> at this point.

I have no idea what that means, please translate for non-Intel people :)

greg k-h
