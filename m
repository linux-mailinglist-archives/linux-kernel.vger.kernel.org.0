Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA7BC9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfIXOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 10:08:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:22247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbfIXOI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:08:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 07:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="389871041"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2019 07:08:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 74890301AF5; Tue, 24 Sep 2019 07:08:56 -0700 (PDT)
Date:   Tue, 24 Sep 2019 07:08:56 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf, stat: Fix free memory access / memory leaks in
 metrics
Message-ID: <20190924140856.GQ8537@tassilo.jf.intel.com>
References: <20190923233339.25326-1-andi@firstfloor.org>
 <20190923233339.25326-3-andi@firstfloor.org>
 <20190924075040.GC26797@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924075040.GC26797@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	expr__ctx_init(&pctx);
> > +	/* Must be first id entry */
> > +	expr__add_id(&pctx, name, avg);
> 
> hum, shouldn't u instead use strdup(name) instead of name?

The cleanup loop later skips freeing the first entry.

-Andi

