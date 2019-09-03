Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808D2A72C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfICSue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 14:50:34 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:35884 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfICSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:50:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7867B40D0C;
        Tue,  3 Sep 2019 20:50:26 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Wr03xhIO;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NRcii8GsqU50; Tue,  3 Sep 2019 20:50:24 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A531140D00;
        Tue,  3 Sep 2019 20:50:21 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F006B360160;
        Tue,  3 Sep 2019 20:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567536621; bh=COg09Ux0mAj//sB2QvfCBwzBAr1fbPeuGcgSSK2ZdU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wr03xhIOR9RY1X7HM9n6S4aNVT4eh1EuOiQlamFgfHQhTzA7Jlg54IpQfOHl4oh9X
         FxVqArRVh/nJ7docmuE1Hd4XzXWNT0mBIIpx8epKwTdRRFagABN3dv9ifbfiCatN05
         r44eXTidjSL7x/AtoKO24fXm5sjHe4AU9QPZyZNs=
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
To:     Dave Hansen <dave.hansen@intel.com>,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
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
 <10077630-7081-1e57-adc1-222a8d8044a9@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <1bec048b-8633-4f65-0657-41f65271bcce@shipmail.org>
Date:   Tue, 3 Sep 2019 20:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <10077630-7081-1e57-adc1-222a8d8044a9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 5:14 PM, Dave Hansen wrote:
> On 9/3/19 6:15 AM, Thomas Hellström (VMware) wrote:
>> The force_dma_unencrypted symbol is needed by TTM to set up the correct
>> page protection when memory encryption is active. Export it.
> It would be great if this had enough background that I didn't have to
> look at patch 4 to figure out what TTM might be.
>
> Why is TTM special?  How many other drivers would have to be modified in
> a one-off fashion if we go this way?  What's the logic behind this being
> a non-GPL export?

TTM tries to abstract mapping of graphics buffer objects regardless 
where they live. Be it in pci memory or system memory. As such it needs 
to figure out the proper page protection. For example if a buffer object 
is moved from pci memory to system memory transparently to a user-space 
application, all user-space mappings need to be killed and then 
reinstated pointing to the new location, sometimes with a new page 
protection.

I try to keep away as much as possible from the non-GPL vs GPL export 
discussions. I have no strong opinion on the subject. Although since 
sev_active() is a non-GPL export, I decided to mimic that.

Thanks
Thomas



