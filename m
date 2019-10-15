Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940D9D7C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJOQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 12:39:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35395 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727579AbfJOQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571157574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=ojp02z/yPeUqI0YPPrqnloEvXX8pMYJM8GdkxYvWth0=;
        b=JiBoFcgU3vK36RnkawQvLKPgM2PiIW04nPfHByYuxUxuuAi1tfOyUpUifRWmr5k1kw9JbW
        w2vRq2T0T792odlSf4FxlZLhbhfq9vDgzcRN9qcqHQhBu2HosdDlKPrkdtlCPh6UV9dZBz
        crXst+PhbIdWyLzTLHFuccnIrpp4Lxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-IfxNH-Z8MDyb6IAPqkPSLQ-1; Tue, 15 Oct 2019 12:39:29 -0400
Received: by mail-wm1-f71.google.com with SMTP id l3so8898203wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8Yzcui6UO5aokPFK9KbVMAamgpXNzxTPApyteJcIxI=;
        b=VND6ntnFsM2KTGPCvHjG9agX+VgmkuiRyOy+5MFH74R0q395vG16VwQ0BUCAmGu2oS
         Cw32fxKQ4NNBKKkbH+SHEjdnINED2FZu4nqBaFzvRIW8X6aRS7DO/p/RpMT+zGFWhAhz
         PALoaxNjyfinb0lTp1WfwrspCibzGrJuUexVr+WmeVKz5FesDEXRTE3up2P6hhcQVyjs
         EwP3mu0KYUxGX0fNoXobeAQ5HqJa8wrDhXnkCP18SW/szVskWXm1rnygyZ9Lmla3dzcC
         8ET+p9fdYRrVG8bncw2Yvwdj1RHCbTeQXL/A6qQMLUqRwQRg97yvM2r37e9ayo2qlpuv
         KI/A==
X-Gm-Message-State: APjAAAXgl71IfYq+ulBk46K8ZpKiuYCSVXekP1kyqORZCP2UHII2t+Bh
        ZYH87rh82pdIrdLQQsH/MFlMQqk+5R3kvrkadYoI4NsEvLtSAuSPaufnnB3+EHUUq2dGfLu3cDT
        Cgl1mgiOMSHdLJsHyuq7IpvH9
X-Received: by 2002:adf:e747:: with SMTP id c7mr935235wrn.384.1571157568341;
        Tue, 15 Oct 2019 09:39:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyejSMH01cdqlKyvOUSnepj7nqszueGVbjXDXwAp7a2kqRNxQBtic0nSge519tsU28CGqWN0A==
X-Received: by 2002:adf:e747:: with SMTP id c7mr935204wrn.384.1571157568078;
        Tue, 15 Oct 2019 09:39:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id h7sm20388863wrs.15.2019.10.15.09.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:39:27 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
To:     Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
        yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        nd@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-6-jianyong.wu@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <da62c327-9402-9a5c-d694-c1a4378822e0@redhat.com>
Date:   Tue, 15 Oct 2019 18:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104822.13890-6-jianyong.wu@arm.com>
Content-Language: en-US
X-MC-Unique: IfxNH-Z8MDyb6IAPqkPSLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 12:48, Jianyong Wu wrote:
> +int kvm_arch_ptp_get_clock_generic(struct timespec64 *ts,
> +=09=09=09=09   struct arm_smccc_res *hvc_res)
> +{
> +=09u64 ns;
> +=09ktime_t ktime_overall;
> +
> +=09arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
> +=09=09=09=09  hvc_res);
> +=09if ((long)(hvc_res->a0) < 0)
> +=09=09return -EOPNOTSUPP;
> +
> +=09ktime_overall =3D hvc_res->a0 << 32 | hvc_res->a1;
> +=09*ts =3D ktime_to_timespec64(ktime_overall);
> +
> +=09return 0;
> +}
> +

This seems wrong, who uses kvm_arch_ptp_get_clock_fn?

Paolo

