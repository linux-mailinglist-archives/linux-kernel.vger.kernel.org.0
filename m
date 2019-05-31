Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38831060
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfEaOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 10:38:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35262 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:38:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so1141912qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=649G8fX5KsyxKNGqC8JgOTPtl/EUKZLecJRl6sV4WuE=;
        b=gcp92TBDfc0rnUPM9YcSJPS63vLFPmXlbELISOregSWXFow0wkuMKoNUTCwWuPETjn
         58EjhTjW0OS5FGcgpplBpmIsKAOKOj5yz/RM0/7byNNAcT83+i2IcZsyAxLeRThi8iBD
         u/ot7JwaMWPkMOswd8p5V6fcx1AJBQj6oUxJAE5RR0Tljh4eGxulZ9VkS0R88KQxf1yf
         JMUjXaFl5Rle0cxtVYfNp08eqHZW6Gw8Z9WvlWbFaiyaCQ2i9xdlsZ6WM3u1pkc46Jyz
         Nx3amfFonmYF8TqE1rNIL3DAei2V1sqrXokli290xrfi41tdLCckSjNVEAmNr1IvZiIA
         BZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=649G8fX5KsyxKNGqC8JgOTPtl/EUKZLecJRl6sV4WuE=;
        b=B5Zg1xaCTnP1sy1AbaGaORjdKPxEJvMPf6Kd6n6crAckyxJdE2Qy/RSUVelvoVsdbb
         erenSVT90yRzypjgEMhPOuo20lBhU8Ea4gf/CxDItdtsWRJWO1qAMesKgmY9wiLiuuR8
         2IrYT5RmzWBNXPkKKAd6/p/aDFE4MZPl3bu3cV6dZEMFG0DFnnNBiLVwr0l3pEq+zUYE
         PJ+6H/1OtSQOMVCZNINcx/G9utlIL6CQOM0f2d+Xnxk9sLCC6BRFM7uh1GI+z+Z/PFjJ
         /WT9NpcTHMrvxgzBHcFoEf6/3SXshwmqCfVMZn+TVAVfzWV2/LFD3duXu7nTC1W49xie
         D6bw==
X-Gm-Message-State: APjAAAUkqseMAk5GBhfOGoUAaCQQFJawBeP8YUtop0V3m9va/b8y7USV
        pa4Elr7ivwkXcekArvnqFHo=
X-Google-Smtp-Source: APXvYqygj+noRfQ7ZarPTbIglLApJBmc4ARIM2HfmB8bcs4XGAPQh8P9oPNnFyjrBYBZ687Y1rT0Pw==
X-Received: by 2002:a0c:878e:: with SMTP id 14mr9262652qvj.103.1559313481179;
        Fri, 31 May 2019 07:38:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39c9])
        by smtp.gmail.com with ESMTPSA id v195sm3201216qka.28.2019.05.31.07.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:38:00 -0700 (PDT)
Date:   Fri, 31 May 2019 07:37:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/core: add __sched tag for io_schedule()
Message-ID: <20190531143759.GD374014@devbig004.ftw2.facebook.com>
References: <20190531082912.80724-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531082912.80724-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 04:29:12PM +0800, Gao Xiang wrote:
> non-inline io_schedule() was introduced in
> commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
> Keep in line with io_schedule_timeout, Otherwise
> "/proc/<pid>/wchan" will report io_schedule()
> rather than its callers when waiting io.
> 
> Reported-by: Jilong Kou <koujilong@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
