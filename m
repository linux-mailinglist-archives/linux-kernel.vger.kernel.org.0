Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA7100FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 01:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfKSAOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 19:14:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33183 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:14:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id a24so15490880edt.0;
        Mon, 18 Nov 2019 16:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KvzBw5GEm6IKy7UcTEcP5CcHIg0pP5+1eixVP7EiPts=;
        b=hrf+XtvFLfe+2tOLSsp/bvTGHCcykVLxuj+j39jWN5sA+/9OaJ0tydnUCuPZ6jYDG2
         m8q9uF1NNhsscoPJ/ctXeAmBtr0Wnq3WUaWOuFhUY1V6+L0cMtpDWqiTmXBOt3RNHvf8
         yPtwBRAvBQ6f/9sb+9UkHpNkm9/ZJNJGVn9MNNmIP3M7EPHoOEg2Ao8k368uB22YlUYo
         WXYPj/Kx6kujVbLTr8qZvTDB4Q2eGrHWroGF4LcLTEFTUFk24z5WYvnV9+rF1/D1KhQi
         MOAtyI0VR2ojnErFvppR+Aktg25dXcoT79YGU7eFOlbb7wpHbUtEAm+PvZkhF+Bs+VgP
         rH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KvzBw5GEm6IKy7UcTEcP5CcHIg0pP5+1eixVP7EiPts=;
        b=DemYY90kDR0ngrwPzfeJrL89BLEz8jsntbtNcYe7Eb43gmH7hgA/lWpcSWMTbHioOs
         oDfJEO5zZccLXjhuH3aMYqQZvfaRXZjOQoDT1gRL1a6D1jITkEKM9kEtTdu8kYeUzHIZ
         qkahm3Hp2snzn7xu+SFMK7KHrCW3KR/TffYah3enElTkpjnxC6Je/r0axzF1eAhkApVe
         +ZAIizBH77cxmV0qkTLCGxtoSmekUtKu93KLmKRvc2CgRLVVqLvk78HsxzfuYFE9VMUQ
         ihzLUVxZkiUtr2b0dCL0FaxmciRdsvxVtfElzh7eOdbKpX5FJwxM5KYIY/krTlpaHE08
         q+EQ==
X-Gm-Message-State: APjAAAWL+d09FXFmRGbmkw/mhJqjtiKHsgU3buXWysiW+YEL2a53HvzW
        pJgg/J8Qhj+YC0UwA8vaHy4=
X-Google-Smtp-Source: APXvYqxo6PfSB2EpjNR7/L52kUiTalgNZmc1x1H2Nm1Kdbz2+wHBrmdMC6zbNFuV2nCC2godfJXU4g==
X-Received: by 2002:a17:906:5c06:: with SMTP id e6mr27480410ejq.195.1574122445324;
        Mon, 18 Nov 2019 16:14:05 -0800 (PST)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r9sm1113964edw.11.2019.11.18.16.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 16:14:04 -0800 (PST)
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     mark.rutland@arm.com, alexandre.belloni@bootlin.com,
        mhocko@suse.com, julien.thierry@arm.com, catalin.marinas@arm.com,
        christoffer.dall@arm.com, dhowells@redhat.com,
        yamada.masahiro@socionext.com, ryabinin.a.a@gmail.com,
        glider@google.com, kvmarm@lists.cs.columbia.edu, corbet@lwn.net,
        liuwenliang@huawei.com, daniel.lezcano@linaro.org,
        linux@armlinux.org.uk, kasan-dev@googlegroups.com,
        geert@linux-m68k.org, dvyukov@google.com,
        bcm-kernel-feedback-list@broadcom.com, drjones@redhat.com,
        vladimir.murzin@arm.com, keescook@chromium.org, arnd@arndb.de,
        marc.zyngier@arm.com, andre.przywara@arm.com, pombredanne@nexb.com,
        jinb.park7@gmail.com, tglx@linutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, nico@fluxnic.net,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob@landley.net, philip@cog.systems, akpm@linux-foundation.org,
        thgarnie@google.com, kirill.shutemov@linux.intel.com
References: <20190617221134.9930-1-f.fainelli@gmail.com>
 <20191114181243.q37rxoo3seds6oxy@pengutronix.de>
 <7322163f-e08e-a6b7-b143-e9d59917ee5b@gmail.com>
 <20191115070842.2x7psp243nfo76co@pengutronix.de>
 <20191115114416.ba6lmwb7q4gmepzc@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <60bda4a9-f4f8-3641-2612-17fab3173b29@gmail.com>
Date:   Mon, 18 Nov 2019 16:13:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115114416.ba6lmwb7q4gmepzc@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 3:44 AM, Marco Felsch wrote:
> 
> With your v7 it is working on my imx6 but unfortunately I can't run my
> gstreamer testcase. My CPU load goes to 100% after starting gstreamer
> and nothing happens.. But the test_kasan module works =) So I decided to
> check a imx6quadplus but this target did not boot.. I used another
> toolchain for the imx6quadplus gcc-9 instead of gcc-8. So it seems that
> something went wrong during compilation. Because you didn't changed
> something within the logic.
> 
> I wonder why we must not define the CONFIG_KASAN_SHADOW_OFFSET for arm.

That is was oversight. I have pushed updates to the branch here:

https://github.com/ffainelli/linux/pull/new/kasan-v7

which defines CONFIG_KASAN_SHADOW_OFFSET from the PAGE_OFFSET value
directly, and recalculate KASAN_SHADOW_START/END accordingly using the
same formula as ARM64.

can you try them out? If that still does not work, can you detail the
imx6qdp memory layout a little more? Any chance of running a kernel with
DEBUG_LL/EARLYPRINTK turned on so we can see where the problem could be?
-- 
Florian
