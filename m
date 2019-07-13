Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7267AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfGMPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 11:06:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:42612 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:06:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 08:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,486,1557212400"; 
   d="scan'208";a="318270918"
Received: from hbriegel-mobl.ger.corp.intel.com ([10.252.50.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 08:06:02 -0700
Message-ID: <44880ee6ade1c7135ebdc01c2b974723db82e2e4.camel@linux.intel.com>
Subject: Re: [RFC PATCH v4 2/3] x86/vdso: Modify __vdso_sgx_enter_enclave()
 to allow parameter passing on untrusted stack
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Cedric Xing <cedric.xing@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
Date:   Sat, 13 Jul 2019 18:06:01 +0300
In-Reply-To: <db6c62c41eb210f559f70dd32f8f6e0b4729300b.camel@linux.intel.com>
References: <cover.1563000446.git.cedric.xing@intel.com>
         <e3987c04e44c3d366d762c22d6e692e043d0580b.1563000446.git.cedric.xing@intel.com>
         <db6c62c41eb210f559f70dd32f8f6e0b4729300b.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-13 at 18:04 +0300, Jarkko Sakkinen wrote:
> I already manually removed those changes already from previous version.

I wonder why this was posted anyway given that there was no
improvement. Anyway, I'll use the previous version.

/Jarkko 

