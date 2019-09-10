Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD060AE3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfIJG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 02:26:08 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44088 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIJG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:26:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 06CFE3FCAD;
        Tue, 10 Sep 2019 08:26:00 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PMXmrPRZ;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p1Q5uxKwuk5g; Tue, 10 Sep 2019 08:25:59 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 0B7013FCA8;
        Tue, 10 Sep 2019 08:25:56 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8BB9536007E;
        Tue, 10 Sep 2019 08:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568096756; bh=FIsOVU9sEdD7eTcpsHsOzRwFVOc3rhd5yiOdJ+Zt71Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PMXmrPRZaYzzK46IhmFaiBLdKoWKRFHkazdUlhqdGIYJpfBSMgvl06AaCA2vndHYD
         zj7PDNJJfFZkbMcNnP7i9T8XLCgm0p06zFmVHCx5EWB1yrEO6de6HOAt2gMhpFu2qr
         xzZ7xq4NMS+j05XbMrowIlDg++h5DtKrsN/JIkw4=
Subject: Re: [RFC PATCH 0/2] Fix SEV user-space mapping of unencrypted
 coherent memory
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        pv-drivers@vmware.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905112311.GA10199@infradead.org> <20190910061110.GA10968@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <ff56161d-3c0c-30e9-448f-d450578f772d@shipmail.org>
Date:   Tue, 10 Sep 2019 08:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190910061110.GA10968@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 8:11 AM, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 04:23:11AM -0700, Christoph Hellwig wrote:
>> This looks fine from the DMA POV.  I'll let the x86 guys comment on the
>> rest.
> Do we want to pick this series up for 5.4?  Should I queue it up in
> the dma-mapping tree?

Hi, Christoph

I think the DMA change is pretty uncontroversial.

There are still some questions about the x86 change: After digging a bit 
deeper into the mm code I think Dave is correct about that we should 
include the sme_me_mask in _PAGE_CHG_MASK.

I'll respin that patch and then I guess we need an ack from the x86 people.

Thanks,
Thomas


