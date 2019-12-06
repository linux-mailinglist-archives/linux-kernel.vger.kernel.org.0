Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48B8115559
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLFQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 11:29:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:29132 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfLFQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:29:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 08:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,285,1571727600"; 
   d="scan'208";a="294897302"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2019 08:29:40 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 31845300B57; Fri,  6 Dec 2019 08:29:40 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:29:40 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, haiyanx.song@intel.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/pmu-events: Fix Kernel_Utilization metric
Message-ID: <20191206162940.GC752382@tassilo.jf.intel.com>
References: <20191204162121.29998-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204162121.29998-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:51:21PM +0530, Ravi Bangoria wrote:
> Kernel Utilization should divide ref cycles spent in kernel with total
> ref cycles.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
