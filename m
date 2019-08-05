Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87E4818A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfHEMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 08:01:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHEMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:01:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so34243509wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2nagADd5jn/PM+jdv3CsfqiPWcm300QiQQSn7jI3dpY=;
        b=S3a7S4jb79fQNyXjFY1vCMLLjibDjksG5NTGtdYlFy8uA+44Wza+f3hcAlwS6HyI0k
         jDoMfo1VGsJ+i1y7QiE7Rv7pFngNrxhlcNlbfTggOHfQWDKWGraxAJYm7PsJv284TOu5
         nVqZ6d3ZWALkamVYl5TJvE/UVnu4ulXogf8HVX0aCRal4zmUgp7CZU5cxut33T0uhv6K
         7v6CffM4X/pqH3JkzFssYMjMfCQFoFInOL2pIn5ADC8rDpBM2P0Z9dRhX//MqwwWd9B7
         degclYLM4zQIrfn8hqZxaesCuWjCh68zD0KK8zKbjp4vCROwqImnjevxRCSWywxYgl2/
         KAgw==
X-Gm-Message-State: APjAAAX0/enFaA0gVHahYsf1gLZEuklRnTMJy7AA12u+MPR0KV48US5m
        mDMYh43Jjs91ySEdF/+u1MBqqKPWCJM=
X-Google-Smtp-Source: APXvYqxE67uGRsevI1zEKu6WcCvy7LGAqb+5YSaaPfzVS62blyzVnMo0SSHLm4YD1CuRcd1v857erg==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr42706085wru.310.1565006509205;
        Mon, 05 Aug 2019 05:01:49 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id c1sm192489759wrh.1.2019.08.05.05.01.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:01:48 -0700 (PDT)
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
To:     Anup Patel <anup@brainfault.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190802074620.115029-1-anup.patel@wdc.com>
 <20190802074620.115029-8-anup.patel@wdc.com>
 <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com>
 <CAAhSdy2PDSpTy1JEEC2LCB4ESvZHBbkVEZ2wqz-D2b7SKD5VSg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <09417197-36e8-718f-f106-29466ef406e3@redhat.com>
Date:   Mon, 5 Aug 2019 14:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2PDSpTy1JEEC2LCB4ESvZHBbkVEZ2wqz-D2b7SKD5VSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 13:56, Anup Patel wrote:
> We will certainly explore sync_regs interface. Reducing exits to user-space
> will definitely help.

sync_regs does not reduce exits to userspace, it reduces ioctls from
userspace but there is a real benefit only if userspace actually makes
many syscalls for each vmexit.

Paolo
