Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290F7A6B94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfICOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 10:33:00 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58196 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfICOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:33:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 44BA53F4A9;
        Tue,  3 Sep 2019 16:32:48 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=bDjRxB8O;
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
        with ESMTP id oW0OkYyiGZjb; Tue,  3 Sep 2019 16:32:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 3C3E93F2FD;
        Tue,  3 Sep 2019 16:32:46 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A7BDE360160;
        Tue,  3 Sep 2019 16:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567521165; bh=/805ZXlNYXSisVqi0x/md+Q3IesljeoqWyVEVyrXk8Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bDjRxB8OMjXkoKyTdgxOneprJuQBuRVgZLRziMd2Pmu8V/sbBYIUQNwDgPg06gMCb
         Fvfyr2FYvcLgGITa8JY0QnqXW79ZGQwKBmiWZ2uRpxcBEaKpIClkhDlaf63H/w5kU4
         GNUAJGnGglDhyly3tg6UiNiVv4lg4rQzf+7MCi6M=
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
To:     Christoph Hellwig <hch@infradead.org>
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
Date:   Tue, 3 Sep 2019 16:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190903134627.GA2951@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

On 9/3/19 3:46 PM, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 03:15:01PM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> The force_dma_unencrypted symbol is needed by TTM to set up the correct
>> page protection when memory encryption is active. Export it.
> NAK.  This is a helper for the core DMA code and drivers have no
> business looking at it.

Is this a layer violation concern, that is, would you be ok with a 
similar helper for TTM, or is it that you want to force the graphics 
drivers into adhering strictly to the DMA api, even when it from an 
engineering perspective makes no sense?

If it's the latter, then I would like to reiterate that it would be 
better that we work to come up with a long term plan to add what's 
missing to the DMA api to help graphics drivers use coherent memory?

Thanks,

Thomas


