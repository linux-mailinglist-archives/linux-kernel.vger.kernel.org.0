Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4491616A38A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBXKKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:10:04 -0500
Received: from wind.enjellic.com ([76.10.64.91]:58030 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXKKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:10:04 -0500
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 01OA9XFG015606;
        Mon, 24 Feb 2020 04:09:33 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 01OA9Wqx015605;
        Mon, 24 Feb 2020 04:09:32 -0600
Date:   Mon, 24 Feb 2020 04:09:32 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v27 00/22] Intel SGX foundations
Message-ID: <20200224100932.GA15526@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 24 Feb 2020 04:09:33 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 07:25:37PM +0200, Jarkko Sakkinen wrote:

Good morning, I hope the week is starting well for everyone.

> Intel(R) SGX is a set of CPU instructions that can be used by
> applications to set aside private regions of code and data. The code
> outside the enclave is disallowed to access the memory inside the
> enclave by the CPU access control.

Do we misinterpret or is the driver not capable of being built in
modular form?

If not, it would appear that this functionality has been lost since
version 19 of the driver, admittedly some time ago.

> v19:
>
> ... [ deleted ] ...
>
> * Allow the driver to be compiled as a module now that it no code is using
>   its routines and it only uses exported symbols. Now the driver is
>   essentially just a thin ioctl layer.

Not having the driver available in modular form obviously makes work
on the driver a bit more cumbersome.

I'm assuming that the lack of module support is secondary to some
innate architectural issues with the driver?

Have a good day.

Dr. Greg


As always,
Dr. Greg Wettstein, Ph.D, Worker
IDfusion, LLC               SGX secured infrastructure and
4206 N. 19th Ave.           autonomously self-defensive platforms.
Fargo, ND  58102
PH: 701-281-1686            EMAIL: greg@idfusion.net
------------------------------------------------------------------------------
"If you get to thinkin' you're a person of some influence, try
 orderin' somebody else's dog around."
                                -- Cowboy Wisdom
