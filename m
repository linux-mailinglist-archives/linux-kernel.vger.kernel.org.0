Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CED1359A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgAIM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 07:59:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:45114 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbgAIM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:59:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 04:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="423246044"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2020 04:59:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D19B0301003; Thu,  9 Jan 2020 04:59:44 -0800 (PST)
Date:   Thu, 9 Jan 2020 04:59:44 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: "perf ftrace" segfault because ->cpus!=NULL but ->all_cpus==NULL
Message-ID: <20200109125944.GS15478@tassilo.jf.intel.com>
References: <CAG48ez0eULP6pH26H9ac-YYa88_RSGt6v_hDhsrZ92iZoRdsoQ@mail.gmail.com>
 <20200109122443.GF52936@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109122443.GF52936@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> oops, ftrace is using evlist without event ;-) so all_cpus
> will not get initialized..
> 
> Andi, should we initialize evlist::all_cpus with the first
> cpus we get, like in the patch below?

I assume perf stat -A still works for all CPUs? If yes it's ok.

-andi
