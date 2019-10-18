Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C395DDBD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437712AbfJRFkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:40:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390139AbfJRFky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:40:54 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so6040213ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6vl776tt39Djj97+yEKzgcDA8S7SdrfVeVZOrfDrtPA=;
        b=dU09HL7YiUwk/maqwxoin70k8Ds5wcr8FCr03pp80PJHAKOp3OReif4boc/KD+b2DM
         J85QCudqpCs1TCoMc9wVPTRMRU0STpgD/1QlgpUBNod7Cl0dHQT0+cS+GqwwKn1pTQoh
         qDbr/RW6USHBn1Lwi3PUSRcsIdwJasq0mwWOSN/6upWfMh7UN21nQLP+JZJjujE1EJbf
         sUB+YacJewIY1v4hglgcqfHidAp7zxIlzY5AWW/L7aOkuYBKghGCKY1Qjy7HoZc4IpvO
         ig+ikN0mJIZGCo3VIdRDOweYsfcUzSaai36eoZbFKR8i5RlAmAWDLaVCq5E1yt0FO8qa
         Fflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6vl776tt39Djj97+yEKzgcDA8S7SdrfVeVZOrfDrtPA=;
        b=dnubxiheSzONLV82UUHHMj6D7miSETaQ6himjn8oIqIFw6//qbeEKDfCeK3IiIBowe
         hV2APeG4UTeytf9YJ8qvjYKXf71OkvFBtbKNyEyF7yzqGKqQ2Fl/A2PDDjOATewREwqG
         JwWwpEiWnXDAlqXHt7hr6m8hisXUVdVUftECUf4ZYAwVaRypPDThucEgyfUh+uaxKEfr
         5tmq/2Y8eV0ep0eeJ9lRnnlVhSCpJkpV1Szd7yGJrMaY8QOE/vE2UiUv16Jp9omIuKET
         jEVPcgWrYot2W9FexxZdhaCjc+tDgNPT4uC7bL3lgPYy/dlUSfeILBQ3kWKFMszl/P5a
         80WQ==
X-Gm-Message-State: APjAAAXGlgzZFD61zAD+oov84r+Xk6bZtcingPRfJqduAIpMyldzqML4
        kxQxRftx5jfPRRrevpi4XRsem8HvNCw=
X-Google-Smtp-Source: APXvYqzmzVECICRUhTk0jHEyAsknDFm8SCMbAaOwaHumsoit6u726yoCOL3R0yOSUQ676wBRE6GLoQ==
X-Received: by 2002:a05:6602:1c4:: with SMTP id w4mr6000255iot.153.1571367487601;
        Thu, 17 Oct 2019 19:58:07 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id o66sm2100434ili.45.2019.10.17.19.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 19:58:06 -0700 (PDT)
Date:   Thu, 17 Oct 2019 19:58:04 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Nick Hu <nickhu@andestech.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
cc:     alankao@andestech.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        glider@google.com, dvyukov@google.com, corbet@lwn.net,
        alexios.zavras@intel.com, allison@lohutok.net, Anup.Patel@wdc.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        atish.patra@wdc.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] kasan: Archs don't check memmove if not support
 it.
In-Reply-To: <ba456776-a77f-5306-60ef-c19a4a8b3119@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.9999.1910171957310.3156@viisi.sifive.com>
References: <cover.1570514544.git.nickhu@andestech.com> <c9fa9eb25a5c0b1f733494dfd439f056c6e938fd.1570514544.git.nickhu@andestech.com> <ba456776-a77f-5306-60ef-c19a4a8b3119@virtuozzo.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Andrey Ryabinin wrote:

> On 10/8/19 9:11 AM, Nick Hu wrote:
> > Skip the memmove checking for those archs who don't support it.
>  
> The patch is fine but the changelog sounds misleading. We don't skip memmove checking.
> If arch don't have memmove than the C implementation from lib/string.c used.
> It's instrumented by compiler so it's checked and we simply don't need that KASAN's memmove with
> manual checks.

Thanks Andrey.  Nick, could you please update the patch description?

- Paul

