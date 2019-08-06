Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4754582B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfHFGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 02:20:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbfHFGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:20:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so86646980wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMztFRMwS894XHsmEs01R20QPKJnerKfJ/mqwGoosCA=;
        b=bbKpmTFtZ7dTRaAtPDiBBD7DbS2M4Ai1xgAtNDbEsrWbuG9oNvgvI70Zt3t6GahAyF
         Y4YEKwlTXOPGnZr8+Z1ZIgdrmDV2/TFAOTX0d4hOXZcsmyOJrnd5Hkr+RzGAH/WJgyrr
         RDh2orxYSt5kJl/dsFBUedSX8ZZOAmB4KuvqsBuj5vrIg6p5bIu1p04dUFdJxoTm/aDl
         eHcAHuWtFdtdQUXubtSpy4SlFsck03ETXF4ATc3a54J7ZmXCnzax1K9EteetJ2tWEYbw
         Rrcb6bao/dqDdWsM5S12swWrha2W6bGQ2+DVaN9y61+YgzJyR8Jq8rbnraWJlePvhtHF
         lv5Q==
X-Gm-Message-State: APjAAAWvFknsnLYcLgaOXEF/JtENfizEFlo4EDYx7okJsaj1xruXDHEG
        FXMYwXx4xd3dlGEcvkOfmjCnxQ==
X-Google-Smtp-Source: APXvYqylbgUdbdCCip+TqSzuS3nN/TZgFkjI643QFSasgjW2I/qMUGjPcLCRAwvxZhdJxcEgwJic+A==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr2276210wrs.289.1565072456384;
        Mon, 05 Aug 2019 23:20:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810? ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
        by smtp.gmail.com with ESMTPSA id t63sm84881683wmt.6.2019.08.05.23.20.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 23:20:55 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] KVM: Fix leak vCPU's VMCS value into other pCPU
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
References: <1564970604-10044-1-git-send-email-wanpengli@tencent.com>
 <9acbc733-442f-0f65-9b56-ff800a3fa0f5@redhat.com>
 <CANRm+CwH54S555nw-Zik-3NFDH9yqe+SOZrGc3mPoAU_qGxP-A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e7b84893-42bf-e80e-61c9-ef5d1b200064@redhat.com>
Date:   Tue, 6 Aug 2019 08:20:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwH54S555nw-Zik-3NFDH9yqe+SOZrGc3mPoAU_qGxP-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/19 02:35, Wanpeng Li wrote:
> Thank you, Paolo! Btw, how about other 5 patches?

Queued everything else too.

Paolo

> Regards,
> Wanpeng Li

