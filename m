Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1BCE651
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfJGPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:01:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:4002 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGPB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:01:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 08:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="344756271"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.57])
  by orsmga004.jf.intel.com with ESMTP; 07 Oct 2019 08:01:22 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf: Fix inheritance of aux_output groups
In-Reply-To: <20191007144954.GA88143@gmail.com>
References: <20191004125729.32397-1-alexander.shishkin@linux.intel.com> <20191007144954.GA88143@gmail.com>
Date:   Mon, 07 Oct 2019 18:01:21 +0300
Message-ID: <875zl061mm.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
>
>> Commit
>> 
>>   b43762ef010 ("perf: Allow normal events to output AUX data")
>
> Missing 'a', the proper SHA1 is:
>
>     ab43762ef010 ("perf: Allow normal events to output AUX data")
>
> :-)

Ouch, sorry about that.

> Could this explain weird 'perf top' failures I'm seeing on my desktop, 
> which I was just about to debug and report?

Unlikely; to trigger the above you'd have to manually enable the
aux_output thingy and that would require HW support to begin with.

Thanks,
--
Alex
