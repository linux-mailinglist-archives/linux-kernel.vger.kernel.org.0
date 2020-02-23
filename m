Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8B1698C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBWRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:05:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:60177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWRFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:05:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 09:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="237086329"
Received: from ajbergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.23.203])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2020 09:05:35 -0800
Date:   Sun, 23 Feb 2020 19:05:33 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v26 22/22] docs: x86/sgx: Document SGX micro architecture
 and kernel internals
Message-ID: <20200223170533.GC5074@linux.intel.com>
References: <01067247-f6ff-21f6-774f-cbb6e72bc99e@infradead.org>
 <20200223170437.GB5074@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223170437.GB5074@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 07:04:37PM +0200, Jarkko Sakkinen wrote:
> Updated here:
> 
> https://github.com/jsakkine-intel/linux-sgx/commit/ff441923faa78b0695402424f172aa5838e9f754

Wrong (old) commit ID, this is the right one:

https://github.com/jsakkine-intel/linux-sgx/commit/7fff0e7d96a4b230d7bd5b84c0b51c3ce740f0fb

/Jarkko
