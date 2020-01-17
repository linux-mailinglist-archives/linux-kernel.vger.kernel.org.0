Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7649141497
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 00:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgAQXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 18:04:05 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49581 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729099AbgAQXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:04:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 744C4585E;
        Fri, 17 Jan 2020 18:04:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 Jan 2020 18:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5quz/s
        XDX8o8ICPwUpRb3ta3WYQ721Mtd7frfvTaU00=; b=gArZ7YMl0/16hrDswrK6K4
        Oj1/8tYUm8W6ZSIHSp2E272yRYtNDil2/b+Zl1uR0y2yDMLrKFPfaIz8cwNw0TCe
        /QXpv9G/bdVH1qnM7kVEXHVEB6BF3GEAtGZlwTvKPTLM9m7/cuJacUwm8/jnLde6
        oake1xaY2Rd/fo94DOsXuyv3mOfstgSaUr5Orj2lRAOwhcYHMyPdNxU5WPKmh3ZY
        zIIWtfx7pmMhjAkFxQsAkBsGqTpN4gD5/qko0JEam5s1fwPyMthWyik0V2YBeBqB
        FuMd452qavUFwglnUYWUebwh8+kbfb6nzXVUa05WJYsnVhxzzYI696iuFAW22McA
        ==
X-ME-Sender: <xms:YT0iXnaBsenCTgvzg-F1rg31A2kwGO0iakIpJecYRwn6Wb-9ExUGUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdelgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvghhkhheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgqeenucfkph
    epkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvghes
    khhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:YT0iXlais33krYYwaT7vn-uWfQEnvuHvOa3KjDeSyBA1MwSMJ2yVkQ>
    <xmx:YT0iXqFC-c0uJvp85UV0dfVlykGscfq6HanpacGVwHb8G7JDu832OA>
    <xmx:YT0iXgDs-B2A7Z5byjQTVVnFgVmxFtRMenn4vH8U7_jIWUPPxy4bjw>
    <xmx:Yj0iXshXyDKLHNAJMScgCbZ44x5VOJ2rnKHn1EdQ70m5uuN3Wo4ZOQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10A2E80063;
        Fri, 17 Jan 2020 18:04:01 -0500 (EST)
Date:   Sat, 18 Jan 2020 00:03:56 +0100
From:   Greg KH <gregkh@linux-foundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200117230356.GA2093716@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <20200117172726.GM302770@tassilo.jf.intel.com>
 <20200117184249.GB1969121@kroah.com>
 <20200117191220.GN302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117191220.GN302770@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:12:20AM -0800, Andi Kleen wrote:
> > > pmon0-3: list of pci busses indexed by die
> > > 
> > > To be honest the approach doesn't seem unreasonable to me. It's similar
> > > e.g. how we express lists of cpus or nodes in sysfs today.
> 
> <snipped repeated form letter non answer to question>
> 
> Roman, 
> 
> I suppose you'll need something like
> 
> /sys/device/system/dieXXX/pci-pmon<0-3>/bus 
> 
> and bus could be a symlink to the pci bus directory.

Why do you need to link to the pci bus directory?

> The whole thing will be ugly and complicated and slow and difficult
> to parse, but it will presumably follow Greg's rules.

Who needs to parse this?  What tool will do it and for what?

greg k-h
