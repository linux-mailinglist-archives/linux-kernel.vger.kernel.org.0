Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41479195E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHRTqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 15:46:55 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:34998 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfHRTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:46:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0F77D3F398;
        Sun, 18 Aug 2019 21:46:53 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=AOwH3yEK;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hq_vKa0TXAWL; Sun, 18 Aug 2019 21:46:52 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id CFEAD3F382;
        Sun, 18 Aug 2019 21:46:50 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 144693600A4;
        Sun, 18 Aug 2019 21:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566157610; bh=O23fLuRKZE2WM5z0E5EtZeLc2A4eFRDzz0RW+Kv8zXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AOwH3yEKgWjMZe1BssHhukNN4WQBQ2BQqGCZX58JmzGFwgCidQqrKARYbgrM9sivE
         MQoaYt5YHkyLcP+naZvrxI7lau+2NfMXI3ki1IBvtI1qDon8gObTRInspCg63FCYgk
         OhcE9+8rOlk6CPU2khLIOa7tyR557A8jUNfRoJu0=
Subject: Re: [PATCH 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-2-thomas_os@shipmail.org>
 <alpine.DEB.2.21.1908182118260.1923@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <a35a8e27-35f5-c9da-ad2f-c26a12f05408@shipmail.org>
Date:   Sun, 18 Aug 2019 21:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908182118260.1923@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/19 9:20 PM, Thomas Gleixner wrote:
> On Sun, 18 Aug 2019, Thomas Hellström (VMware) wrote:
>
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Vmware has historically used an "inl" instruction for this, but recent
>> hardware versions support using VMCALL/VMMCALL instead, so use this method
>> if supported at platform detection time. We explicitly need to code
>> separate macro versions since the alternatives self-patching has not
>> been performed at platform detection time.
>>
>> We also put tighter constraints on the assembly input parameters and update
>> the SPDX license info.
> Can you please split the license stuff into a separate patch? You know, one
> patch one thing. It's documented for a reason.
>
> While at it could you please ask your legal folks whether that custom
> license boilerplate can go away as well?

Sure, I'll drop that from the series for now.

Thanks,

/Thomas


