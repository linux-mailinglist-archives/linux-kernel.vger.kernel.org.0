Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7201A65638
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfGKL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 07:58:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfGKL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:58:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so5978020wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 04:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LhDp88Y3fWDqOYh1pThyRovlQ3TYPl2m85EbCDxmY+o=;
        b=n13M7+KGpJ8TFqztWHCBr7PNUDWRs2iuP0xdq8p7wFC4iuVNuZcGK4Nw0TdknmCS1D
         zO0sC2JmCC/LJ8gB+4IrCUtk+QCRepZHsBH8gz7MFUj2LqvmanXNl8nm5f54Pfu0Ru7I
         SsQmnhby6ky94sKDk2EkeSG5xsV18ZU2eMx52XeCEjn4W7Z7DPoOcU3/Gf+Wp6JmpvYE
         L7Qfgqip2jC7ZseeunKLmPKfqvNbncl7PNocDrBVSWJbK6GkTX8E74wl8ezRqPGB1Rw3
         4P+aiKBBDxMdqmSWzMD/5URH88Bcxd977PCXTdscbaGlnGxxAuMcbUIkH3+5dBz62Vuf
         RKiw==
X-Gm-Message-State: APjAAAWKTSeyNZ2DeAK7nWH+Lpxy1jE7CAqo2M0aFSPetnS6QA2dolmX
        gG4RobeAP9PDPwO2RHUcFtcdZA==
X-Google-Smtp-Source: APXvYqyZ+EaNkMvzB6qQoxYUOT/tewHWhtGXmANS3yH+XaXHzBlRGqpv7h4YWkTd2dsNSPebLIHxzA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr445302wrm.55.1562846285847;
        Thu, 11 Jul 2019 04:58:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id g10sm4549780wrw.60.2019.07.11.04.58.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 04:58:05 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Eric Hankland <ehankland@google.com>,
        Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21fd772c-2267-2122-c878-f80185d8ca86@redhat.com>
Date:   Thu, 11 Jul 2019 13:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 03:25, Eric Hankland wrote:
> - Add a VM ioctl that can control which events the guest can monitor.

... and finally:

- the patch whitespace is damaged

- the filter is leaked when the VM is destroyed

- kmalloc(GFP_KERNEL_ACCOUNT) is preferrable to vmalloc because it
accounts memory to the VM correctly.

Since this is your first submission, I have fixed up everything.

Paolo
