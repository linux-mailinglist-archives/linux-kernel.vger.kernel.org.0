Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F91C2BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 04:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfJACR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 22:17:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:10644 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJACRz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:17:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 19:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; 
   d="scan'208";a="181550706"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2019 19:17:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1979D301B07; Mon, 30 Sep 2019 19:17:55 -0700 (PDT)
Date:   Mon, 30 Sep 2019 19:17:55 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20191001021755.GF8560@tassilo.jf.intel.com>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava>
 <20190930182136.GD8560@tassilo.jf.intel.com>
 <20190930192800.GA13904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930192800.GA13904@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think it's useful. Makes it easy to do kernel/user break downs.
> > perf record should support the same.
> 
> Don't we have this already with:
> 
> [root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1

This only works for simple cases. Try it for --topdown or multiple -M metrics.

-Andi
