Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E91CF12A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfJHDSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 23:18:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43404 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbfJHDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:18:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so2145011pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sBhKqNlCBDPkftr27P/1IjQptr0YXTqXNyc4wrCVHCs=;
        b=KwXd9fN7sM6S4HqcH6F8Fq+m+XYPerHKPiNSvQR2F1QiQtVIQE+nIlWn6Q8PpHhho3
         iKAX+N6dedzbUCk0rOTijgDmFBbGQtrLv6csEuCeXIQjzImHbAUoIN37aOc5gpctJxOF
         5Yb3hQt9N8P0fH/XEiIrrHtWqRrpULXdYkgYDxM/+CbOlnP5yhRkxO94ecv+W1Wr0Nm1
         YO7fIF7mJQ265INnz8hwnN3iqExG1g6CoqkHHHDDpjbhSQqpUSnIyQcF05FOL71TosBQ
         prc/hZax9kJYb46OUODcifTFk/n2fFG+Isyhs4q2PZUng5eh+rzPDInIdxsDVxA18Ohu
         T7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBhKqNlCBDPkftr27P/1IjQptr0YXTqXNyc4wrCVHCs=;
        b=h8X5auHWRqCOrlYd1LEEBc/FfR+3njZ1+b9KCX+QbC2e49kMm1/NRsqJ3Qj2iP40wi
         IerBrfNr33ColICGCuLCxIEmTDefS69ycfyLjbjh+FyHAxKaS0D3gUiJn0H9AlCB5vJk
         CSOouAsbEdPhe+OqTQkLf5+hLDP2vp1hYVrfkW+K8v/A1mRIOTns1qBk0ipJrpMjxFS6
         L4t4aDtOS0ZUlndSqMTsfwA+c/xlBD9b7pRxJUgmAPshTLP9X+z+ABWvD1fij5VnDFII
         8YeUJQ7lbhKjzqC5pe/xiAooWNemEq71W3oPKVLt4GcJSUaeQhh8pi/qf4YzaEFwzZMN
         Hptw==
X-Gm-Message-State: APjAAAXfLDKVvOc2jxf/zjywy1yQecWp7NePRaEMtyX1lWBkKmQGqfqf
        4yO0ALPPGGwQSMkXy7uAptBTxpqlMbZ2lg==
X-Google-Smtp-Source: APXvYqyVEEx/94ZCOojqFRMZtKBTarDNA2EnBJ0TsDkKhroTKOhYv0wamthRODhio5AJVBqSSnilAg==
X-Received: by 2002:a63:dc4c:: with SMTP id f12mr1766256pgj.29.1570504677476;
        Mon, 07 Oct 2019 20:17:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 64sm19333739pfx.31.2019.10.07.20.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 20:17:56 -0700 (PDT)
Subject: Re: [PATCH] blk-stat: Optimise blk_stat_add()
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <39dd33cc6f0264b2ec2f79f1dfe21466c2180851.1570482929.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5df36bc-1beb-403c-8fe6-624fecc938a2@kernel.dk>
Date:   Mon, 7 Oct 2019 21:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39dd33cc6f0264b2ec2f79f1dfe21466c2180851.1570482929.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 3:16 PM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> blk_stat_add() calls {get,put}_cpu_ptr() in a loop, which entails
> overhead of disabling/enabling preemption. The loop is under RCU
> (i.e.short) anyway, so do get_cpu() in advance.

Looks good, applied for 5.5.

-- 
Jens Axboe

