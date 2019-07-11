Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87365AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfGKPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 11:50:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:41948 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGKPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:50:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 08:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="341420084"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by orsmga005.jf.intel.com with ESMTP; 11 Jul 2019 08:50:37 -0700
Date:   Thu, 11 Jul 2019 08:50:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Xing, Cedric" <cedric.xing@intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        haitao.huang@intel.com, kai.svahn@intel.com, kai.huang@intel.com
Subject: Re: [RFC PATCH v2 0/3] An alternative __vdso_sgx_enter_enclave() to
 allow enclave/host parameter passing using untrusted stack
Message-ID: <20190711155037.GB15067@linux.intel.com>
References: <cover.1555965327.git.cedric.xing@intel.com>
 <20190424062623.4345-1-cedric.xing@intel.com>
 <20190710111719.nnoedfo4wvbfghq7@linux.intel.com>
 <686e47d2-f45c-6828-39d1-48374925de6c@intel.com>
 <20190710224628.epjxwlpqqxdurmzo@linux.intel.com>
 <20190710231538.dkc7tyeyvns53737@linux.intel.com>
 <27cf0fc7-71c6-7dc1-f031-86bf887f1fe1@intel.com>
 <20190711093809.4ogxe25laeoyp4ve@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711093809.4ogxe25laeoyp4ve@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 12:38:09PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 10, 2019 at 04:37:41PM -0700, Xing, Cedric wrote:
> > We are not judging which vessel is better (or the best) among all possible
> > vessels. We are trying to enable more vessels. Every vessel has its pros and
> > cons so there's *no* single best vessel.
> 
> I think reasonable metric is actually the coverage of the Intel SDK
> based enclaves. How widely are they in the wild? If the user base is
> large, it should be reasonable to support this just based on that.

Large enough that Andy agreed to take the vDSO code with the optional
callback, despite his personal opinion being that mucking with uR{B,S}P
from within the enclave is poor form.
