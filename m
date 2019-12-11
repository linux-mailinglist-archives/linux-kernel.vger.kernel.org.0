Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570AE11C038
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLKXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 18:01:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:10538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfLKXB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:01:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 15:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="245470797"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2019 15:01:26 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5463F3002C5; Wed, 11 Dec 2019 15:01:26 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:01:26 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [RFC 0/3] perf tools: Add support for used defined metric
Message-ID: <20191211230126.GC862919@tassilo.jf.intel.com>
References: <20191211224800.9066-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211224800.9066-1-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:47:57PM +0100, Jiri Olsa wrote:
> hi,
> Joe asked for possibility to add user defined metrics. Given that
> we already have metrics support, I added --metric option that allows
> to specify metric on the command line, like:
> 
>   # perf stat  --metric 'DECODED_ICACHE_UOPS% = 100 * (idq.dsb_uops / \
>     (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops))' ...
> 
> The code facilitates the current metric code, and I was surprised
> how easy it was, so I'm not sure I omitted something ;-)

There are some asserts you can hit, like for too many events.

Also some of the syntax (e.g. using @ instead of / and escapes) are
not super user friendly.

Other than that it should be ok.

Of course it would be better to put it into a file,
and then support comments etc.

I've been considering some extensions to perf to support @file
reading with comment support.

Right now there are some very odd bugs when you do that, lie

-e 'event,<newline>
event,<newline>
event...'

adds the newline to the event name, which breaks the output formats.

-Andi
