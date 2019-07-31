Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA97C44B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGaOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:02:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:44779 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaOCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:02:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 07:02:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="196363057"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2019 07:02:06 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/7] perf/x86/intel: Support PEBS output to PT
In-Reply-To: <20190729133705.GC31381@hirez.programming.kicks-ass.net>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com> <20190704160024.56600-3-alexander.shishkin@linux.intel.com> <20190729133705.GC31381@hirez.programming.kicks-ass.net>
Date:   Wed, 31 Jul 2019 17:02:05 +0300
Message-ID: <871ry6480y.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jul 04, 2019 at 07:00:19PM +0300, Alexander Shishkin wrote:
>> +	/*
>> +	 * In case there's a mix of PEBS->PT and PEBS->DS, fall back
>> +	 * to DS.
>> +	 */
>
> I thought we disallowed that from happening !?

Yes, that was a weird leftover.

Thanks a bunch for the comments, they should all be addressed in v2:
https://marc.info/?l=linux-kernel&m=156458152126310

Regards,
--
Alex
