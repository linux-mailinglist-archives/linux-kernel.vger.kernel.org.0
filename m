Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494701184E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLJKWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:22:01 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52681 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:21:58 -0500
Received: by mail-wm1-f52.google.com with SMTP id p9so2503352wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSZM3uDVFbgkGr5DOjP7IcHDu8SRtqcHecCMBfj8wdY=;
        b=bk1OjF1VqQtJjMsGBNsVGJdfcBZnseHh4z8BN+rTKQ8xNgG+3ms3U0jzjSAZprHXS4
         cdAbnxNvSHuqozBuZsINgY4wjARPKvOdJhRiu1MmY+KXFjk7PPoZGI6ZQnVExyyDXqsa
         4+j4e2qioxqZS5X2PyxEbpTJQPJY3LiKI9ixESj2gfy0KsqYjPHA2D+XMnhDh2brQSPw
         WiNo33DRyBj8CIcvX0tbN34TJTZL3ndkdszop1nKWxNNC0uJuvwRlweYVy/Frn0+sNwd
         i08Q9zXYdlA1j4farnjdaQ59MAdLAr4xO3IyE/LJxzV58syIYyoLJRaNglN4lXQs0Nuy
         eEEA==
X-Gm-Message-State: APjAAAU4uCU+at0TQA0GI/Pu9dizn3pSsN3yQhPy7RFyboKvPfVonqDa
        tblruliTUDVlAED7LqCq2SQ=
X-Google-Smtp-Source: APXvYqy6ifGo1Gx4DRfjm9s/uVX87SaxM+rvYejqy3++2/RdsMTq7LWzLUAHDAUzgKq0o6g+yDvB7g==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr4339772wme.90.1575973316781;
        Tue, 10 Dec 2019 02:21:56 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id k4sm2629758wmk.26.2019.12.10.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:21:56 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:21:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        akpm@linux-foundation.org
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20191210102155.GD10404@dhcp22.suse.cz>
References: <20191210084413.21957-1-bhe@redhat.com>
 <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
 <429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com>
 <20191210095002.GA10404@dhcp22.suse.cz>
 <20191210101100.GM2984@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210101100.GM2984@MiWiFi-R3L-srv>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 18:11:00, Baoquan He wrote:
> On 12/10/19 at 10:50am, Michal Hocko wrote:
[...]
> > [1] Btw. it would have been much better if you posted the version 2 only
> > after all the feedback got discussed properly.
> 
> You could have replied to wrong person. 
> 
> I don't know the use case David told. My motivation was to make memory hotplug
> not impacted after boot. I thought I have got your question and answered
> it. I will wait a little longer when post next time.

let me reply to your original email.
-- 
Michal Hocko
SUSE Labs
