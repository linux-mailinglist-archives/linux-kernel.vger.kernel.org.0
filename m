Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EA16635A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgBTQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:43:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:58222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBTQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:43:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 08:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="436646426"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2020 08:43:17 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 512A43018BB; Thu, 20 Feb 2020 08:43:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 08:43:17 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 0/5] Support metric group constraint
Message-ID: <20200220164317.GG160988@tassilo.jf.intel.com>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <20200220113924.GB565976@krava>
 <534b4b99-466a-0a5b-e9f5-b4711abd8a4a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534b4b99-466a-0a5b-e9f5-b4711abd8a4a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For other metric groups, even they have cycles, the issue should not be
> triggered.
> For example, if they have 4 or less events, the cycles can be scheduled to
> GP counter instead.
> If they have 6 or more events, the weak group will be reject anyway.
> Perf tool will open it as non-group (standalone metrics).

Technically it can also happen for 9 events with Hyper Threading off or
on Icelake (8 generic counters)

I didn't think we had any of those, but please double check.

-Andi
