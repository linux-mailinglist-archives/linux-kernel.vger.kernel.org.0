Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8535FD0D30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfJIKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 06:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIKw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:52:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E904683F40
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:52:27 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id p6so360529wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P0MsNQfXnUWl/0sGblTAdgyCu1Yy72Z6SXuCSt57gtc=;
        b=O39ZaQm13zailWI2+O3hY7mGT1jkCHEWn+G93Khtj2nwPysug4Kgb02JRF1Fx0mq0X
         0ImFnoQ4hxCxRW7YgpNpP9xNW2BBa4ILl1byyj6Xt8C68D0q/yW9z0eA/Z1AwHBUX+pO
         oJU/pRzxwWfbTPRE/95MZaTRLGcV2XivQ+g/QJVYHmLoIZWpM1qFeWTsgZCyvg5fQ0Ss
         WsX9dRf5818AgtSpiBflzAYwEw5wwqqcNAFajyUSWHh2NXRNeKDzB9jGXup09mB7J1vA
         +E07qc0vX5bD5Pg6puR5SoeqFqKeNIyAaPdhb0dTmo0zDDhkgdfOqLDTk0e7zlIQtGTa
         P6ng==
X-Gm-Message-State: APjAAAWpH3BQLSfPpxAAlH48lKIPYvuK2ovaQn6aNyOPTutqKtLLTfw6
        ACGzGOa4SY6ai1nmBLRaVYxwpOH0IY0U/Ca5B04FSqmZPNaiWbg4HqxH182O0PYufaDVGgpKW59
        MsFuGPo47Zy6ya5e7c1DzpK69
X-Received: by 2002:adf:fa86:: with SMTP id h6mr2319362wrr.186.1570618346575;
        Wed, 09 Oct 2019 03:52:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmJzk1u2HM8iYqz2RgPoWZLZRsaTlP8C1e8mq6Mn5bVWWmvWx4BsMaX0BzdRLhQT3V0cWn6w==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr2319339wrr.186.1570618346361;
        Wed, 09 Oct 2019 03:52:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527? ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
        by smtp.gmail.com with ESMTPSA id y14sm2575792wrd.84.2019.10.09.03.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:52:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] KVM: x86: Fold 'enum kvm_ex_reg' definitions into
 'enum kvm_reg'
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-7-sean.j.christopherson@intel.com>
 <87ftke3zll.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <57cae37d-acd0-074c-26cd-aaf7a7989905@redhat.com>
Date:   Wed, 9 Oct 2019 12:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ftke3zll.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/19 11:25, Vitaly Kuznetsov wrote:
>> -enum kvm_reg_ex {
>>  	VCPU_EXREG_PDPTR = NR_VCPU_REGS,
> (Personally, I would've changed that to NR_VCPU_REGS + 1)
> 

Why?

Paolo
