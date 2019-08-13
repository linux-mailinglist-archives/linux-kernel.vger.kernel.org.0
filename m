Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D108C4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHMXvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 19:51:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41326 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:50:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so5323565pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 16:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IbdE2KInyJodKUCtVAuZWET2xZ1Z2VbKwChNL5TWr0E=;
        b=tiWVwA7MXIEKjOxUhtcMj2vPyJ3hrt228gcdYyuyb5dWj8kasr2oiJJyzvpnH4zoHt
         ednnnvUABZDftmPwfbOK8vYKnYHc5Z4OWqye5biEdebNY9yUaslTk7Osew6zTQG9q2at
         sZsn4qsDC4zsjPtPDJ65SUwmBpjrC/1/plw4KcWxddCvkxflKjy+Jvl8TM2VN7ARdUvr
         yd8I+ItzkJ2bGjMNML2KN/laTTtOw0ZdUUA/myO8KfbQQROuTSBr7CsnUq6Ih0akY4t1
         SP/ByUR4oHcjRM6MbRyO+/SP5+dorZ2ndig/aAyolw7yYiOmpZUtLrM/714g0UFPya9z
         kVIA==
X-Gm-Message-State: APjAAAVVIYHdoB0Bgsgv/OsSp7TVy9TzqbVkvHrafM+Pz6n0GJ6fDQWb
        UDO6NZzi1j3ZMG0UKcaZCMm84Q==
X-Google-Smtp-Source: APXvYqxNATMcBumSiCPFS8wNZtu0n7swBqrFa9SgTQsdLIQjGnQbyX6u8CwOsBbSclJCrlnkebwj+w==
X-Received: by 2002:a17:90a:2c9:: with SMTP id d9mr274835pjd.134.1565740258768;
        Tue, 13 Aug 2019 16:50:58 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 81sm163022302pfx.111.2019.08.13.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 16:50:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:50:58 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 16:49:25 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Add memmove string operation.
In-Reply-To: <20190812150446.GI26897@infradead.org>
CC:     nickhu@andestech.com, alankao@andestech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, green.hu@gmail.com, deanbo422@gmail.com,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com,
        Anup Patel <Anup.Patel@wdc.com>,
        Greg KH <gregkh@linuxfoundation.org>, alexios.zavras@intel.com,
        Atish Patra <Atish.Patra@wdc.com>, zong@andestech.com,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-ba92c635-7087-4783-baa5-2a111e0e2710@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 08:04:46 PDT (-0700), Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 03:19:14PM +0800, Nick Hu wrote:
>> There are some features which need this string operation for compilation,
>> like KASAN. So the purpose of this porting is for the features like KASAN
>> which cannot be compiled without it.
>>
>> KASAN's string operations would replace the original string operations and
>> call for the architecture defined string operations. Since we don't have
>> this in current kernel, this patch provides the implementation.
>>
>> This porting refers to the 'arch/nds32/lib/memmove.S'.
>
> This looks sensible to me, although my stringop asm is rather rusty,
> so just an ack and not a real review-by:
>
> Acked-by: Christoph Hellwig <hch@lst.de>

FWIW, we just write this in C everywhere else and rely on the compiler to 
unroll the loops.  I always prefer C to assembly when possible, so I'd prefer 
if we just adopt the string code from newlib.  We have a RISC-V-specific memcpy 
in there, but just use the generic memmove.

Maybe the best bet here would be to adopt the newlib memcpy/memmove as generic 
Linux functions?  They're both in C so they should be fine, and they both look 
faster than what's in lib/string.c.  Then everyone would benefit and we don't 
need this tricky RISC-V assembly.  Also, from the look of it the newlib code is 
faster because the inner loop is unrolled.
