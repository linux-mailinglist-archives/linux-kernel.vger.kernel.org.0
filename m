Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7DFD764
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKOHy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 02:54:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41282 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOHy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:54:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so4709126ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+C6UFetkkOkabjlrx29bRj2f/pHq6ZunDxUzZ7B8oJI=;
        b=Tj7gXOnqtuG0wJhNZbvfhuhFF7Ajj+d/fkSs7BOhJuk6zYcUK3pqsPz4KlpJ5C6cZu
         CQ9MRWf2wM06ny9O2bnOKcTBNvY1ewmlHc0/L/nIx34DK3gZJOIMBOt6MJMcRJUnM6lj
         Sty8aREsnWc3bR9ednCLj5/uDLng1EyPh4j+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+C6UFetkkOkabjlrx29bRj2f/pHq6ZunDxUzZ7B8oJI=;
        b=cmZJCqNYcTzym+COH4b79ihO3F15GfDOypfUk/ul4N/IrGTeVDcIFicJum2bS/TzE4
         nUcgahRGLGcfapi86aBW+tUTrAWJqalfW5rIL4/lSOoU99wX9wZwGTvHY0s4ind9TfYn
         7G0upAQJJI4Ft8WYlWXDNt95E7KWynZRSFaBjngoAlHGr25aOFp5hrytb7i/a784vq7J
         JBpMEhiN7/KfEa5OZU4UhI9DYlfIPTUhN3AQhlBrQqwHAaMZgcH9Xgq6AIYfR5aHvcxr
         xExOMe7IWNMXJAWFiyvHBiw242uuTxGQOj/vIsaYWIXsL94hr8RXi8ExRb05v6d+e2+z
         uO7w==
X-Gm-Message-State: APjAAAUqx/1YtbFIWvqtAxuoaly1RY1WTnoHEHBDxLqpVlt9tvq0w5Jc
        gDqgWsQX8XcXQmKrwrfCj/68Ig==
X-Google-Smtp-Source: APXvYqwtca4V1MXOZa/BxeDe/jqUfjT4UHa/rribPRAykBqSAV8Y1dWumBHX7aG8dBwq5CyNgx3uLQ==
X-Received: by 2002:a2e:8809:: with SMTP id x9mr9979158ljh.82.1573804466324;
        Thu, 14 Nov 2019 23:54:26 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w11sm4254332lji.45.2019.11.14.23.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 23:54:25 -0800 (PST)
Subject: Re: [PATCH v4 46/47] net: ethernet: freescale: make UCC_GETH
 explicitly depend on PPC32
To:     Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, netdev <netdev@vger.kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-47-linux@rasmusvillemoes.dk>
 <CAOZdJXUX2cZfaQTkBdNrwD=jT2399rZzRFtDj6vNa==9Bmkh5A@mail.gmail.com>
 <CADRPPNS00uU+f6ap9D-pYQUFo_T-o2bgtnYaE9qAXOwck86-OQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <29b45e76-f384-fe16-0891-cc51cfecefd4@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 08:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNS00uU+f6ap9D-pYQUFo_T-o2bgtnYaE9qAXOwck86-OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 06.44, Li Yang wrote:
> On Thu, Nov 14, 2019 at 10:37 PM Timur Tabi <timur@kernel.org> wrote:
>>
>> On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>> Currently, QUICC_ENGINE depends on PPC32, so this in itself does not
>>> change anything. In order to allow removing the PPC32 dependency from
>>> QUICC_ENGINE and avoid allmodconfig build failures, add this explicit
>>> dependency.
>>
>> Can you add an explanation why we don't want ucc_geth on non-PowerPC platforms?

It's not that "we" don't want to allow building this on non-PPC per se,
but making it build requires some surgery that I think should be done by
whoever might eventually want it. So _my_ reason for lowering this
dependency from QUICC_ENGINE to UCC_GETH is exactly what it says above.

> I think it is because the QE Ethernet was never integrated in any
> non-PowerPC SoC and most likely will not be in the future. 

Well, that kind of thing is impossible to know for outsiders like me.
Maybe one can amend the commit log with that info:

"Also, the QE Ethernet has never been integrated on any non-PowerPC SoC
and most likely will not be in the future."

Rasmus
