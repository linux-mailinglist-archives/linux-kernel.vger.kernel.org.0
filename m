Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1851AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfFXSiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 14:38:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:58119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfFXSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:38:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="161680427"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2019 11:38:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5638A3020F2; Mon, 24 Jun 2019 11:38:06 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:38:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190624183806.GD31027@tassilo.jf.intel.com>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com>
 <20190623224031.GB5471@krava>
 <20190624164617.GB31027@tassilo.jf.intel.com>
 <20190624180634.GB7292@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624180634.GB7292@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Tom, plz correctme if I'm wrongm but AFAIK because the LBR tracing is
> enabled during the boot the lbr_from/lbr_to registers will fail the
> check_msr 'val_new != val_tmp' check

Ok this should be handleable. It should be enough to check
the ctrl register, if that working likely we don't need
to check the data registers which might be changing.

-Andi
