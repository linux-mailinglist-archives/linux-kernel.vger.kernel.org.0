Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFE115B90
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 09:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLGIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 03:09:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfLGIJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 03:09:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726B12173E;
        Sat,  7 Dec 2019 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575706182;
        bh=ka9twd3f9Ty1CXid7X6crb8J+0HJg7UfRGdoa9Nv64s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+SPt6vh/IIeHtU3r2uxwF0NrKJOZj9vsujceIkuISVHmj4XgMIUjyCmuSmz1DXn/
         UEt58uxJswsrA3NBZCWVGx8+kAkUUeXzLMV5oPKwpyCncTU+yULGcal4wYH7BYz0La
         gqSNfXSpZWCihftEKGUXVk8d8XTNOcGFf2k4e4kM=
Date:   Sat, 7 Dec 2019 09:09:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH v23 12/24] x86/sgx: Linux Enclave Driver
Message-ID: <20191207080939.GA193518@kroah.com>
References: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
 <20191028210324.12475-13-jarkko.sakkinen@linux.intel.com>
 <20191128182450.GA3493127@kroah.com>
 <20191206203807.GA9971@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206203807.GA9971@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:38:07PM +0200, Jarkko Sakkinen wrote:
> > Why a whole cdev?
> > 
> > Why not use a misc device?  YOu only have 2 devices right?  Why not 2
> > misc devices then?  That saves the use of a whole major number and makes
> > your code a _LOT_ simpler.
> 
> The downside would be that if we ever want to add sysfs attributes, that
> could not be done synchronously with the device creation.

That is what the groups member of struct misc_device is for.

greg k-h

