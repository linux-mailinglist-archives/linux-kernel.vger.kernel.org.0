Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34AB964C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfHTPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:40:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfHTPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TzzmrCVOXyvBOTNRP9SWeKlsVPWPMGTuDrIfC6EXHsQ=; b=feMQ4R2MwZctjB8DNdf+vrUw0r
        c9bB/CFotIe6cEg9z7wIjgnXUf5Hn/a2TIKSDThgVDP7D0pZRi25ohlzhwDOnrl/9117TRBEE+R1H
        dmQDzar1U7B0oD63jY1DteeXJQLRZOsvdNc+ueng/sEqwG4EYV/bTRZOt3x7pd3EqkVPgXUKxotmt
        i+ev+54e17UY3HLkHwjZbaoSzYbF6pqxVivfu0JpkFsOgPHgNQOBSc8ah4SzTTt7zXPkubBicUEkt
        eaXEZkN1kykcfpG5UDaTMHYBeVql0Odpub8diRRl6oeJZUHTJo+tsSVB4+AuLW0IMGBDWulu5edxo
        ixVX2xrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i05Zq-0000sX-Pi; Tue, 20 Aug 2019 14:57:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E346307603;
        Tue, 20 Aug 2019 16:57:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7B7B20A978FE; Tue, 20 Aug 2019 16:57:35 +0200 (CEST)
Date:   Tue, 20 Aug 2019 16:57:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190820145735.GW2332@hirez.programming.kicks-ass.net>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:48:05PM +0000, Luck, Tony wrote:
> 
> >> +#define INTEL_FAM6_ATOM_AIRMONT_NP    0x75 /* Lightning Mountain */
> > 
> > What's _NP ?
> 
> Network Processor. But that is too narrow a descriptor. This is going to be used in
> other areas besides networking. 
> 
> I’m contemplating calling it AIRMONT2

What would describe the special sause that warranted a new SOC? If this
thing is marketed as 'Network Processor' then I suppose we can actually
use it, esp. if we're going to see this more, like the MID thing -- that
lived for a while over multiple uarchs.

Note that for the big cores we added the NNPI thing, which was for
Neural Network Processing something.
