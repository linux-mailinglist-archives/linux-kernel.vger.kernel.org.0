Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219D311DE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 02:10:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:8694 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfLMHKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:10:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 23:10:02 -0800
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208368732"
Received: from peterhae-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.100])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 23:09:58 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [perf] perf_fuzzer triggers NULL pointer derefernce in i915 driver
In-Reply-To: <alpine.DEB.2.21.1912121032420.15237@macbook-air>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <alpine.DEB.2.21.1912121032420.15237@macbook-air>
Date:   Fri, 13 Dec 2019 09:09:59 +0200
Message-ID: <87tv641z20.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Vince Weaver <vincent.weaver@maine.edu> wrote:
> with current git the perf_fuzzer was able to trigger this NULL pointer
> de-reference in the i915 driver.

Please file a bug.

https://gitlab.freedesktop.org/drm/intel/wikis/How-to-file-i915-bugs

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
