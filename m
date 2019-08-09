Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7316887728
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406407AbfHIKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 06:24:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHIKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:24:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so97781582wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 03:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRs9/vnl2x2fSDyEARf9rQa4tsoVDu7LpU0anhH+GLg=;
        b=Amog/8v9JziCSpkaV4yN8bfEfDQUsErMmObe0d0cHNZFgBTGctJqbjgoRQvRlDGpcS
         uIB7h1i8x3Zl9UQI4Jms85ziej2Igo6gvD4WBNk6vCb4KOYR4KHOvyftDsQN1NBsj7v+
         Ai16/jMt8L3BkBrJXvybBSTyQzdasXaQmRANEnxwBQRnzNeYffsKowgs5hF+z+hiV9My
         MEOh+S//EEAy3+88YaNhopeapKVy5/fVZa+L0GDCqdVZ5crR+enjY8TliVWuSvVUhRBI
         5dusLsfaIZI/rdroP947J3M5eNELNGvsxYGqFrmcS5CC2vtqX/vvi7TP6FV40cz6Ni1F
         cenQ==
X-Gm-Message-State: APjAAAW4DObqL/iims3WW/tbu4nttBjRsl/MA7zeZlaNoBDKfWJjiT0r
        EcmweKgRccgqxaJtsKsbz1zqEg==
X-Google-Smtp-Source: APXvYqx+uVkNssaIPX1SaKsQj+Z2Ktk1Buf8b3UqK4gB/0g65Hj8oHdWFOkI3Ei7n/L7LZzoAnP6iw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr15381943wrs.108.1565346250170;
        Fri, 09 Aug 2019 03:24:10 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id l25sm5040146wme.13.2019.08.09.03.24.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 03:24:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Periodically revaluate appropriate
 lapic_timer_advance_ns
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1565329531-12327-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fad8ceed-8b98-8fc4-5b6a-63bbca4059a8@redhat.com>
Date:   Fri, 9 Aug 2019 12:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565329531-12327-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/19 07:45, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Even if for realtime CPUs, cache line bounces, frequency scaling, presence 
> of higher-priority RT tasks, etc can cause different response. These 
> interferences should be considered and periodically revaluate whether 
> or not the lapic_timer_advance_ns value is the best, do nothing if it is,
> otherwise recaluate again. 

How much fluctuation do you observe between different runs?

Paolo
