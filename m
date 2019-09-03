Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7179A5F81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 05:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfICDAc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Sep 2019 23:00:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:9424 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfICDAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:00:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 20:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; 
   d="scan'208";a="357606549"
Received: from kmsmsx154.gar.corp.intel.com ([172.21.73.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2019 20:00:30 -0700
Received: from pgsmsx109.gar.corp.intel.com (10.221.44.109) by
 KMSMSX154.gar.corp.intel.com (172.21.73.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Sep 2019 11:00:28 +0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.48]) by
 PGSMSX109.gar.corp.intel.com ([169.254.14.101]) with mapi id 14.03.0439.000;
 Tue, 3 Sep 2019 11:00:29 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] perf/x86/intel: Update ICL Core and Package C-state
 event counters
Thread-Topic: [PATCH] perf/x86/intel: Update ICL Core and Package C-state
 event counters
Thread-Index: AQHVQ5PIUsijJvZMx0u0Sspcp/PXuqcTQD8AgAY/qEY=
Date:   Tue, 3 Sep 2019 03:00:28 +0000
Message-ID: <6089B7674E6F464F847AB76B599E0EAA789D44BE@PGSMSX102.gar.corp.intel.com>
References: <20190726090846.6109-1-harry.pan@intel.com>,<20190830113334.GF2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190830113334.GF2369@hirez.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.42]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Peter for pointing out my miss, I appreciate that sincerely.

>   *   MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
>   *                          perf code: 0x01
>   *                          Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
> -                                             CNL
> +                                             CNL,ICL

That has a missing * introduced by the last such patch. Please take this
opportunity to put it back in.
