Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEBE2224
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJWRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 13:55:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45090 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfJWRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:55:19 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so25977226iot.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pO/myx3J7kHrLEpa25DVGDw09CZzis8oLjoyxuQ8iXY=;
        b=rH/zv2bBzv28ImycCzKpsHuu8Ps9K+MRaSqhv0eBaQ/3iLs+cMzAR2Q7J8IIdjzbS1
         xjEGpt52mQB+IbeLuyfJXacyyEaoZstWgGpMs/+Xvu2AN8D7AabjnsUbQlzJkATlMW72
         6soo95F/DsR834TJQNiOLnP5A7F4D4FRtxhPvArLgUJ2hDyUUZSN9tTbPTDVFyjRHsx+
         bUvmWlRJ/N691cAYkhE1QT2k8JPuipH4eXsJSWe6YBK58bpKBN1K2PuR+cDyjk1KLga7
         sRfO8dzKDnYpEPd9X6q7qI/3SnZew/6K0OEa17iP+DntLfijtTTQ6JWyZoMmmhAWptht
         CsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO/myx3J7kHrLEpa25DVGDw09CZzis8oLjoyxuQ8iXY=;
        b=ebi52PnmlNvZKuAU6ZqrQepyJfLTM68dmF+hqcEZW3o3DQTyGwjCQY34usVQFDVT7f
         XueU3aht+Igqa6sq0smdFIkHPpum1mBZqfVRU64zNjPlp6Lsrgay0dfo2mBy3YCprVje
         obxXJ/YU1WJeElhL3tqVISz9vtFT6b0LjMnGzCaan4xwuTnyC8Wr+QsLqjpZxZP9mbo4
         rMeAum1z9xq9fdfiN/b4+kzGKyJV7bAqZdqhIgKlOqmWpl9Omt7NPRp5NkKyQloreFtw
         xeiY7NaToJrliKzizpTEkByBxJ0m87BAeD53yanjEAwbgAjjCWBdY7W1TfDa/aPMrgGa
         +Ggw==
X-Gm-Message-State: APjAAAVH4SXSG8MQR9OQI/3XDMjc/l2BUjEQ0RVXnKXLjhEuGSbprjE6
        QhwcuCFx+ESwOuANYSsIXWCkgWhEtQUDL5YmWRkHEg==
X-Google-Smtp-Source: APXvYqxsl67QSPoS4uT6rbqaV0JLYE88xU9s8zWf37x/DLlTqLfH704EHVMUPvK17HziO1K2RFkFUCoxfPD70rfTzlE=
X-Received: by 2002:a5d:8146:: with SMTP id f6mr4908064ioo.108.1571853317840;
 Wed, 23 Oct 2019 10:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191021160651.49508-1-like.xu@linux.intel.com> <20191021160651.49508-4-like.xu@linux.intel.com>
In-Reply-To: <20191021160651.49508-4-like.xu@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Oct 2019 10:55:06 -0700
Message-ID: <CALMp9eRyyKy=U_90mxZw=QaEPujLw+KKbXyozH2FUb-GdP7-Qg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] KVM: x86/vPMU: Rename pmu_ops callbacks from
 msr_idx to rdpmc_idx
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, like.xu@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Kan Liang <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 1:12 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> The leagcy pmu_ops->msr_idx_to_pmc is only called in kvm_pmu_rdpmc, so
> this name is restrictedly limited to rdpmc_idx which could be indexed
> exactly to a kvm_pmc. Let's restrict its semantic by renaming the
> existing msr_idx_to_pmc to rdpmc_idx_to_pmc, and is_valid_msr_idx to
> is_valid_rdpmc_idx (likewise for kvm_pmu_is_valid_msr_idx).
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
Nit: The ECX argument to RDPMC is more than just an index (in fact,
intel_is_valid_msr_idx() extracts the index from the provided ECX
value), so I'd suggest s/rdpmc_idx/rdpmc_ecx/g.

Reviewed-by: Jim Mattson <jmattson@google.com>
