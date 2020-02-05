Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E941153BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBEXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 18:10:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OpteY3pqyJOegINhrkFl2LRAOQcd5HtMxrq0VGNRpg4=; b=ojXmQoxcKZBsge8JycLCU4LgVM
        nJmtV09nuPZ4cGxTCkcS8isckjlq1lPN3/dZaGD12BmdMoUnlahunIO6dv/m13+bhEM8QNrjR8sgp
        aw46CC22ePRU6KjIwOOljCVvV964hz31uLFEe5YD2j9nd/4EzAvW6BEFsCQ0yus0FvYW8wKL7jWI1
        90zDe5GlAnC+w+u1ZY9mR3fm+Bq+HdaUbjWBLzmb0sUofvcQJf6zhQ6jaMHffDxM9O2NguCS03oXY
        bTnQjzuYR3FsIdTK4k7bAwee/5GtBPyL0m0cGx8sVVGnSIQZkwE0TzVg8XL/trhBiwatpyGICFR8x
        vxMBmYNQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izTon-0005Dk-CV; Wed, 05 Feb 2020 23:10:49 +0000
Subject: Re: [PATCH v25 21/21] docs: x86/sgx: Document SGX micro architecture
 and kernel internals
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-doc@vger.kernel.org
References: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
 <20200204060545.31729-22-jarkko.sakkinen@linux.intel.com>
 <5ea28632-cd64-bc26-fab6-2868142eb9e4@infradead.org>
 <20200205230756.GB28111@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64d57033-cd19-ae6f-48c5-d7e01a97ad5e@infradead.org>
Date:   Wed, 5 Feb 2020 15:10:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205230756.GB28111@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 3:07 PM, Jarkko Sakkinen wrote:
> I rewrote it as:
> 
> "Intel provides a proprietary binary version of the PCE. This is a
> necessity when the software needs to prove to be running inside a legit

s/legit/legitimate/ please

> enclave on real hardware."


-- 
~Randy

