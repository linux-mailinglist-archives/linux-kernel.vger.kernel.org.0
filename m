Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1C159A59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 21:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgBKUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 15:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgBKUO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:14:28 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672D020708;
        Tue, 11 Feb 2020 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581452068;
        bh=Zz1Eu/SQYdWt3+kzI5KfInMjp4eKYWQpGoSPK8GSmHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFSaEhAd/Ee7bMu4zW2TsDp5NI+9agvUHYFG4uifDJH4UYNX3B3vmohjzap8HiRF5
         srZi/kijxAJayXJLShwbQF9HUAwhY1YyydTSedVX+mSWkO8BFaiKGADXIyduEveYve
         t/k/AcJBAg7Rj2OcORw55m5YtWsx1w4EI91kpdk8=
Date:   Tue, 11 Feb 2020 12:14:27 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, roman.sudarikov@linux.intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200211201427.GA1975593@kroah.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
 <20200211185759.GA1941673@kroah.com>
 <25dca8dd-c52d-676d-ffe4-90f3a6ddc915@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dca8dd-c52d-676d-ffe4-90f3a6ddc915@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:59:21PM -0500, Liang, Kan wrote:
> 
> 
> On 2/11/2020 1:57 PM, Greg KH wrote:
> > On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
> > > On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
> > > > On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
> > > > > +static ssize_t skx_iio_mapping_show(struct device *dev,
> > > > > +				struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	struct pmu *pmu = dev_get_drvdata(dev);
> > > > > +	struct intel_uncore_pmu *uncore_pmu =
> > > > > +		container_of(pmu, struct intel_uncore_pmu, pmu);
> > > > > +
> > > > > +	struct dev_ext_attribute *ea =
> > > > > +		container_of(attr, struct dev_ext_attribute, attr);
> > > > > +	long die = (long)ea->var;
> > > > > +
> > > > > +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> > > > 
> > > > If "0000:" is always the "prefix" of the output of this file, why have
> > > > it at all as you always know it is there?
> 
> 
> I think Roman only test with BIOS configured as single-segment. So he
> hard-code the segment# here.
> 
> I'm not sure if Roman can do some test with multiple-segment BIOS. If not, I
> think we should at least print a warning here.
> 
> > > > 
> > > > What is ever going to cause that to change?
> > > 
> > > I think it's just to make it a complete PCI address.
> > 
> > Is that what this really is?  If so, it's not a "complete" pci address,
> > is it?  If it is, use the real pci address please.
> 
> I think we don't need a complete PCI address here. The attr is to disclose
> the mapping information between die and PCI BUS. Segment:BUS should be good
> enough.

"good enough" for today, but note that you can not change the format of
the data in the file in the future, you would have to create a new file.
So I suggest at least try to future-proof it as much as possible if you
_know_ this could change.

Just use the full pci address, there's no reason not to, otherwise it's
just confusing.

thanks,

greg k-h
