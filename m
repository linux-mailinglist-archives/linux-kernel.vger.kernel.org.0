Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9E67F61
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfGNOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 10:37:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:58007 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:37:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 07:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,490,1557212400"; 
   d="scan'208";a="172004767"
Received: from hgenzken-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.131])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2019 07:36:54 -0700
Date:   Sun, 14 Jul 2019 17:36:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com
Subject: Re: [PATCH v21 00/28] Intel SGX foundations
Message-ID: <20190714143653.ziwgmtgysknxfgnl@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 08:07:36PM +0300, Jarkko Sakkinen wrote:
> v21:
> * Check on mmap() that the VMA does cover an area that does not have
>   enclave pages. Only mapping with PROT_NONE can do that to reserve
>   initial address space for an enclave.
> * Check om mmap() and mprotect() that the VMA permissions do not
>   surpass the enclave permissions.
> * Remove two refcounts from vma_close(): mm_list and encl->refcount.
>   Enclave refcount is only need for swapper/enclave sync and we can
>   remove mm_list refcount by destroying mm_struct when the process
>   is closed. By not having vm_close() the Linux MM can merge VMAs.
> * Do not naturally align MAP_FIXED address.
> * Numerous small fixes and clean ups.
> * Use SRCU for synchronizing the list of mm_struct's.
> * Move to stack based call convention in the vDSO.

I forgot something:

* CONFIG_INTEL_SGX_DRIVER is not bistate i.e. no more LKM support. It is
  still useful to have the compile-time option because VM host does not
  need to have it enabled. Now sgx_init() calls explicitly sgx_drv_init().
  In addition, platform driver has been ripped a way because we no
  longer need ACPI hotplug. In effect, the device is now parentless.
