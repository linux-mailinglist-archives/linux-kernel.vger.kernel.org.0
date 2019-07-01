Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C22B5C155
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfGAQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 12:41:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:13146 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfGAQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:41:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="163736354"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2019 09:41:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 14D8430120F; Mon,  1 Jul 2019 09:41:05 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:41:05 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] x86/xsave: Make XSAVE check the base CPUID
 features before enabling
Message-ID: <20190701164105.GC31027@tassilo.jf.intel.com>
References: <20171005215256.25659-1-andi@firstfloor.org>
 <20171005215256.25659-5-andi@firstfloor.org>
 <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
 <20190701121710.vardxktdc63gtcj5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701121710.vardxktdc63gtcj5@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So if it is unlikely to have XSAVE but no FXSR I would suggest to add
> "fpu__xstate_clear_all_cpu_caps()" to nofxsr and behave like "nofxsr
> noxsave".

Thanks for the analysis Sebastian. Makes sense.

This would likely work, but I think I would rather just remove the option.

-Andi
