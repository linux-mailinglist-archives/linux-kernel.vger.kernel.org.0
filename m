Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D413F17EAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 22:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCIVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 17:16:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:27405 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgCIVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:16:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 14:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="441054693"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2020 14:16:39 -0700
Date:   Mon, 9 Mar 2020 14:16:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v28 16/22] x86/sgx: Add a page reclaimer
Message-ID: <20200309211639.GB19235@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-17-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303233609.713348-17-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:36:03AM +0200, Jarkko Sakkinen wrote:
> +static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
> +				struct sgx_backing *backing)
> +{
> +	struct sgx_encl_page *encl_page = epc_page->owner;
> +	struct sgx_encl *encl = encl_page->encl;
> +	struct sgx_backing secs_backing;
> +	int ret;
> +
> +	mutex_lock(&encl->lock);
> +
> +	if (atomic_read(&encl->flags) & SGX_ENCL_DEAD) {
> +		ret = __eremove(sgx_epc_addr(epc_page));
> +		WARN(ret, "EREMOVE returned %d\n", ret);

This should use ENCLS_WARN().

> +	} else {
> +		sgx_encl_ewb(epc_page, backing);
> +	}
> +
> +	encl_page->epc_page = NULL;
> +	encl->secs_child_cnt--;
> +
> +	if (!encl->secs_child_cnt) {
> +		if (atomic_read(&encl->flags) & SGX_ENCL_DEAD) {
> +			sgx_free_page(encl->secs.epc_page);
> +			encl->secs.epc_page = NULL;
> +		} else if (atomic_read(&encl->flags) & SGX_ENCL_INITIALIZED) {
> +			ret = sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
> +						   &secs_backing);
> +			if (ret)
> +				goto out;
> +
> +			sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
> +
> +			sgx_free_page(encl->secs.epc_page);
> +			encl->secs.epc_page = NULL;
> +
> +			sgx_encl_put_backing(&secs_backing, true);
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&encl->lock);
> +}
