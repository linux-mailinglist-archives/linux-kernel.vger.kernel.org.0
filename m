Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052B295990
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfHTI3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 04:29:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54938 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfHTI3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:29:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1813755wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VTSW2R99Gpp3ZPuegti+Wid5K/Ptbn+GS7fhEV9UB7Y=;
        b=cqzZrIti0K7HA+zzORNM1a5F39EziABl3E0hTYPlPqI3ybHQpJaCNrNBOTdVnl2vMu
         MX8DAAES0sDR74dKpZ27uihKiKzuJ4sNU8pNRLO8rvgcJSwwrThZvOUCE6xCFan1D+Es
         McQTtGKFtuyhkLxfoebyo2k1yKJHI9/PJva5Bv4Sxj18fZ1GWcRrpfy4i9haC++P0uSR
         1KBorCQcQWyk6ypOVGf+IKBRSty0NYf9ew5kHWajbuoZMhDa9Q0Ymy219G3AflS+kv0f
         KqU9ytL8FItys3tnFX+IY3RiW/xoeczCPwplZQBokkZtm0AmRvQtBkC4cMl+EdqMMoGB
         l4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTSW2R99Gpp3ZPuegti+Wid5K/Ptbn+GS7fhEV9UB7Y=;
        b=tR85wxFyjm1dfzpEIP/e0WFT38rpXAxmP0X428VOqxxk7sXIh5wK2X1QPtaOpHNgVO
         Khw2HytSVlcgOE7As6oKJwTOjQGT/qBZXSHkkGfRoayGhMDldGN0E4cehwZ9QGxQlX94
         yoYT+I6w3xBhCvecqaasp8OSSvzvesoCy13vOxrR29Z+za/XTHRk22Wnbk155/F6rj5q
         FkuLQsGhQMM39rQIHn5EIFSauw6poBf8nUYxQhgksYGJud2EIlObZNgosSxazCZ8sqgN
         rE/kXspxVYDJsNcP2+9YmWozdeRCSZFSRThoCTc0F0CVX9E4veXidlOVo0EvkaxoKkma
         JeKA==
X-Gm-Message-State: APjAAAVUhQEzy8c6JbHFCjhQBYDJgo9Ol4wa59heknNjtlIjahOc7qWr
        u0T1EHlxHTjnfFRbzNulg03R1jdb
X-Google-Smtp-Source: APXvYqzUD+QBkNWh3KVOat2VCtREXWcnmRQSg/BfK4O9ZeWpEgdWlJUoObWNQrzxrgwZs82GN2Jz1w==
X-Received: by 2002:a1c:a615:: with SMTP id p21mr24487519wme.121.1566289751650;
        Tue, 20 Aug 2019 01:29:11 -0700 (PDT)
Received: from [192.168.1.20] (host109-153-59-46.range109-153.btcentralplus.com. [109.153.59.46])
        by smtp.googlemail.com with ESMTPSA id o129sm1838587wmb.41.2019.08.20.01.29.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 01:29:10 -0700 (PDT)
Subject: Re: iwlwifi: microcode SW error detected
From:   Chris Clayton <chris2553@googlemail.com>
To:     LKML <linux-kernel@vger.kernel.org>
References: <42e782e0-78be-b3d4-d222-1a75df35b078@googlemail.com>
 <cdf38da2-def1-cf0d-2d35-f31cc8fe122a@googlemail.com>
Message-ID: <39c672d9-a95e-65d0-82a4-60fa71317f24@googlemail.com>
Date:   Tue, 20 Aug 2019 09:29:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cdf38da2-def1-cf0d-2d35-f31cc8fe122a@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/08/2019 09:21, Chris Clayton wrote:
> 
> 
> On 17/08/2019 08:19, Chris Clayton wrote:
>> Hi.
>>
>> I just found the following error in the output from dmesg.
>>
>> [ 4023.460058] iwlwifi 0000:02:00.0: Microcode SW error detected. Restarting 0x0.
> 
> Since reporting, I've found that this problem is being explored in the thread that starts at
> https://marc.info/?l=linux-kernel&m=156601519111113.

Mmm, that's a dead link. Don't knwo what happened there but the real link is
https://marc.info/?l=linux-kernel&m=156265244614126

> 
> Chris
> 
