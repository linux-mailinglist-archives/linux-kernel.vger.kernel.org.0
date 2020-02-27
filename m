Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1517114C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgB0HOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 02:14:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:26557 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbgB0HOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:14:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 23:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="272074904"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2020 23:14:51 -0800
Subject: Re: [PATCH V2 03/13] kprobes: Add symbols for kprobe insn pages
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200212124949.3589-1-adrian.hunter@intel.com>
 <20200212124949.3589-4-adrian.hunter@intel.com>
 <20200226152200.GB217283@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <435d04f9-15c7-e153-ac19-d9d7bebc170a@intel.com>
Date:   Thu, 27 Feb 2020 09:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226152200.GB217283@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/20 5:22 pm, Jiri Olsa wrote:
> On Wed, Feb 12, 2020 at 02:49:39PM +0200, Adrian Hunter wrote:
>> Symbols are needed for tools to describe instruction addresses. Pages
>> allocated for kprobe's purposes need symbols to be created for them.
>> Add such symbols to be visible via /proc/kallsyms.
> 
> I can't see kprobes in /proc/kallsyms, I tried making some with
> perf probe and some of bcc-tools.. I'm greping for [kprobe]
> 
> could you put to changelog soem example /proc/kallsyms output?

Will do.  See also the examples in patch 13.

For kprobes you need:

	# CONFIG_FUNCTION_TRACER is not set

otherwise the kprobes are done by ftrace.
