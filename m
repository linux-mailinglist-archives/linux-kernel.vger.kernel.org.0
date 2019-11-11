Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12244F7964
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKKRCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 12:02:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:41408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:02:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 09:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="249941137"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2019 09:02:25 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2670E301376; Mon, 11 Nov 2019 09:02:25 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:02:25 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/13] perf stat: Use affinity for opening events
Message-ID: <20191111170225.GF573472@tassilo.jf.intel.com>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-11-andi@firstfloor.org>
 <20191111133107.GG12923@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133107.GG12923@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  #include <linux/time64.h>
> > @@ -440,6 +441,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
> >  			ui__warning("%s event is not supported by the kernel.\n",
> >  				    perf_evsel__name(counter));
> >  		counter->supported = false;
> > +		counter->errored = true;
> 
> how is errored different from supported?
> why can't you use it?

errored means that the event is still partially open, while supported means it is
closed. While I guess it could be combined it seems cleaner to keep them
separate.

-Andi
