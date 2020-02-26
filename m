Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061A916F736
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgBZF1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:27:22 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35270 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBZF1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:27:22 -0500
Received: by mail-pf1-f181.google.com with SMTP id i19so853967pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DW6aJj3ErtWquq/vUizdKuwMNDtxgPJIy9riS2w/h6Q=;
        b=YHRSrZYCRUBe5pbUx3tsFD9OHwfi2bDB6P4D6U/ZIkN1j5wLKQSEjVRPh0Bzhbymhy
         NRMun1LA59+3Ulqhkwh9nEpQvRjGDr56TzOTd3pt7BFlCkHgX3o79E0tFC5aa0l4sTl+
         Fe9DHL6RbdV6Xys7TcE3rLSm5uAOcTZFs1v+4RDV8yKnfH5suRspz1j+CcLOGpLdTuLH
         QdmRWhuZReBBbsMsleTTXZ3TT4geGctdCKj66uHK3UceIpghbsUU+dQACPfV7vqFYTVz
         l/UeDIT0QVGyO2jTfi3KW00vJtWLLUW+WgXl/aG4wNSWOB6/fWMpAZh13GWjOTh1MjIe
         0QgA==
X-Gm-Message-State: APjAAAWqQaF60Ixhz8akMnLe8qZZb7pRt2e3aTxm4D+b2X/kxln4mlFE
        DWbPa1YHS8mdlneFVYJuzYy0fw==
X-Google-Smtp-Source: APXvYqzYdfBZoqzm4AxTe11XqYkHcXr0b5MwNbrkZXgPyqVTSF+wrMSzteJNKnEFVo9hZ96Iw8SjdA==
X-Received: by 2002:a63:7152:: with SMTP id b18mr2151335pgn.232.1582694841166;
        Tue, 25 Feb 2020 21:27:21 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id r8sm851139pjo.22.2020.02.25.21.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:27:20 -0800 (PST)
Subject: Re: [patch 00/10] x86/entry: Consolidation - Part I
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225213636.689276920@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <d903b970-4c90-d780-3988-033b6f72b5bd@kernel.org>
Date:   Tue, 25 Feb 2020 21:26:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225213636.689276920@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 1:36 PM, Thomas Gleixner wrote:
> Hi!
> 
> This is the first batch of a 73 patches series which consolidates the x86
> entry code.
> 

Egads!

If there's a v2, I don't suppose you could tweak your subject-prefix to
generate something like [patch part1 2/10]?

--Andy
