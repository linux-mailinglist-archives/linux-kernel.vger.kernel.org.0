Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CFDBFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505014AbfJRITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:19:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37363 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504974AbfJRITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:19:15 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so6435020iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WGR6gGKdLj4dEHPdPs5AUTsaDTf+joh7rvJz3pg5W+4=;
        b=cGRxWKOUdtE+FVh54xi6iHtA03A0lsX1/a1mfMXI71ZJu3crqcwAEl+lxizFIQ/WyV
         3M3aS9b7XFvaeP7OJai6HFJgaHH2BEnrrhMIgaPzaGOz7mOrZcaBhzzMV2TD/+AaRT63
         l3vhP08aEM6/ryy4qAIMUULW6zepIWYQQLC1M+8Jvd2eY9B+F4Wku2M3Ha5IgvtrSccz
         /57HDfY1IcWKFwBDnejKi2v7SwdgIA5q12t7bGAddScWIKrb0SprmDBlKK3bM+T6P5UY
         VBbftGdQ3PLnPHxdKbAbma29Xsqn2wmQ5zGR+qJqwdoyrZPZrTNHXM02hj3Y0hcuyU9k
         k0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WGR6gGKdLj4dEHPdPs5AUTsaDTf+joh7rvJz3pg5W+4=;
        b=HP0+t7EiwUz9gaGbpYXxF/WGhsI4D3YVXBEjddres5VTsQ1Vwc0FVX28RHas/PU4UV
         yl2GYWbZFGXbcIOev+nKOUPU7CnhRhwk0PPVIGODDynvyjCngw9rG1Kmy4zzGx61Nukk
         vfsfZwHUKf2O9j5TtQQS8WQHteR939ak0DVxXS2Co5e/bSapjEVDMX4aHFppH9FCMasw
         5mu+JlUKEgJmAg7uQPP8eYqW17bT/iOo/4nmmuokA/w0R2Mv3lTsPxXFNY0zg7HwwtLz
         DD1Nc94m9y0bHnpO3KWp7fmk51b+gsp08O/7di5hpTpONGhKSX8tt0ts3jicM4MDs3pn
         kTTg==
X-Gm-Message-State: APjAAAUkLN218jo5ELA/K423/pUH1Hr73nRLen3z964wBxfx6CNwEJL/
        YazEKDU9gv/Fv46+ey2HQ8CM2KT3eEI=
X-Google-Smtp-Source: APXvYqzg2amXejQW+i9jcNd9zVISmlG81QkF/azJj7dk0YWCV0ZFMBFXJ14tIw4FPNHDbSJoeiYrXA==
X-Received: by 2002:a6b:fb12:: with SMTP id h18mr7431244iog.103.1571386754534;
        Fri, 18 Oct 2019 01:19:14 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id 2sm2217679ilw.50.2019.10.18.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:19:13 -0700 (PDT)
Date:   Fri, 18 Oct 2019 01:19:12 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2  1/2] RISC-V: Remove unsupported isa string info
 print
In-Reply-To: <20191009220058.24964-2-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910180118510.21875@viisi.sifive.com>
References: <20191009220058.24964-1-atish.patra@wdc.com> <20191009220058.24964-2-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019, Atish Patra wrote:

> /proc/cpuinfo should just print all the isa string as an information
> instead of determining what is supported or not. ELF hwcap can be
> used by the userspace to figure out that.
> 
> Simplify the isa string printing by removing the unsupported isa string
> print and all related code.
> 
> The relevant discussion can be found at
> http://lists.infradead.org/pipermail/linux-riscv/2019-September/006702.html
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.5-rc1.


- Paul
