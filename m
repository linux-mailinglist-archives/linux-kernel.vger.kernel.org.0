Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987E0A6A50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfICNqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:46:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfICNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gTi+Kwk/Sh4HjQRHVsfg/kJo/zLf+TkFRm1CC95t0vk=; b=qs0T9oBBMZY6Iw76l3l8xlnab/
        bqUD8rhC9gVGdXA7UMdbgp+Ry55f8PpycgAT6Oj9Hcno8hs3FxJE+BycokWufyDaRa2TZghzk2Q4y
        esI3EMkqVjtBpbe+mi/1PYg9sXMFpeIcAqfHPQCCBA8AIv0BF2F0pYnpM3S3tJ1eVonqPP8udw2qM
        Stfqlm/F9FMFwEkzJ4zRNyG3L9JAJ6tfHtsrGZAEkv+JcexShpVtl95n5ZaAeTlZJp50dRjLMStBU
        q70hvz7qXiNh8zG/kVDMhI7gFapiwhQSCDqECVBsJ/ZEuSAkr8+e+z8weM1lkfYZX0tJxvATrZndD
        peDHBSsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i598e-00023F-Er; Tue, 03 Sep 2019 13:46:28 +0000
Date:   Tue, 3 Sep 2019 06:46:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
Message-ID: <20190903134627.GA2951@infradead.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903131504.18935-2-thomas_os@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:15:01PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The force_dma_unencrypted symbol is needed by TTM to set up the correct
> page protection when memory encryption is active. Export it.

NAK.  This is a helper for the core DMA code and drivers have no
business looking at it.
