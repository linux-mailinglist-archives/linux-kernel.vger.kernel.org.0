Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3451168AED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBVAXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 19:23:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:49830 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgBVAXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:23:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 16:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="240484441"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2020 16:23:13 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 061013011C4; Fri, 21 Feb 2020 16:23:13 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:23:12 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/4] perf expr: Move expr lexer to flex
Message-ID: <20200222002312.GN160988@tassilo.jf.intel.com>
References: <20200221231935.735145-1-jolsa@kernel.org>
 <20200221231935.735145-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221231935.735145-3-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +max		{ return MAX; }
> +min		{ return MIN; }
> +if		{ return IF; }
> +else		{ return ELSE; }
> +#smt_on		{ return SMT_ON; }
> +{number}	{ return value(yyscanner, 10); }
> +{symbol}	{ return str(yyscanner, ID); }
> +"|"		{ return '|'; }
> +"^"		{ return '^'; }
> +"&"		{ return '&'; }
> +"-"		{ return '-'; }
> +"+"		{ return '+'; }
> +"*"		{ return '*'; }
> +"/"		{ return '/'; }
> +"%"		{ return '%'; }
> +"("		{ return '('; }
> +")"		{ return ')'; }
> +","		{ return ','; }

Didn't think there was a comma, but ok.

Looks reasonable to me.

-Andi
