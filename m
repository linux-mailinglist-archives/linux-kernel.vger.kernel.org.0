Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF21507E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 15:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBCOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 09:02:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42387 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBCOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:02:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so2113064pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5+nfCho9zYZEqsV3OpYlG574SchBNWWNZI1rOz3wd4=;
        b=hV44iUaCu7cEtK9xsLbLB2Cy6zHap6Yt8rZPnYvoH/2bfa2bm1TRIA4xgu4lH4ZrxQ
         eN1mV42bvupWusbanK5e1tCRKCiIx30Np6jx7MjR6N+dRYi8ihROf5G0qyAxseJUKkO3
         59wsHJfHDfZCuREIzei4FnCmYzuPjuzcLkpg2MDeWd2EVVHDTpaubsM4U6oxxTBRVQrk
         AejUa9b9I/tQzk67aJIvUbH2XdzXGLfR+q4Z0g2LzR7rAQHF6oq2z/omvizrMNmhxjFr
         z1KRegZb8U1CDwQapRMF1UKSS2wLPpfH4JS+kgxFgCF3L7n6gv+KWpUwzl4/ajNDWfZn
         ZKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5+nfCho9zYZEqsV3OpYlG574SchBNWWNZI1rOz3wd4=;
        b=mnhjCTXBE9T1N5mKVHjapMrMeSbQzhT8Gjuh4AG4REHaGORTrBDz8Z6TFBonsyh72b
         5PYvCKsJwELYnq9ia+OR9t1uBi7BXHiXijH92QmOHdq15XFRAk9h22xjHWDSsLgYE8vq
         roJgVZyq1s6XpR4t0osz+qBZBnabZk7hSiJ6tpn+YKswPYOtUihS/YtKcl99U2OwuDtF
         CLSUSFctCAfarqxfUAIA5ASiTfkJYRFaYwSt7FCuBBa5V1EmHxSSMRTWxVSMgxAAQxoF
         B0S7WxbmP2uumBxZTrYollJrv5Lbu07pDgKR98JiPhx/4PpHH+1AOF5BffN1wdgLRbpP
         Zsrg==
X-Gm-Message-State: APjAAAVGgADHY9Y2eFrUjxXQ/3zPeidbpJk2ZemQRyB76vaHM+UTCbhl
        z9kuT+FvveC2xcCHM8FGM6bcYQ==
X-Google-Smtp-Source: APXvYqyV0/fiioJr3fMwalxfwNVtkTVpX9/0/CYpknqlLA3twkanpEzWyU9yEiPbTyEmMBKj89kPyQ==
X-Received: by 2002:a63:484b:: with SMTP id x11mr25745966pgk.148.1580738573099;
        Mon, 03 Feb 2020 06:02:53 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z29sm20319400pgc.21.2020.02.03.06.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 06:02:52 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 0/7] block, bfq: series of fixes, and not only,
 for some recently reported issues
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com
References: <20200203104100.16965-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f73edf7b-3b69-8f9e-a881-758582019421@kernel.dk>
Date:   Mon, 3 Feb 2020 07:02:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/20 3:40 AM, Paolo Valente wrote:
> Hi Jens,
> this the V2 of the series. The only change is the removal of ifdefs
> from around gets and puts of bfq groups. As I wrote in my previous
> cover letter, these patches are mostly fixes for the issues reported
> in [1, 2]. All patches have been publicly tested in the dev version of
> BFQ.

I'll apply this one, at least the ifdef cleanup is nice and patch
6/7 no longer makes your eyes burn!

-- 
Jens Axboe

