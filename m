Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F69EC15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfH0PKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 11:10:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44078 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0PKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:10:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so12851346pgl.11;
        Tue, 27 Aug 2019 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLt4u7UGczeUqSMgyy+K1XoXpeQZCnRb2YnoO+BMfIo=;
        b=niRAbPOQI3zUkKnrNsbfzvsmHy7pHWg70NpUY3xDLh9thcNjn9OlluiMgP+qkNnei7
         HmJvc4m42HmwxRM18odZ6vNQyPnJfRiwO0DCEfFAWBaA0Cf7NXxsQteFWNdTSUpZ97jh
         fTajeuDxJ94G9dyzwIB6JtPuCmek5cS4SyUMSeivtMh/Pgrk0NLu8X6oEIksYuP/hZBQ
         zrKCzydnoQocaIinNx9MeM5uvp/PSfNH0Mhd0LxaQBHCgC5R9h7zl2lWX7sl6QQwcGWV
         GcUNgxk+3Bgu+aUuGtUaJWfkMCeqCm3ITU3Mn+MwVvW7qb7OlC1pNxynWbq35Mm5eKWs
         boWQ==
X-Gm-Message-State: APjAAAXu6RY7ShmHuWuyZW6CJFe/awnsBtDX5+TGx1/WDWk856Ry7LMU
        djWuRUzBXfQ3BcVsxkm65ok=
X-Google-Smtp-Source: APXvYqyRLYTthx4jSSdw9WJK4sOVCArZyAET+t7jAdAauE0E/bhuVVphUQWChzR4Qx0djZAgygaw/w==
X-Received: by 2002:a17:90a:3b4f:: with SMTP id t15mr26738525pjf.45.1566918645076;
        Tue, 27 Aug 2019 08:10:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j11sm3174223pjb.11.2019.08.27.08.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:10:44 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme: pci: pass IRQF_RESCURE_THREAD to
 request_threaded_irq
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Long Li <longli@microsoft.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20190827085344.30799-1-ming.lei@redhat.com>
 <20190827085344.30799-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7cdb9dbb-46e5-b66a-ddf1-c7ecceb28d7a@acm.org>
Date:   Tue, 27 Aug 2019 08:10:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827085344.30799-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 1:53 AM, Ming Lei wrote:
> If one vector is spread on several CPUs, usually the interrupt is only
> handled on one of these CPUs.

Is that perhaps a limitation of x86 interrupt handling hardware? See 
also the description of physical and logical destination mode of the 
local APIC in the Intel documentation.

Does that limitation also apply to other platforms than x86?

Thanks,

Bart.
