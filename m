Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4395A1534E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 17:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBEQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 11:01:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:51128 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbgBEQB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:01:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 08:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="249748972"
Received: from hhuan26-mobl1.amr.corp.intel.com ([10.254.98.107])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2020 08:01:19 -0800
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v25 00/21] Intel SGX foundations
References: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
Date:   Wed, 05 Feb 2020 10:01:19 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.0fiushlkwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
In-Reply-To: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tested-by: Haitao Huang<haitao.huang@linux.intel.com>
