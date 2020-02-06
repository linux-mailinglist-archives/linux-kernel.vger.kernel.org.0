Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3396D1545F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBFOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 09:21:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbgBFOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580998904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1NHUo5yQAkCKpQ/gtz43IUIp+O0qG9I4nh1OcLn2g4=;
        b=D4Qoe6oxGmPFY38tXH0Bzx90zfQ3LGwEX8ttJBEA+ti61Tuh9bdUivGmsRvO/S8dOpziGL
        RNP1SjorefO0HF7Wd5NnXeHt7NtdPIijXTvm5rfSFbFRrXgtGJLhtPu7QAzhroeMlDGLNi
        fhHTxxCIOhEsw6VNoqrpiKYQ62G0r3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-UeeXuSS7PLmol8P47ewmDw-1; Thu, 06 Feb 2020 09:21:41 -0500
X-MC-Unique: UeeXuSS7PLmol8P47ewmDw-1
Received: by mail-wr1-f70.google.com with SMTP id x15so3440964wrl.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p1NHUo5yQAkCKpQ/gtz43IUIp+O0qG9I4nh1OcLn2g4=;
        b=H9eA7t4KvQiHvsKRMNRW7G6wL3/PPGFJ8CCNID6sskH189UEwqBfFtXgzTRO5nGysZ
         ojYRKQj2zwuMRhANAGMOafzlCeAi4yrcLSKC+5oraBalznFqaF7+ay8XZI96z3ybr/Vc
         GUkM1YD7vZBotAhtHhd9xTwVfVJYgq17xAjwLatwfdfPtKjDQXkzNPij7QkTQ5DQDsI5
         meOg70/2NgjBQNg/bnjKsl7SpURKrqCoVvDeS2sbTJAMDHutBfrpY4zPsV6/e0wFOcnz
         PeKTPZkfUdqM7SZByihLL+5SyFMa74YF3cPM35SJDFwkMnfC1Jdh3hTTdX4KK87FWbi4
         VSnQ==
X-Gm-Message-State: APjAAAWJFVSHayqG87yaIY7Vak1aTv3i3sk6le30Wk2kD3zyuhxshNQp
        GpXjl+Ltc80Df2xDh4gTRLL/HbGzftbob/Oyuv+hss8V0WVsr0XjNZY6Gt5hEXSpphQ7xK0zPVG
        oYUGZ/7eTgDpi/qILo9ncW6yt
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr4057196wrt.70.1580998900571;
        Thu, 06 Feb 2020 06:21:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmKqbasnwi3c9xJwfBnQhwneGX9h1gBvBaMW2W0NIbjIO6EvQ3zKfNpz+yqNd1aMOaSsJviw==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr4057175wrt.70.1580998900322;
        Thu, 06 Feb 2020 06:21:40 -0800 (PST)
Received: from [10.201.49.5] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id w7sm3804381wmi.9.2020.02.06.06.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:21:39 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: relax conditions for allowing
 MSR_IA32_SPEC_CTRL accesses
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     dgilbert@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1580915628-42930-1-git-send-email-pbonzini@redhat.com>
 <87v9ojg5r1.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d7f50a2-3c3f-dd18-a635-aa4eaa757fa3@redhat.com>
Date:   Thu, 6 Feb 2020 15:21:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87v9ojg5r1.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/20 15:17, Vitaly Kuznetsov wrote:
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> but out of pure curiosity, why do we need these checks?
> 
> At least for the 'set' case right below them we have:
> 
>         if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
>                  return 1;
> 
> so if guest will try using unsupported features it will #GP. So
> basically, these checks will only fire when reading/writing '0' and all
> features are missing, right? Do we care?

Probably not...  I just wanted the smallest possible change in semantics
for this patch, and the rest can be done equally on Intel and AMD.

Paolo

