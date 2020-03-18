Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9816618A775
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 22:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCRV5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 17:57:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:19058 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgCRV5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:57:10 -0400
IronPort-SDR: QTV/lR0BD5EfK0E5hw5845s000eBEhChgf51XMMhU1tMpNpZmZV5RxBpOaZUIp1jZEoxfpbhdz
 LHt4Oel4N9ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 14:57:09 -0700
IronPort-SDR: v9j6mfxfnTVRm2I76BvopjNp3dSoLUc71l8taasJprCc2O3EDoS0hki5Ma2WpCNgtn9hQ/llc5
 ymlQHKXxLuaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="446021875"
Received: from mbeldzik-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.127])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2020 14:57:00 -0700
Date:   Wed, 18 Mar 2020 23:56:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v28 00/22] Intel SGX foundations
Message-ID: <20200318215659.GA52244@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <8832f446-fbf1-f480-8cfa-848cc5101cb5@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8832f446-fbf1-f480-8cfa-848cc5101cb5@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:00:15AM -0700, Jordan Hand wrote:
> I tested with the Open Enclave SDK test suite (~200 test and sample
> enclaves), no issues. Used Intel PSW version 2.8.
> 
> Tested-by: Jordan Hand <jorhand@linux.microsoft.com>

OK, cool. Thank you.

/Jarkko
