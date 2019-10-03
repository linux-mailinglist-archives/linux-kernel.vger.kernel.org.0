Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947F5C9C61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfJCKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 06:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfJCKdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:33:02 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 645BE2A09A2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2019 10:33:02 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k184so955304wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TDB02z0QH3vJLwWOjOv1DtoyGTjTT6QfGUMhQzSF13g=;
        b=Ufw7uMdUpHuUW96M4S4cwZSPu+FGTS0+mMKTitMnBtfse3GJLDBYaInYQQ071u+Tll
         co/aLUiLCYB9NSL62Z7cMPW0i4SaylrRiv/azwaqhQiQ6SM4ObdI22c05h9JfJUfrxvq
         k8U9BMedHme+LBaT3wO2FqHzwgmVE/BjP1Lomzw6NhkTa1ukJfEEsq+obJy8DpPgmD7a
         QDJDGOQBw5bjsnNOnjmBSBasouPr9Q6F0o6lQNgjKLLefq9CYb/3uf8SXpPVqfgNxtAE
         kN3gOZL5l71kbI5YTRAbyrikkps0xo/KqHIgH02wRcHcr89pJfaq+y+E6aYFPv/2iZEl
         6TJQ==
X-Gm-Message-State: APjAAAWDTlsij5HfgS+WCLQdsLKGBi0rixevZ8Nlit7iTvnvnQOIH65y
        bp8qMujt5Q2hk/Dx5UgClb132gDaCckvaaMCNXMK2c4dmd1V1YqhhRgqCzwkLU2aB1VquyDp9V3
        akUnxtxKOwxTgFJOZyciZP+pB
X-Received: by 2002:adf:b60b:: with SMTP id f11mr6182428wre.95.1570098781062;
        Thu, 03 Oct 2019 03:33:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzR73rVAuncaKpVwzdd3+MqciGKk4WU0zynSuyLk788ukn8unkJ2AA2IjoXx3nNxwOcOHxGyw==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr6182413wre.95.1570098780819;
        Thu, 03 Oct 2019 03:33:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464? ([2001:b07:6468:f312:b903:6d6f:a447:e464])
        by smtp.gmail.com with ESMTPSA id w18sm2323706wmc.9.2019.10.03.03.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 03:33:00 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Fix consistency check on injected exception
 error code
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20191001162123.26992-1-sean.j.christopherson@intel.com>
 <CALMp9eT+kkdrDhHW4QHaSHQOeXnpcE2Quhd=kOhZq_y6ydjdJA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <78c156df-3fd5-1eeb-c34e-d0a3afa99970@redhat.com>
Date:   Thu, 3 Oct 2019 12:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eT+kkdrDhHW4QHaSHQOeXnpcE2Quhd=kOhZq_y6ydjdJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/19 18:28, Jim Mattson wrote:
> Reviewed-by: Jim Mattson <jmattson@google.com>

Queued, thanks.

Paolo
